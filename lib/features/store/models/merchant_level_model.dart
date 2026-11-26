import 'package:flutter/material.dart';

/// Represents a merchant tier with its qualification threshold and benefits.
class MerchantLevelModel {
  final int levelNumber;
  final String title;
  final String discountLabel;
  final String monthlyTargetLabel;
  final List<String> benefits;
  final IconData icon;
  final Color accentColor;

  const MerchantLevelModel({
    required this.levelNumber,
    required this.title,
    required this.discountLabel,
    required this.monthlyTargetLabel,
    required this.benefits,
    required this.icon,
    required this.accentColor,
  });
}
