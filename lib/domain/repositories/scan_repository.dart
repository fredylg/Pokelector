import '../entities/scan.dart';

abstract class ScanRepository {
  /// Check if user has scan credits
  Future<bool> hasScanCredits(String userId);

  /// Get user's scan credit balance
  Future<int> getScanCreditBalance(String userId);

  /// Deduct scan credit (server-side)
  Future<bool> deductScanCredit(String userId, String scanId);

  /// Process image scan
  Future<ScanResult> processScan(String userId, String imagePath, {String source = 'camera'});

  /// Get scan history
  Future<List<ScanResult>> getScanHistory(String userId, {int limit = 50});

  /// Get specific scan result
  Future<ScanResult?> getScanResult(String scanId);

  /// Delete scan result
  Future<void> deleteScanResult(String scanId);

  /// Upload scan image to temporary storage
  Future<String> uploadScanImage(String userId, String imagePath);

  /// Clean up temporary scan images
  Future<void> cleanupTemporaryImages(String userId);
}
