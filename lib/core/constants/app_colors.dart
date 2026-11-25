import 'package:flutter/material.dart';

/// Raw color tokens for brand identity and light/dark surfaces.
abstract final class AppColors {
  // Brand colors
  static const Color primaryViolet = Color(0xFF7C3AED);
  static const Color emeraldMint = Color(0xFF10B981);
  static const Color pureWhite = Color(0xFFFFFFFF);

  // Dark theme palette
  static const Color darkBackground = Color(0xFF0B0E14);
  static const Color darkSurface = Color(0xFF141923);
  static const Color darkElevatedSurface = Color(0xFF1C2331);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF263042);

  // Light theme palette
  static const Color lightBackground = Color(0xFFF4F6FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightElevatedSurface = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Product category accents
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentRose = Color(0xFFE11D48);
}
