import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_layout.dart';
import 'app_surface_card.dart';

/// Displays the user's wallet balance and merchant tier progress side by side.
class WalletSummaryRow extends StatelessWidget {
  final String balanceLabel;
  final String tierLabel;
  final double tierProgress;
  final VoidCallback? onTopUpTap;
  final VoidCallback? onTierTap;

  const WalletSummaryRow({
    super.key,
    required this.balanceLabel,
    required this.tierLabel,
    required this.tierProgress,
    this.onTopUpTap,
    this.onTierTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final layout = ResponsiveLayout.of(context);
    final cardPadding = EdgeInsets.all(layout.cardPadding);
    final stackVertically = layout.isUltraCompactWidth ||
        (layout.isCompactWidth && layout.clampedTextScale > 1.15);

    final balanceCard = AppSurfaceCard(
      padding: cardPadding,
      onTap: onTopUpTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            balanceLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: layout.scaledFontSize(20),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                size: 16,
                color: AppColors.primaryViolet,
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  'شحن رصيد',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryViolet,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final tierCard = AppSurfaceCard(
      padding: cardPadding,
      onTap: onTierTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tierLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const Icon(Icons.chevron_left_rounded, size: 20),
            ],
          ),
          SizedBox(height: layout.itemSpacing),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: tierProgress,
              minHeight: 5,
              backgroundColor:
                  isDark ? AppColors.darkBorder : AppColors.lightBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryViolet,
              ),
            ),
          ),
        ],
      ),
    );

    if (stackVertically) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          balanceCard,
          SizedBox(height: layout.smallSpacing),
          tierCard,
        ],
      );
    }

    return Row(
      children: [
        Expanded(flex: 5, child: balanceCard),
        SizedBox(width: layout.itemSpacing),
        Expanded(flex: 6, child: tierCard),
      ],
    );
  }
}
