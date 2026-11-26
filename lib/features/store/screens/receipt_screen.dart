import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../data/mock_store_data.dart';
import '../widgets/receipt_card.dart';
import '../widgets/screen_back_header.dart';

/// Displays order confirmation, itemized receipt, and print/share actions.
class ReceiptScreen extends StatelessWidget {
  final String productTitle;
  final bool isDirectIdDelivery;
  final String playerId;
  final String? voucherCode;
  final int quantity;
  final double totalPaid;

  const ReceiptScreen({
    super.key,
    required this.productTitle,
    required this.isDirectIdDelivery,
    required this.playerId,
    this.voucherCode,
    required this.quantity,
    required this.totalPaid,
  });

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    final remainingBalance = MockStoreData.walletBalance - totalPaid;

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          children: [
            SizedBox(height: layout.itemSpacing),
            const ScreenBackHeader(title: 'تفاصيل الطلب والإيصال'),
            SizedBox(height: layout.itemSpacing),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const _OrderSuccessBanner(),
                    SizedBox(height: layout.sectionSpacing),
                    ReceiptCard(
                      productTitle: productTitle,
                      isDirectIdDelivery: isDirectIdDelivery,
                      playerId: playerId,
                      voucherCode: voucherCode,
                      quantity: quantity,
                      totalPaid: totalPaid,
                      remainingBalance: remainingBalance,
                      currencyLabel: MockStoreData.currencyLabel,
                    ),
                    SizedBox(height: layout.itemSpacing),
                  ],
                ),
              ),
            ),
            BlocBuilder<PrinterCubit, PrinterState>(
              builder: (context, printerState) {
                return Column(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        printerState.isConnected
                            ? Icons.print_rounded
                            : Icons.ios_share_rounded,
                      ),
                      label: Text(
                        printerState.isConnected
                            ? 'طباعة إيصال (بلوتوث / حراري)'
                            : 'مشاركة / حفظ الإيصال',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        if (printerState.isConnected) {
                          // Trigger Bluetooth thermal receipt print
                        } else {
                          // Trigger digital receipt share/save
                        }
                      },
                    ),
                    SizedBox(height: layout.smallSpacing),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text('طلب جديد'),
                    ),
                    SizedBox(height: layout.itemSpacing),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderSuccessBanner extends StatelessWidget {
  const _OrderSuccessBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.emeraldMint.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.emeraldMint,
            size: 28,
          ),
          const SizedBox(width: AppDimensions.itemSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تم تنفيذ الطلب بنجاح!',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${MockStoreData.sampleOrderNumber} • ${MockStoreData.sampleOrderTimestamp}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
