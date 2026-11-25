import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';

/// Horizontal selector for product store regions when multiple regions exist.
class RegionSelectorBar extends StatelessWidget {
  final List<String> regions;
  final String selectedRegion;
  final ValueChanged<String> onRegionSelected;

  const RegionSelectorBar({
    super.key,
    required this.regions,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveBackground =
        isDark ? AppColors.darkElevatedSurface : AppColors.lightElevatedSurface;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: regions.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppDimensions.smallSpacing),
        itemBuilder: (context, index) {
          final region = regions[index];
          final isSelected = selectedRegion == region;

          return InkWell(
            onTap: () => onRegionSelected(region),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryViolet.withValues(alpha: 0.2)
                    : inactiveBackground,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryViolet
                      : Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  region,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.primaryViolet : null,
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
