import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';

/// Lightweight bordered surface card without BackdropFilter or BoxShadow
/// for smooth Android rendering performance.
class AppSurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isSelected;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const AppSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.cardPadding),
    this.borderRadius = AppDimensions.cardRadius,
    this.isSelected = false,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final resolvedSurface = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final resolvedBorder = isSelected
        ? AppColors.primaryViolet
        : (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    final radius = BorderRadius.circular(borderRadius);

    return Material(
      color: resolvedSurface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: resolvedBorder,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap == null
          ? Padding(padding: padding, child: child)
          : InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Padding(padding: padding, child: child),
            ),
    );
  }
}
