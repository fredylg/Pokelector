class Deck {
  final String id;
  final String userId;
  final String name;
  final String format;
  final List<DeckCard> cards;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final List<String>? tags;

  const Deck({
    required this.id,
    required this.userId,
    required this.name,
    required this.cards,
    this.format = 'standard',
    this.createdAt,
    this.updatedAt,
    this.notes,
    this.tags,
  });

  int get totalCards => cards.fold(0, (sum, card) => sum + card.quantity);
  bool get isValidDeck => totalCards == 60;

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      format: json['format'] ?? 'standard',
      cards: json['cards'] != null
          ? (json['cards'] as List).map((card) => DeckCard.fromJson(card)).toList()
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      notes: json['notes'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'format': format,
      'cards': cards.map((card) => card.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
      'tags': tags,
    };
  }

  Deck copyWith({
    String? id,
    String? userId,
    String? name,
    String? format,
    List<DeckCard>? cards,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    List<String>? tags,
  }) {
    return Deck(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      format: format ?? this.format,
      cards: cards ?? this.cards,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
    );
  }
}

class DeckCard {
  final String cardId;
  final int quantity;

  const DeckCard({
    required this.cardId,
    required this.quantity,
  });

  factory DeckCard.fromJson(Map<String, dynamic> json) {
    return DeckCard(
      cardId: json['cardId'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'quantity': quantity,
    };
  }

  DeckCard copyWith({
    String? cardId,
    int? quantity,
  }) {
    return DeckCard(
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
    );
  }
}

class DeckValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  const DeckValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;
}
