class AppUser {
  final String id;

  String get uid => id;
  final String? displayName;
  final String? email;
  final String? preferredFormat;
  final Map<String, dynamic>? analysisWeights;
  final ScanCredits? scanCredits;
  final Map<String, dynamic>? consents;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  AppUser({
    required this.id,
    this.displayName,
    this.email,
    this.preferredFormat = 'standard',
    this.analysisWeights,
    this.scanCredits,
    this.consents,
    this.createdAt,
    this.lastLoginAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      displayName: json['displayName'],
      email: json['email'],
      preferredFormat: json['preferredFormat'] ?? 'standard',
      analysisWeights: json['analysisWeights'],
      scanCredits: json['scanCredits'] != null
          ? ScanCredits.fromJson(json['scanCredits'])
          : null,
      consents: json['consents'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'preferredFormat': preferredFormat,
      'analysisWeights': analysisWeights,
      'scanCredits': scanCredits?.toJson(),
      'consents': consents,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  AppUser copyWith({
    String? id,
    String? displayName,
    String? email,
    String? preferredFormat,
    Map<String, dynamic>? analysisWeights,
    ScanCredits? scanCredits,
    Map<String, dynamic>? consents,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      preferredFormat: preferredFormat ?? this.preferredFormat,
      analysisWeights: analysisWeights ?? this.analysisWeights,
      scanCredits: scanCredits ?? this.scanCredits,
      consents: consents ?? this.consents,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}

class ScanCredits {
  final int balance;
  final DateTime? monthlyResetAt;
  final String plan;

  const ScanCredits({
    required this.balance,
    this.monthlyResetAt,
    this.plan = 'free',
  });

  factory ScanCredits.fromJson(Map<String, dynamic> json) {
    return ScanCredits(
      balance: json['balance'] ?? 0,
      monthlyResetAt: json['monthlyResetAt'] != null
          ? DateTime.parse(json['monthlyResetAt'])
          : null,
      plan: json['plan'] ?? 'free',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'monthlyResetAt': monthlyResetAt?.toIso8601String(),
      'plan': plan,
    };
  }

  ScanCredits copyWith({
    int? balance,
    DateTime? monthlyResetAt,
    String? plan,
  }) {
    return ScanCredits(
      balance: balance ?? this.balance,
      monthlyResetAt: monthlyResetAt ?? this.monthlyResetAt,
      plan: plan ?? this.plan,
    );
  }
}
