import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';

/// Quick quantity selector pills for product orders.
class QuantitySelector extends StatelessWidget {
  final List<int> quantityOptions;
  final int selectedQuantity;
  final ValueChanged<int> onQuantitySelected;

  const QuantitySelector({
    super.key,
    required this.quantityOptions,
    required this.selectedQuantity,
    required this.onQuantitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final layout = ResponsiveLayout.of(context);
    final inactiveBackground =
        isDark ? AppColors.darkElevatedSurface : AppColors.lightElevatedSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'حدد الكمية',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: layout.smallSpacing),
        Wrap(
          spacing: layout.smallSpacing,
          runSpacing: layout.smallSpacing,
          children: quantityOptions.map((quantityOption) {
            final isSelected = selectedQuantity == quantityOption;

            return InkWell(
              onTap: () => onQuantitySelected(quantityOption),
              borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: layout.quantityPillWidth,
                  minHeight: layout.quantityPillHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryViolet
                        : inactiveBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.badgeRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$quantityOption',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppColors.pureWhite : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
