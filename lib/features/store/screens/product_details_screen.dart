import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../data/mock_store_data.dart';
import '../models/product_model.dart';
import '../widgets/app_surface_card.dart';
import '../widgets/delivery_type_selector.dart';
import '../widgets/package_option_grid.dart';
import '../widgets/player_id_input_card.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/region_selector_bar.dart';
import '../widgets/screen_back_header.dart';
import 'receipt_screen.dart';

/// Displays package options, delivery type, Player ID input, and purchase summary
/// for a selected [ProductModel].
class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool _isDirectIdDelivery;
  late String _selectedRegion;
  int _selectedPackageIndex = 2;
  int _selectedQuantity = 1;
  final TextEditingController _playerIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isDirectIdDelivery = widget.product.supportsDirectId;
    _selectedRegion = widget.product.regions.first;
  }

  @override
  void dispose() {
    _playerIdController.dispose();
    super.dispose();
  }

  void _confirmPurchase() {
    final selectedPackage = MockStoreData.packageOptions[_selectedPackageIndex];
    final totalPrice = selectedPackage.price * _selectedQuantity;
    final enteredPlayerId = _playerIdController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptScreen(
          productTitle: '${widget.product.title} - ${selectedPackage.label}',
          isDirectIdDelivery: _isDirectIdDelivery,
          playerId: enteredPlayerId.isEmpty
              ? MockStoreData.fallbackPlayerId
              : enteredPlayerId,
          voucherCode:
              _isDirectIdDelivery ? null : MockStoreData.sampleVoucherCode,
          quantity: _selectedQuantity,
          totalPaid: totalPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    final selectedPackage = MockStoreData.packageOptions[_selectedPackageIndex];
    final totalPrice = selectedPackage.price * _selectedQuantity;
    final formattedBalance =
        '${MockStoreData.walletBalance.toStringAsFixed(2)} ${MockStoreData.currencyLabel}';

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          children: [
            SizedBox(height: layout.itemSpacing),
            ScreenBackHeader(title: widget.product.title),
            SizedBox(height: layout.itemSpacing),
            _ProductWalletBanner(
              product: widget.product,
              balanceLabel: formattedBalance,
            ),
            SizedBox(height: layout.itemSpacing),
            if (widget.product.supportsDirectId &&
                widget.product.supportsVoucherCode)
              DeliveryTypeSelector(
                isDirectIdSelected: _isDirectIdDelivery,
                onDeliveryTypeChanged: (isDirectId) =>
                    setState(() => _isDirectIdDelivery = isDirectId),
              ),
            if (widget.product.regions.length > 1) ...[
              SizedBox(height: layout.smallSpacing),
              RegionSelectorBar(
                regions: widget.product.regions,
                selectedRegion: _selectedRegion,
                onRegionSelected: (region) =>
                    setState(() => _selectedRegion = region),
              ),
            ],
            SizedBox(height: layout.itemSpacing),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PackageOptionGrid(
                      packageOptions: MockStoreData.packageOptions,
                      selectedIndex: _selectedPackageIndex,
                      currencyLabel: MockStoreData.currencyLabel,
                      onPackageSelected: (index) =>
                          setState(() => _selectedPackageIndex = index),
                    ),
                    SizedBox(height: layout.sectionSpacing),
                    if (_isDirectIdDelivery) ...[
                      PlayerIdInputCard(controller: _playerIdController),
                      SizedBox(height: layout.sectionSpacing),
                    ],
                    QuantitySelector(
                      quantityOptions: MockStoreData.quantityOptions,
                      selectedQuantity: _selectedQuantity,
                      onQuantitySelected: (quantity) =>
                          setState(() => _selectedQuantity = quantity),
                    ),
                    SizedBox(height: layout.smallSpacing),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: layout.itemSpacing),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'السعر الإجمالي',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${totalPrice.toStringAsFixed(2)} ${MockStoreData.currencyLabel}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: layout.scaledFontSize(20),
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryViolet,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: layout.smallSpacing),
                  BlocBuilder<PrinterCubit, PrinterState>(
                    builder: (context, printerState) {
                      return ElevatedButton(
                        onPressed: _confirmPurchase,
                        child: Text(
                          printerState.isConnected
                              ? 'تأكيد الشراء وطباعة الإيصال'
                              : 'تأكيد الشراء',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
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

class _ProductWalletBanner extends StatelessWidget {
  final ProductModel product;
  final String balanceLabel;

  const _ProductWalletBanner({
    required this.product,
    required this.balanceLabel,
  });

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);

    return AppSurfaceCard(
      padding: EdgeInsets.all(layout.cardPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: product.accentColor.withValues(alpha: 0.18),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.badgeRadius),
                  ),
                  child: Icon(product.icon, color: product.accentColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        balanceLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'الرصيد المتاح',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryViolet.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
              ),
              child: const Text(
                MockStoreData.merchantTierLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryViolet,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
