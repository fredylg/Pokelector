class PokemonCard {
  final String id;
  final String name;
  final String? supertype;
  final List<String>? subtypes;
  final List<String>? types;
  final Map<String, dynamic>? images;
  final Map<String, dynamic>? legalities;
  final String? rarity;
  final Map<String, dynamic>? set;
  final String? rulesText;
  final List<Map<String, dynamic>>? abilities;
  final List<Map<String, dynamic>>? attacks;
  final DateTime? updatedAt;

  const PokemonCard({
    required this.id,
    required this.name,
    this.supertype,
    this.subtypes,
    this.types,
    this.images,
    this.legalities,
    this.rarity,
    this.set,
    this.rulesText,
    this.abilities,
    this.attacks,
    this.updatedAt,
  });

  String get smallImageUrl => images?['small'] ?? '';
  String get largeImageUrl => images?['large'] ?? '';

  bool get isStandardLegal => legalities?['standard'] == 'Legal';
  bool get isExpandedLegal => legalities?['expanded'] == 'Legal';

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      supertype: json['supertype'],
      subtypes: List<String>.from(json['subtypes'] ?? []),
      types: List<String>.from(json['types'] ?? []),
      images: json['images'],
      legalities: json['legalities'],
      rarity: json['rarity'],
      set: json['set'],
      rulesText: json['rulesText'],
      abilities: json['abilities'] != null
          ? List<Map<String, dynamic>>.from(json['abilities'])
          : null,
      attacks: json['attacks'] != null
          ? List<Map<String, dynamic>>.from(json['attacks'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supertype': supertype,
      'subtypes': subtypes,
      'types': types,
      'images': images,
      'legalities': legalities,
      'rarity': rarity,
      'set': set,
      'rulesText': rulesText,
      'abilities': abilities,
      'attacks': attacks,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  PokemonCard copyWith({
    String? id,
    String? name,
    String? supertype,
    List<String>? subtypes,
    List<String>? types,
    Map<String, dynamic>? images,
    Map<String, dynamic>? legalities,
    String? rarity,
    Map<String, dynamic>? set,
    String? rulesText,
    List<Map<String, dynamic>>? abilities,
    List<Map<String, dynamic>>? attacks,
    DateTime? updatedAt,
  }) {
    return PokemonCard(
      id: id ?? this.id,
      name: name ?? this.name,
      supertype: supertype ?? this.supertype,
      subtypes: subtypes ?? this.subtypes,
      types: types ?? this.types,
      images: images ?? this.images,
      legalities: legalities ?? this.legalities,
      rarity: rarity ?? this.rarity,
      set: set ?? this.set,
      rulesText: rulesText ?? this.rulesText,
      abilities: abilities ?? this.abilities,
      attacks: attacks ?? this.attacks,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
