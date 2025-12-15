import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_theme_extensions.dart';

/// Pokelector App Theme
/// Material Design 3 implementation based on UX specifications in prompts/app_ux_specs.md
///
/// Key design principles from UX specs:
/// - Primary Color: Deep Blue (#1976D2) - Strategy and reliability
/// - Secondary Color: Electric Yellow (#FFC107) - Energy/action elements
/// - Tertiary Color: Red (#D32F2F) - Fire-type and urgent actions
/// - Typography: Roboto font family with Material Design 3 scale
/// - Component Styling: 12dp border radius for cards, 8dp for chips, 24dp for dialogs
/// - Spacing: 8dp (tight), 16dp (standard), 24dp (loose)
/// - Touch Targets: Minimum 48dp × 48dp for accessibility
/// - Icon Sizes: 18dp (small), 24dp (standard), 32dp (large)
/// - Dark/Light mode support with automatic system theme detection
class AppTheme {
  AppTheme._();

  /// Light Theme
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryYellow,
      tertiary: AppColors.tertiaryRed,
      error: AppColors.error,
      surface: AppColors.surfaceLight,
      surfaceContainerHighest: AppColors.surfaceVariantLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      fontFamily: AppTypography.fontFamily,

      // App Bar Theme
      // UX Spec: Elevation 0, title in Title Large (22sp), icon size 24dp
      // Action icons with 60% opacity for secondary emphasis
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: colorScheme.onSurface.withOpacity(0.6),
          size: 24,
        ),
      ),

      // Card Theme
      // UX Spec: Border radius 12dp, elevation 1 (resting), elevation 3 (hover/pressed)
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        shadowColor: colorScheme.shadow,
      ),

      // Filled Button Theme
      // UX Spec: Primary actions, minimum 48dp height, 12dp border radius
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Outlined Button Theme
      // UX Spec: Secondary actions, minimum 48dp height, 12dp border radius
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Text Button Theme
      // UX Spec: Tertiary actions, minimum 48dp height, 12dp border radius
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Input Decoration Theme (TextField)
      // UX Spec: Filled variant, 16dp horizontal padding, 12dp border radius
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
      ),

      // Navigation Bar Theme (Bottom Navigation)
      // UX Spec: 4 destinations, icon size 24dp, label 11sp (labelSmall)
      // Selected: Primary color, Unselected: onSurface with 60% opacity
      navigationBarTheme: NavigationBarThemeData(
        elevation: 8,
        height: 80,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
            );
          }
          return AppTypography.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colorScheme.primary,
              size: 24,
            );
          }
          return IconThemeData(
            color: colorScheme.onSurface.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      // Chip Theme
      // UX Spec: Border radius 8dp, used for FilterChip and ActionChip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: AppTypography.textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // Dialog Theme
      // UX Spec: Border radius 24dp, max width 560dp, elevation 24dp
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 24,
        titleTextStyle: AppTypography.textTheme.headlineSmall,
        contentTextStyle: AppTypography.textTheme.bodyMedium,
      ),

      // Floating Action Button Theme
      // UX Spec: Elevation 6dp (resting), 12dp (pressed)
      // Standard: 56dp × 56dp, Small: 40dp × 40dp, Large: 96dp × 96dp
      // Icon sizes: 24dp (standard), 18dp (small), 36dp (large)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        iconSize: 24,
        sizeConstraints: const BoxConstraints.tightFor(
          width: 56,
          height: 56,
        ),
        smallSizeConstraints: const BoxConstraints.tightFor(
          width: 40,
          height: 40,
        ),
        largeSizeConstraints: const BoxConstraints.tightFor(
          width: 96,
          height: 96,
        ),
      ),

      // Icon Theme
      // UX Spec: Standard size 24dp, color onSurface
      // Secondary actions use 60% opacity (applied via actionsIconTheme)
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),

      // List Tile Theme
      // UX Spec: Minimum 48dp height (touch target), 72dp with images
      // Leading icons: 24dp with 60% opacity, Selected: primaryContainer background
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 12,
        minLeadingWidth: 24,
        iconColor: colorScheme.onSurface.withOpacity(0.6),
        textColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.primaryContainer,
        selectedColor: colorScheme.onPrimaryContainer,
      ),

      // Divider Theme
      // UX Spec: 1dp height, onSurface with 12% opacity
      dividerTheme: DividerThemeData(
        color: colorScheme.onSurface.withOpacity(0.12),
        thickness: 1,
        space: 1,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        elevation: 16,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),

      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(16),
          ),
        ),
      ),

      // Tab Bar Theme
      // UX Spec: Indicator height 3dp, Primary color indicator
      // Label: onSurface (selected), onSurface 60% (unselected)
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface.withOpacity(0.6),
        labelStyle: AppTypography.textTheme.labelLarge,
        unselectedLabelStyle: AppTypography.textTheme.labelLarge,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 3,
          ),
        ),
      ),

      // Popup Menu Theme
      // UX Spec: Elevation 8dp, border radius 4dp, padding 8dp vertical
      // Minimum item height 48dp (touch target)
      popupMenuTheme: PopupMenuThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: colorScheme.surface,
        textStyle: AppTypography.textTheme.bodyLarge,
      ),

      // Badge Theme
      // UX Spec: Used for notification dots (e.g., Scanner tab credits < 5)
      // Small: 8dp, Large: 16dp
      badgeTheme: BadgeThemeData(
        backgroundColor: AppColors.badgeError,
        textColor: Colors.white,
        smallSize: 8,
        largeSize: 16,
        textStyle: AppTypography.textTheme.labelSmall?.copyWith(
          color: Colors.white,
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        waitDuration: const Duration(milliseconds: 500),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withOpacity(0.5);
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface.withOpacity(0.6);
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withOpacity(0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),

      // Segmented Button Theme
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.secondaryContainer;
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.onSecondaryContainer;
            }
            return colorScheme.onSurface;
          }),
        ),
      ),

      // Icon Button Theme
      // UX Spec: Touch target minimum 48dp × 48dp, icon size 24dp
      // Icon color: onSurface with 60% opacity for secondary actions
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(48, 48)),
          iconSize: WidgetStateProperty.all(24),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.38);
            }
            return colorScheme.onSurface.withOpacity(0.6);
          }),
        ),
      ),
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryYellow,
      tertiary: AppColors.tertiaryRed,
      error: AppColors.error,
      surface: AppColors.surfaceDark,
      surfaceContainerHighest: AppColors.surfaceVariantDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      fontFamily: AppTypography.fontFamily,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtensions.dark,
      ],

      // App Bar Theme
      // UX Spec: Elevation 0, title in Title Large (22sp), icon size 24dp
      // Action icons with 60% opacity for secondary emphasis
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: colorScheme.onSurface.withOpacity(0.6),
          size: 24,
        ),
      ),

      // Card Theme
      // UX Spec: Border radius 12dp, elevation 1 (resting), elevation 3 (hover/pressed)
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        shadowColor: colorScheme.shadow,
      ),

      // Filled Button Theme
      // UX Spec: Primary actions, minimum 48dp height, 12dp border radius
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Outlined Button Theme
      // UX Spec: Secondary actions, minimum 48dp height, 12dp border radius
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Text Button Theme
      // UX Spec: Tertiary actions, minimum 48dp height, 12dp border radius
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      // Input Decoration Theme (TextField)
      // UX Spec: Filled variant, 16dp horizontal padding, 12dp border radius
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
      ),

      // Navigation Bar Theme (Bottom Navigation)
      // UX Spec: 4 destinations, icon size 24dp, label 11sp (labelSmall)
      // Selected: Primary color, Unselected: onSurface with 60% opacity
      navigationBarTheme: NavigationBarThemeData(
        elevation: 8,
        height: 80,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
            );
          }
          return AppTypography.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colorScheme.primary,
              size: 24,
            );
          }
          return IconThemeData(
            color: colorScheme.onSurface.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      // Chip Theme
      // UX Spec: Border radius 8dp, used for FilterChip and ActionChip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: AppTypography.textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // Dialog Theme
      // UX Spec: Border radius 24dp, max width 560dp, elevation 24dp
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 24,
        titleTextStyle: AppTypography.textTheme.headlineSmall,
        contentTextStyle: AppTypography.textTheme.bodyMedium,
      ),

      // Floating Action Button Theme
      // UX Spec: Elevation 6dp (resting), 12dp (pressed)
      // Standard: 56dp × 56dp, Small: 40dp × 40dp, Large: 96dp × 96dp
      // Icon sizes: 24dp (standard), 18dp (small), 36dp (large)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        iconSize: 24,
        sizeConstraints: const BoxConstraints.tightFor(
          width: 56,
          height: 56,
        ),
        smallSizeConstraints: const BoxConstraints.tightFor(
          width: 40,
          height: 40,
        ),
        largeSizeConstraints: const BoxConstraints.tightFor(
          width: 96,
          height: 96,
        ),
      ),

      // Icon Theme
      // UX Spec: Standard size 24dp, color onSurface
      // Secondary actions use 60% opacity (applied via actionsIconTheme)
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: 24,
      ),

      // List Tile Theme
      // UX Spec: Minimum 48dp height (touch target), 72dp with images
      // Leading icons: 24dp with 60% opacity, Selected: primaryContainer background
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 12,
        minLeadingWidth: 24,
        iconColor: colorScheme.onSurface.withOpacity(0.6),
        textColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.primaryContainer,
        selectedColor: colorScheme.onPrimaryContainer,
      ),

      // Divider Theme
      // UX Spec: 1dp height, onSurface with 12% opacity
      dividerTheme: DividerThemeData(
        color: colorScheme.onSurface.withOpacity(0.12),
        thickness: 1,
        space: 1,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        elevation: 16,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),

      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(16),
          ),
        ),
      ),

      // Tab Bar Theme
      // UX Spec: Indicator height 3dp, Primary color indicator
      // Label: onSurface (selected), onSurface 60% (unselected)
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface.withOpacity(0.6),
        labelStyle: AppTypography.textTheme.labelLarge,
        unselectedLabelStyle: AppTypography.textTheme.labelLarge,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 3,
          ),
        ),
      ),

      // Popup Menu Theme
      // UX Spec: Elevation 8dp, border radius 4dp, padding 8dp vertical
      // Minimum item height 48dp (touch target)
      popupMenuTheme: PopupMenuThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: colorScheme.surface,
        textStyle: AppTypography.textTheme.bodyLarge,
      ),

      // Badge Theme
      // UX Spec: Used for notification dots (e.g., Scanner tab credits < 5)
      // Small: 8dp, Large: 16dp
      badgeTheme: BadgeThemeData(
        backgroundColor: AppColors.badgeError,
        textColor: Colors.white,
        smallSize: 8,
        largeSize: 16,
        textStyle: AppTypography.textTheme.labelSmall?.copyWith(
          color: Colors.white,
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        waitDuration: const Duration(milliseconds: 500),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withOpacity(0.5);
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface.withOpacity(0.6);
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withOpacity(0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.bodySmall?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),

      // Segmented Button Theme
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.secondaryContainer;
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.onSecondaryContainer;
            }
            return colorScheme.onSurface;
          }),
        ),
      ),

      // Icon Button Theme
      // UX Spec: Touch target minimum 48dp × 48dp, icon size 24dp
      // Icon color: onSurface with 60% opacity for secondary actions
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(48, 48)),
          iconSize: WidgetStateProperty.all(24),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.38);
            }
            return colorScheme.onSurface.withOpacity(0.6);
          }),
        ),
      ),
    );
  }
}
