import 'package:flutter/material.dart';

/// Pokelector App Color Definitions
/// Based on Material Design 3 color system
class AppColors {
  AppColors._();

  // Primary Color - Deep Blue (Strategy and Reliability)
  static const Color primaryBlue = Color(0xFF1976D2); // Material Blue 700

  // Secondary Color - Electric Yellow (Energy/Action)
  static const Color secondaryYellow = Color(0xFFC107); // Material Amber 500

  // Tertiary Color - Red (Fire-type and Urgent Actions)
  static const Color tertiaryRed = Color(0xFFD32F2F); // Material Red 700

  // Semantic Colors
  static const Color error = Color(0xFFF44336); // Material Red 500
  static const Color success = Color(0xFF4CAF50); // Material Green 500
  static const Color warning = Color(0xFFFF9800); // Material Orange 500

  // Light Mode Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF5F5F5);
  static const Color backgroundLight = Color(0xFFFAFAFA);

  // Dark Mode Surface Colors
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceVariantDark = Color(0xFF1E1E1E);
  static const Color backgroundDark = Color(0xFF000000);

  // Text Colors - Auto-adjusted by Material 3
  // onSurface, onPrimary, onSecondary, etc. are handled by ColorScheme

  // Type-specific colors for Pokémon cards
  static const Map<String, Color> typeColors = {
    'Fire': Color(0xFFD32F2F),
    'Water': Color(0xFF1976D2),
    'Grass': Color(0xFF388E3C),
    'Electric': Color(0xFFFFC107),
    'Psychic': Color(0xFF7B1FA2),
    'Fighting': Color(0xFFD84315),
    'Darkness': Color(0xFF424242),
    'Metal': Color(0xFF757575),
    'Fairy': Color(0xFFEC407A),
    'Dragon': Color(0xFF5E35B1),
    'Colorless': Color(0xFF9E9E9E),
  };

  // Rarity colors for card badges
  static const Map<String, Color> rarityColors = {
    'Common': Color(0xFF757575),
    'Uncommon': Color(0xFF388E3C),
    'Rare': Color(0xFF1976D2),
    'Ultra Rare': Color(0xFF7B1FA2),
    'Secret Rare': Color(0xFFFFD700),
  };
}
