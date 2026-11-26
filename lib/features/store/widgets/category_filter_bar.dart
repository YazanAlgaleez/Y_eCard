import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';

/// Horizontal scrollable category filter chips for the product catalog.
class CategoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveBackground =
        isDark ? AppColors.darkElevatedSurface : AppColors.lightElevatedSurface;

    return SizedBox(
      height: ResponsiveLayout.of(context).filterBarHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppDimensions.smallSpacing),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return InkWell(
            onTap: () => onCategorySelected(category),
            borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryViolet
                    : inactiveBackground,
                borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.pureWhite : null,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
