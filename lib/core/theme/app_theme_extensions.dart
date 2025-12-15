import 'package:flutter/material.dart';

/// Custom theme extension for Pokelector app
/// Provides spacing, sizing, and layout values referenced in UX specifications
class AppThemeExtensions extends ThemeExtension<AppThemeExtensions> {
  /// Spacing values (as per UX specs: 8dp tight, 16dp standard, 24dp loose)
  final double spacingTight;
  final double spacingStandard;
  final double spacingLoose;

  /// Component spacing for grid views
  final double gridSpacing;

  /// Icon sizes (as per UX specs: 18dp small, 24dp standard, 32dp large)
  final double iconSmall;
  final double iconStandard;
  final double iconLarge;

  /// Touch target minimum size (as per UX specs: 48dp × 48dp)
  final double touchTargetMin;

  /// List item minimum height (as per UX specs: 72dp with images)
  final double listItemHeightMin;
  final double listItemHeightWithImage;

  /// Screen padding values (as per UX specs: 16dp horizontal, 8dp vertical)
  final EdgeInsets screenPadding;

  /// Card border radius (as per UX specs: 12dp)
  final double cardBorderRadius;

  /// Chip border radius (as per UX specs: 8dp)
  final double chipBorderRadius;

  /// Dialog border radius (as per UX specs: 24dp)
  final double dialogBorderRadius;

  const AppThemeExtensions({
    required this.spacingTight,
    required this.spacingStandard,
    required this.spacingLoose,
    required this.gridSpacing,
    required this.iconSmall,
    required this.iconStandard,
    required this.iconLarge,
    required this.touchTargetMin,
    required this.listItemHeightMin,
    required this.listItemHeightWithImage,
    required this.screenPadding,
    required this.cardBorderRadius,
    required this.chipBorderRadius,
    required this.dialogBorderRadius,
  });

  /// Default light theme extensions
  static const AppThemeExtensions light = AppThemeExtensions(
    spacingTight: 8.0,
    spacingStandard: 16.0,
    spacingLoose: 24.0,
    gridSpacing: 8.0,
    iconSmall: 18.0,
    iconStandard: 24.0,
    iconLarge: 32.0,
    touchTargetMin: 48.0,
    listItemHeightMin: 48.0,
    listItemHeightWithImage: 72.0,
    screenPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    cardBorderRadius: 12.0,
    chipBorderRadius: 8.0,
    dialogBorderRadius: 24.0,
  );

  /// Default dark theme extensions (same values as light)
  static const AppThemeExtensions dark = AppThemeExtensions(
    spacingTight: 8.0,
    spacingStandard: 16.0,
    spacingLoose: 24.0,
    gridSpacing: 8.0,
    iconSmall: 18.0,
    iconStandard: 24.0,
    iconLarge: 32.0,
    touchTargetMin: 48.0,
    listItemHeightMin: 48.0,
    listItemHeightWithImage: 72.0,
    screenPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    cardBorderRadius: 12.0,
    chipBorderRadius: 8.0,
    dialogBorderRadius: 24.0,
  );

  @override
  ThemeExtension<AppThemeExtensions> copyWith({
    double? spacingTight,
    double? spacingStandard,
    double? spacingLoose,
    double? gridSpacing,
    double? iconSmall,
    double? iconStandard,
    double? iconLarge,
    double? touchTargetMin,
    double? listItemHeightMin,
    double? listItemHeightWithImage,
    EdgeInsets? screenPadding,
    double? cardBorderRadius,
    double? chipBorderRadius,
    double? dialogBorderRadius,
  }) {
    return AppThemeExtensions(
      spacingTight: spacingTight ?? this.spacingTight,
      spacingStandard: spacingStandard ?? this.spacingStandard,
      spacingLoose: spacingLoose ?? this.spacingLoose,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      iconSmall: iconSmall ?? this.iconSmall,
      iconStandard: iconStandard ?? this.iconStandard,
      iconLarge: iconLarge ?? this.iconLarge,
      touchTargetMin: touchTargetMin ?? this.touchTargetMin,
      listItemHeightMin: listItemHeightMin ?? this.listItemHeightMin,
      listItemHeightWithImage:
          listItemHeightWithImage ?? this.listItemHeightWithImage,
      screenPadding: screenPadding ?? this.screenPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      chipBorderRadius: chipBorderRadius ?? this.chipBorderRadius,
      dialogBorderRadius: dialogBorderRadius ?? this.dialogBorderRadius,
    );
  }

  @override
  ThemeExtension<AppThemeExtensions> lerp(
    ThemeExtension<AppThemeExtensions>? other,
    double t,
  ) {
    if (other is! AppThemeExtensions) {
      return this;
    }

    return AppThemeExtensions(
      spacingTight: _lerpDouble(spacingTight, other.spacingTight, t),
      spacingStandard: _lerpDouble(spacingStandard, other.spacingStandard, t),
      spacingLoose: _lerpDouble(spacingLoose, other.spacingLoose, t),
      gridSpacing: _lerpDouble(gridSpacing, other.gridSpacing, t),
      iconSmall: _lerpDouble(iconSmall, other.iconSmall, t),
      iconStandard: _lerpDouble(iconStandard, other.iconStandard, t),
      iconLarge: _lerpDouble(iconLarge, other.iconLarge, t),
      touchTargetMin: _lerpDouble(touchTargetMin, other.touchTargetMin, t),
      listItemHeightMin: _lerpDouble(listItemHeightMin, other.listItemHeightMin, t),
      listItemHeightWithImage: _lerpDouble(listItemHeightWithImage, other.listItemHeightWithImage, t),
      screenPadding: EdgeInsets.lerp(screenPadding, other.screenPadding, t) ?? screenPadding,
      cardBorderRadius: _lerpDouble(cardBorderRadius, other.cardBorderRadius, t),
      chipBorderRadius: _lerpDouble(chipBorderRadius, other.chipBorderRadius, t),
      dialogBorderRadius: _lerpDouble(dialogBorderRadius, other.dialogBorderRadius, t),
    );
  }

  /// Helper method to lerp double values
  static double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

/// Extension to easily access theme extensions
extension ThemeExtensionsGetter on ThemeData {
  AppThemeExtensions get appExtensions =>
      extension<AppThemeExtensions>() ?? AppThemeExtensions.light;
}

