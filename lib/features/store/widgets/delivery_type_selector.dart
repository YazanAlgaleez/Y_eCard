import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import 'app_surface_card.dart';

/// Segmented control allowing the user to pick between direct Player ID top-up
/// and instant voucher code delivery.
class DeliveryTypeSelector extends StatelessWidget {
  final bool isDirectIdSelected;
  final ValueChanged<bool> onDeliveryTypeChanged;

  const DeliveryTypeSelector({
    super.key,
    required this.isDirectIdSelected,
    required this.onDeliveryTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(4),
      borderRadius: AppDimensions.inputRadius,
      child: Row(
        children: [
          Expanded(
            child: _DeliverySegmentButton(
              label: 'شحن مباشر ID',
              isSelected: isDirectIdSelected,
              onTap: () => onDeliveryTypeChanged(true),
            ),
          ),
          Expanded(
            child: _DeliverySegmentButton(
              label: 'شراء كود',
              isSelected: !isDirectIdSelected,
              onTap: () => onDeliveryTypeChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliverySegmentButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeliverySegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryViolet : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.pureWhite : null,
            ),
          ),
        ),
      ),
    );
  }
}
