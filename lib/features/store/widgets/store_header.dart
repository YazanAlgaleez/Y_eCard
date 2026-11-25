import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';

/// Top store navigation header with brand badge and quick action buttons.
class StoreHeader extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onSupportPressed;
  final VoidCallback onToggleThemePressed;
  final VoidCallback onAccountPressed;

  const StoreHeader({
    super.key,
    required this.isDarkMode,
    required this.onSupportPressed,
    required this.onToggleThemePressed,
    required this.onAccountPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryViolet,
                    AppColors.emeraldMint,
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  'Y',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.smallSpacing),
            Text(
              'Y eCard',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        Row(
          children: [
            _HeaderCircleButton(
              icon: Icons.chat_bubble_outline_rounded,
              iconColor: AppColors.emeraldMint,
              onPressed: onSupportPressed,
            ),
            const SizedBox(width: AppDimensions.smallSpacing),
            _HeaderCircleButton(
              icon: isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              onPressed: onToggleThemePressed,
            ),
            const SizedBox(width: AppDimensions.smallSpacing),
            _HeaderCircleButton(
              icon: Icons.person_outline_rounded,
              onPressed: onAccountPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onPressed;

  const _HeaderCircleButton({
    required this.icon,
    this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonBackground =
        isDark ? AppColors.darkElevatedSurface : AppColors.lightElevatedSurface;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonBackground,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}
