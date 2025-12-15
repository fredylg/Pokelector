class CollectionEntry {
  final String userId;
  final String cardId;
  final int quantity;
  final String? variant;
  final String? setId;
  final String? rarity;
  final String? type;
  final DateTime? updatedAt;

  const CollectionEntry({
    required this.userId,
    required this.cardId,
    required this.quantity,
    this.variant,
    this.setId,
    this.rarity,
    this.type,
    this.updatedAt,
  });

  factory CollectionEntry.fromJson(Map<String, dynamic> json) {
    return CollectionEntry(
      userId: json['userId'] ?? '',
      cardId: json['cardId'] ?? '',
      quantity: json['quantity'] ?? 1,
      variant: json['variant'],
      setId: json['setId'],
      rarity: json['rarity'],
      type: json['type'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cardId': cardId,
      'quantity': quantity,
      'variant': variant,
      'setId': setId,
      'rarity': rarity,
      'type': type,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  CollectionEntry copyWith({
    String? userId,
    String? cardId,
    int? quantity,
    String? variant,
    String? setId,
    String? rarity,
    String? type,
    DateTime? updatedAt,
  }) {
    return CollectionEntry(
      userId: userId ?? this.userId,
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      setId: setId ?? this.setId,
      rarity: rarity ?? this.rarity,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
