import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/package_option_model.dart';
import 'app_surface_card.dart';

/// Displays selectable package denominations and prices in a two-column grid.
class PackageOptionGrid extends StatelessWidget {
  final List<PackageOptionModel> packageOptions;
  final int selectedIndex;
  final String currencyLabel;
  final ValueChanged<int> onPackageSelected;

  const PackageOptionGrid({
    super.key,
    required this.packageOptions,
    required this.selectedIndex,
    required this.currencyLabel,
    required this.onPackageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.65,
      ),
      itemCount: packageOptions.length,
      itemBuilder: (context, index) {
        final packageOption = packageOptions[index];
        final isSelected = selectedIndex == index;

        return AppSurfaceCard(
          isSelected: isSelected,
          onTap: () => onPackageSelected(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                packageOption.label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                '${packageOption.price.toStringAsFixed(2)} $currencyLabel',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? AppColors.primaryViolet
                      : AppColors.emeraldMint,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
