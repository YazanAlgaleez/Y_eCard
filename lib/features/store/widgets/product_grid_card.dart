import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/product_model.dart';
import 'app_surface_card.dart';

/// Displays an individual product card inside the home catalog grid.
class ProductGridCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductGridCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleColor = Theme.of(context).textTheme.bodySmall?.color;

    return AppSurfaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.emeraldMint.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
              ),
              child: Text(
                product.badge,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.emeraldMint,
                ),
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    product.accentColor.withValues(alpha: 0.28),
                    product.accentColor.withValues(alpha: 0.08),
                  ],
                ),
              ),
              child: Icon(
                product.icon,
                size: 30,
                color: product.accentColor,
              ),
            ),
          ),
          const Spacer(),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (product.regionNote != null) ...[
            const SizedBox(height: 2),
            Text(
              product.regionNote!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: subtitleColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
