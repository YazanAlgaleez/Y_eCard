import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../models/merchant_level_model.dart';
import 'app_surface_card.dart';

/// Displays an individual merchant tier with qualification threshold and benefits.
class MerchantLevelTierCard extends StatelessWidget {
  final MerchantLevelModel level;
  final int currentLevelNumber;

  const MerchantLevelTierCard({
    super.key,
    required this.level,
    required this.currentLevelNumber,
  });

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    final isCurrentLevel = level.levelNumber == currentLevelNumber;
    final isUnlocked = level.levelNumber < currentLevelNumber;

    return AppSurfaceCard(
      isSelected: isCurrentLevel,
      padding: EdgeInsets.all(layout.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: level.accentColor.withValues(alpha: 0.16),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.badgeRadius),
                ),
                child: Icon(
                  level.icon,
                  color: level.accentColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      level.monthlyTargetLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimensions.smallSpacing),
              Flexible(
                child: _TierStatusBadge(
                  isCurrentLevel: isCurrentLevel,
                  isUnlocked: isUnlocked,
                  discountLabel: level.discountLabel,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          ...level.benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: isCurrentLevel || isUnlocked
                          ? AppColors.emeraldMint
                          : level.accentColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      benefit,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TierStatusBadge extends StatelessWidget {
  final bool isCurrentLevel;
  final bool isUnlocked;
  final String discountLabel;

  const _TierStatusBadge({
    required this.isCurrentLevel,
    required this.isUnlocked,
    required this.discountLabel,
  });

  @override
  Widget build(BuildContext context) {
    final Color badgeColor;
    final String badgeText;

    if (isCurrentLevel) {
      badgeColor = AppColors.primaryViolet;
      badgeText = 'الحالي • $discountLabel';
    } else if (isUnlocked) {
      badgeColor = AppColors.emeraldMint;
      badgeText = 'مفتوح';
    } else {
      badgeColor = AppColors.accentAmber;
      badgeText = discountLabel;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
      ),
      child: Text(
        badgeText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
}
