class ScanResult {
  final String id;
  final String userId;
  final String imagePath;
  final String? recognizedCardId;
  final double confidence;
  final ScanStatus status;
  final String source; // 'camera' or 'gallery'
  final DateTime createdAt;
  final DateTime? processedAt;
  final String? errorMessage;

  const ScanResult({
    required this.id,
    required this.userId,
    required this.imagePath,
    this.recognizedCardId,
    required this.confidence,
    required this.status,
    required this.source,
    required this.createdAt,
    this.processedAt,
    this.errorMessage,
  });

  bool get isSuccessful => status == ScanStatus.success && confidence >= 0.9;
  bool get needsManualReview => status == ScanStatus.success && confidence < 0.9;

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      imagePath: json['imagePath'] ?? '',
      recognizedCardId: json['recognizedCardId'],
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      status: ScanStatus.values[json['status'] ?? 0],
      source: json['source'] ?? 'camera',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt'])
          : null,
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imagePath': imagePath,
      'recognizedCardId': recognizedCardId,
      'confidence': confidence,
      'status': status.index,
      'source': source,
      'createdAt': createdAt.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
      'errorMessage': errorMessage,
    };
  }

  ScanResult copyWith({
    String? id,
    String? userId,
    String? imagePath,
    String? recognizedCardId,
    double? confidence,
    ScanStatus? status,
    String? source,
    DateTime? createdAt,
    DateTime? processedAt,
    String? errorMessage,
  }) {
    return ScanResult(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      recognizedCardId: recognizedCardId ?? this.recognizedCardId,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum ScanStatus {
  pending,
  processing,
  success,
  failed,
  cancelled,
}

class XimilarRecognitionResult {
  final String predictedCardId;
  final double confidence;
  final Map<String, dynamic>? metadata;

  const XimilarRecognitionResult({
    required this.predictedCardId,
    required this.confidence,
    this.metadata,
  });

  factory XimilarRecognitionResult.fromJson(Map<String, dynamic> json) {
    return XimilarRecognitionResult(
      predictedCardId: json['predictedCardId'] ?? '',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictedCardId': predictedCardId,
      'confidence': confidence,
      'metadata': metadata,
    };
  }
}
