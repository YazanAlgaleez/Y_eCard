import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../../printer/models/receipt_print_data.dart';
import '../data/mock_store_data.dart';
import '../widgets/receipt_card.dart';
import '../widgets/screen_back_header.dart';
import 'printer_settings_screen.dart';

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

  ReceiptPrintData _buildReceiptPrintData(double remainingBalance) {
    final cleanVoucher = (voucherCode ?? '').trim();
    return ReceiptPrintData(
      operationType: isDirectIdDelivery ? 'شحن مباشر ID' : 'شراء كود',
      itemTitle: productTitle,
      quantity: quantity,
      totalPrice: totalPaid,
      currencyLabel: MockStoreData.currencyLabel,
      referenceLabel: isDirectIdDelivery ? 'معرف اللاعب' : 'رمز الكود',
      referenceValue: isDirectIdDelivery
          ? playerId
          : (cleanVoucher.isEmpty ? 'غير متوفر' : cleanVoucher),
      orderNumber: MockStoreData.sampleOrderNumber,
      timestamp: MockStoreData.sampleOrderTimestamp,
      remainingBalance: remainingBalance,
    );
  }

  void _openPrinterSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrinterSettingsScreen()),
    );
  }

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
            BlocConsumer<PrinterCubit, PrinterState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage ||
                  previous.statusMessage != current.statusMessage ||
                  previous.status != current.status,
              listener: (context, printerState) {
                final messenger = ScaffoldMessenger.of(context);
                if (printerState.errorMessage != null) {
                  messenger
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(printerState.errorMessage!),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                } else if (printerState.status == PrinterStatus.printSuccess &&
                    printerState.statusMessage != null) {
                  messenger
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(printerState.statusMessage!),
                        backgroundColor: AppColors.emeraldMint,
                      ),
                    );
                }
              },
              builder: (context, printerState) {
                final isPrinting = printerState.status == PrinterStatus.printing;

                return Column(
                  children: [
                    if (printerState.connectedPrinter != null) ...[
                      Text(
                        'الطابعة المتصلة: ${printerState.connectedPrinter!.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: layout.smallSpacing),
                    ],
                    ElevatedButton.icon(
                      icon: isPrinting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              printerState.isConnected
                                  ? Icons.print_rounded
                                  : Icons.settings_rounded,
                            ),
                      label: Text(
                        isPrinting
                            ? 'جاري الطباعة...'
                            : printerState.isConnected
                                ? 'طباعة إيصال (بلوتوث / حراري)'
                                : 'إعدادات الطابعة',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: isPrinting
                          ? null
                          : () {
                              if (printerState.isConnected) {
                                context.read<PrinterCubit>().printReceipt(
                                      _buildReceiptPrintData(remainingBalance),
                                    );
                              } else {
                                _openPrinterSettings(context);
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