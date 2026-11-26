import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import 'app_surface_card.dart';

/// Displays the merchant's current tier status and progress toward the next level.
class MerchantLevelProgressCard extends StatelessWidget {
  final String currentTierLabel;
  final String nextTierLabel;
  final double progress;
  final double currentSales;
  final double targetSales;
  final String currencyLabel;

  const MerchantLevelProgressCard({
    super.key,
    required this.currentTierLabel,
    required this.nextTierLabel,
    required this.progress,
    required this.currentSales,
    required this.targetSales,
    required this.currencyLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final layout = ResponsiveLayout.of(context);
    final percentage = (progress * 100).round();
    final remainingAmount = (targetSales - currentSales).clamp(0.0, targetSales);

    return AppSurfaceCard(
      padding: EdgeInsets.all(layout.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryViolet.withValues(alpha: 0.15),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.badgeRadius),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.primaryViolet,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppDimensions.itemSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المستوى الحالي',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      currentTierLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimensions.smallSpacing),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.emeraldMint.withValues(alpha: 0.16),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.badgeRadius),
                ),
                child: Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.emeraldMint,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: layout.itemSpacing),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor:
                  isDark ? AppColors.darkBorder : AppColors.lightBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryViolet,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'متبقي ${remainingAmount.toStringAsFixed(0)} $currencyLabel للوصول إلى $nextTierLabel',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(width: AppDimensions.smallSpacing),
              Flexible(
                flex: 2,
                child: Text(
                  '${currentSales.toStringAsFixed(0)} / ${targetSales.toStringAsFixed(0)} $currencyLabel',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
