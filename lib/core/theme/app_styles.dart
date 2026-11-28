import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Shared spacing, corner radii, and component dimensions.
abstract final class AppDimensions {
  static const double screenHorizontalPadding = 16.0;
  static const double sectionSpacing = 16.0;
  static const double itemSpacing = 12.0;
  static const double smallSpacing = 8.0;
  static const double cardPadding = 14.0;

  static const double cardRadius = 20.0;
  static const double inputRadius = 16.0;
  static const double buttonRadius = 16.0;
  static const double chipRadius = 20.0;
  static const double badgeRadius = 12.0;

  static const double primaryButtonHeight = 50.0;
  static const double secondaryButtonHeight = 48.0;
}

/// Centralized light and dark themes, typography, and component styles.
abstract final class AppStyles {
  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    backgroundColor: AppColors.lightBackground,
    surfaceColor: AppColors.lightSurface,
    primaryTextColor: AppColors.lightTextPrimary,
    secondaryTextColor: AppColors.lightTextSecondary,
    borderColor: AppColors.lightBorder,
  );

  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    backgroundColor: AppColors.darkBackground,
    surfaceColor: AppColors.darkSurface,
    primaryTextColor: AppColors.darkTextPrimary,
    secondaryTextColor: AppColors.darkTextSecondary,
    borderColor: AppColors.darkBorder,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required Color borderColor,
  }) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primaryViolet,
      onPrimary: AppColors.pureWhite,
      secondary: AppColors.emeraldMint,
      onSecondary: AppColors.pureWhite,
      error: AppColors.accentRed,
      onError: AppColors.pureWhite,
      surface: surfaceColor,
      onSurface: primaryTextColor,
      outline: borderColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: AppColors.primaryViolet,
      dividerColor: borderColor,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryViolet),
          foregroundColor: WidgetStateProperty.all(AppColors.pureWhite),
          elevation: WidgetStateProperty.all(0),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, AppDimensions.primaryButtonHeight),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(primaryTextColor),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, AppDimensions.secondaryButtonHeight),
          ),
          side: WidgetStateProperty.all(BorderSide(color: borderColor)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.emeraldMint
              : null,
        ),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.emeraldMint.withValues(alpha: 0.45)
              : null,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 13,
          color: secondaryTextColor,
        ),
        prefixIconColor: secondaryTextColor,
      ),
      iconTheme: IconThemeData(color: primaryTextColor),
      dividerTheme: DividerThemeData(
        color: isDark
            ? AppColors.darkBorder
            : AppColors.lightBorder,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.cardRadius),
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme({
    required Color primaryTextColor,
    required Color secondaryTextColor,
  }) {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
        color: primaryTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        color: primaryTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        color: primaryTextColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: secondaryTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
    );
  }
}
