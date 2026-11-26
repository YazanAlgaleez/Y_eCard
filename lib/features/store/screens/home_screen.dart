import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../theme/cubit/theme_cubit.dart';
import '../data/mock_store_data.dart';
import '../models/product_model.dart';
import '../widgets/app_surface_card.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/store_header.dart';
import '../widgets/wallet_summary_row.dart';
import 'history_account_screen.dart';
import 'levels_screen.dart';
import 'product_details_screen.dart';

/// Main store catalog screen with wallet summary, search, category filters,
/// and product grid.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = MockStoreData.allCategory;
  String _searchQuery = '';

  List<ProductModel> get _filteredProducts {
    final normalizedQuery = _searchQuery.trim();
    return MockStoreData.products.where((product) {
      final matchesSearch =
          normalizedQuery.isEmpty || product.title.contains(normalizedQuery);
      if (!matchesSearch) return false;

      if (_selectedCategory == MockStoreData.allCategory) return true;
      if (_selectedCategory == MockStoreData.directIdCategory) {
        return product.supportsDirectId;
      }
      if (_selectedCategory == MockStoreData.codesCategory) {
        return product.supportsVoucherCode;
      }
      return product.category == _selectedCategory;
    }).toList();
  }

  void _openAccountHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HistoryAccountScreen()),
    );
  }

  void _openMerchantLevels() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LevelsScreen()),
    );
  }

  void _openProductDetails(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final layout = ResponsiveLayout.of(context);
    final filteredProducts = _filteredProducts;
    final formattedBalance =
        '${MockStoreData.walletBalance.toStringAsFixed(2)} ${MockStoreData.currencyLabel}';

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          children: [
            SizedBox(height: layout.itemSpacing),
            StoreHeader(
              isDarkMode: isDarkMode,
              onSupportPressed: () {},
              onToggleThemePressed: () =>
                  context.read<ThemeCubit>().toggleTheme(),
              onAccountPressed: _openAccountHistory,
            ),
            SizedBox(height: layout.sectionSpacing),
            WalletSummaryRow(
              balanceLabel: formattedBalance,
              tierLabel: MockStoreData.merchantTierLabel,
              tierProgress: MockStoreData.merchantTierProgress,
              onTierTap: _openMerchantLevels,
            ),
            SizedBox(height: layout.itemSpacing),
            AppSurfaceCard(
              padding: EdgeInsets.symmetric(
                horizontal: layout.cardPadding,
                vertical: 2,
              ),
              borderRadius: AppDimensions.inputRadius,
              child: TextField(
                onChanged: (query) => setState(() => _searchQuery = query),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search_rounded, size: 20),
                  hintText: 'ابحث عن ألعاب، بطاقات...',
                ),
              ),
            ),
            SizedBox(height: layout.itemSpacing),
            CategoryFilterBar(
              categories: MockStoreData.categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) =>
                  setState(() => _selectedCategory = category),
            ),
            SizedBox(height: layout.itemSpacing),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: layout.productGridColumns,
                  crossAxisSpacing: layout.itemSpacing,
                  mainAxisSpacing: layout.itemSpacing,
                  childAspectRatio: layout.productCardAspectRatio,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductGridCard(
                    product: product,
                    onTap: () => _openProductDetails(product),
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
