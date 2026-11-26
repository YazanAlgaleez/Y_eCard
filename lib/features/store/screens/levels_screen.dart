import 'package:flutter/material.dart';

import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../data/mock_store_data.dart';
import '../widgets/merchant_level_progress_card.dart';
import '../widgets/merchant_level_tier_card.dart';
import '../widgets/screen_back_header.dart';

/// Displays the merchant's current tier progress and all available tier benefits.
class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: layout.itemSpacing),
            const ScreenBackHeader(title: 'مستويات التجار'),
            SizedBox(height: layout.itemSpacing),
            const MerchantLevelProgressCard(
              currentTierLabel: MockStoreData.merchantTierLabel,
              nextTierLabel: MockStoreData.nextMerchantTierLabel,
              progress: MockStoreData.merchantTierProgress,
              currentSales: MockStoreData.currentMonthlySales,
              targetSales: MockStoreData.nextLevelTargetSales,
              currencyLabel: MockStoreData.currencyLabel,
            ),
            SizedBox(height: layout.sectionSpacing),
            Text(
              'جميع المستويات والمزايا',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: layout.smallSpacing),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: MockStoreData.merchantLevels.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: layout.itemSpacing),
                itemBuilder: (context, index) {
                  final level = MockStoreData.merchantLevels[index];
                  return MerchantLevelTierCard(
                    level: level,
                    currentLevelNumber:
                        MockStoreData.currentMerchantLevelNumber,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
