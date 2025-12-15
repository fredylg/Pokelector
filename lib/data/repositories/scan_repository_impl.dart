import '../../domain/entities/scan.dart';
import '../../domain/repositories/scan_repository.dart';
import '../datasources/scan_remote_datasource.dart';

class ScanRepositoryImpl implements ScanRepository {
  final ScanRemoteDataSource remoteDataSource;

  ScanRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> hasScanCredits(String userId) {
    return remoteDataSource.hasScanCredits(userId);
  }

  @override
  Future<int> getScanCreditBalance(String userId) {
    return remoteDataSource.getScanCreditBalance(userId);
  }

  @override
  Future<bool> deductScanCredit(String userId, String scanId) {
    return remoteDataSource.deductScanCredit(userId, scanId);
  }

  @override
  Future<ScanResult> processScan(String userId, String imagePath, {String source = 'camera'}) async {
    // Check credits first
    final hasCredits = await hasScanCredits(userId);
    if (!hasCredits) {
      throw Exception('Insufficient scan credits');
    }

    try {
      // Upload image to temporary storage
      final imageUrl = await remoteDataSource.uploadScanImage(userId, imagePath);

      // Recognize card using AI service
      final recognitionResult = await remoteDataSource.recognizeCard(imageUrl);

      // Determine scan status based on confidence
      final status = recognitionResult.confidence >= 0.9
          ? ScanStatus.success
          : recognitionResult.confidence >= 0.5
              ? ScanStatus.success // Still success but needs manual review
              : ScanStatus.failed;

      final scanResult = ScanResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        imagePath: imagePath,
        recognizedCardId: recognitionResult.predictedCardId,
        confidence: recognitionResult.confidence,
        status: status,
        source: source,
        createdAt: DateTime.now(),
        processedAt: DateTime.now(),
        errorMessage: null,
      );

      // Only deduct credits if scan was successful
      if (scanResult.isSuccessful) {
        final creditDeducted = await deductScanCredit(userId, scanResult.id);
        if (!creditDeducted) {
          throw Exception('Failed to deduct scan credit');
        }
      }

      return scanResult;
    } catch (e) {
      // Create failed scan result
      return ScanResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        imagePath: imagePath,
        confidence: 0.0,
        status: ScanStatus.failed,
        source: source,
        createdAt: DateTime.now(),
        processedAt: DateTime.now(),
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<List<ScanResult>> getScanHistory(String userId, {int limit = 50}) async {
    // TODO: Implement scan history retrieval
    // This would require storing scan results in Firestore
    return [];
  }

  @override
  Future<ScanResult?> getScanResult(String scanId) async {
    // TODO: Implement scan result retrieval by ID
    return null;
  }

  @override
  Future<void> deleteScanResult(String scanId) async {
    // TODO: Implement scan result deletion
  }

  @override
  Future<String> uploadScanImage(String userId, String imagePath) {
    return remoteDataSource.uploadScanImage(userId, imagePath);
  }

  @override
  Future<void> cleanupTemporaryImages(String userId) async {
    // TODO: Implement cleanup of temporary images
    // This would involve listing and deleting old images from Firebase Storage
  }
}
