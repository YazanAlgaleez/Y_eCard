import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../theme/cubit/theme_cubit.dart';
import '../data/mock_store_data.dart';
import '../widgets/app_surface_card.dart';
import '../widgets/screen_back_header.dart';
import 'levels_screen.dart';

/// Independent account & app preferences screen.
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final formattedBalance =
        '${MockStoreData.walletBalance.toStringAsFixed(2)} ${MockStoreData.currencyLabel}';

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: layout.itemSpacing),
            const ScreenBackHeader(title: 'إعدادات الحساب'),
            SizedBox(height: layout.itemSpacing),
            AppSurfaceCard(
              padding: EdgeInsets.all(layout.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'بيانات الحساب',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppDimensions.smallSpacing),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.account_balance_wallet_rounded),
                    title: const Text('رصيد المحفظة'),
                    subtitle: Text(formattedBalance),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.workspace_premium_rounded),
                    title: const Text('مستوى التاجر'),
                    subtitle: Text(MockStoreData.merchantTierLabel),
                    trailing: const Icon(Icons.chevron_left_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LevelsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: layout.itemSpacing),
            AppSurfaceCard(
              padding: EdgeInsets.all(layout.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تفضيلات التطبيق',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppDimensions.smallSpacing),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    secondary: Icon(
                      isDarkMode
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                    ),
                    title: const Text('الوضع الداكن'),
                    subtitle: Text(isDarkMode ? 'مفعّل' : 'غير مفعّل'),
                    value: isDarkMode,
                    onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}