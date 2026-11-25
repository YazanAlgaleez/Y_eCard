import 'package:flutter/material.dart';

/// Represents a digital card or game top-up product in the store catalog.
class ProductModel {
  final String title;
  final String badge;
  final String? regionNote;
  final String category;
  final IconData icon;
  final Color accentColor;
  final bool supportsDirectId;
  final bool supportsVoucherCode;
  final List<String> regions;

  const ProductModel({
    required this.title,
    required this.badge,
    this.regionNote,
    required this.category,
    required this.icon,
    required this.accentColor,
    this.supportsDirectId = true,
    this.supportsVoucherCode = true,
    this.regions = const ['عالمي / GL'],
  });
}
