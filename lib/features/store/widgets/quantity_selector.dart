import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';

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
        const SizedBox(height: AppDimensions.smallSpacing),
        Row(
          children: quantityOptions.map((quantityOption) {
            final isSelected = selectedQuantity == quantityOption;

            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => onQuantitySelected(quantityOption),
                borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
                child: Container(
                  width: 44,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryViolet
                        : inactiveBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.badgeRadius),
                  ),
                  child: Center(
                    child: Text(
                      '$quantityOption',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.pureWhite : null,
                      ),
                    ),
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
