import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../../printer/models/receipt_print_data.dart';

/// Independent Bluetooth thermal printer settings screen.
class PrinterSettingsScreen extends StatefulWidget {
  const PrinterSettingsScreen({super.key});

  @override
  State<PrinterSettingsScreen> createState() => _PrinterSettingsScreenState();
}

class _PrinterSettingsScreenState extends State<PrinterSettingsScreen> {
  ReceiptPrintData _buildTestReceipt() {
    return const ReceiptPrintData(
      operationType: 'اختبار طباعة',
      itemTitle: 'إيصال تجريبي - الطابعة الحرارية',
      quantity: 1,
      totalPrice: 0.0,
      currencyLabel: 'د.أ',
      referenceLabel: 'المرجع',
      referenceValue: 'TEST-PRINT',
      orderNumber: 'ORD-1001',
      timestamp: '2026-11-27 17:45',
      remainingBalance: 0.0,
      divby: "by ENG YAZAN ALGALEEZ",
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<PrinterCubit>().clearFeedback();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إعدادات الطابعة'),
        ),
        body: BlocConsumer<PrinterCubit, PrinterState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              previous.statusMessage != current.statusMessage ||
              previous.status != current.status,
          listener: (context, printerState) {
            final messenger = ScaffoldMessenger.of(context);
            final errorMsg = printerState.errorMessage;
            final statusMsg = printerState.statusMessage;

            if (errorMsg != null && errorMsg.isNotEmpty) {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(errorMsg),
                    backgroundColor: errorColor,
                  ),
                );
            } else if (printerState.status == PrinterStatus.printSuccess &&
                statusMsg != null &&
                statusMsg.isNotEmpty) {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(statusMsg),
                    backgroundColor: AppColors.emeraldMint,
                  ),
                );
            }
          },
          builder: (context, printerState) {
            final cubit = context.read<PrinterCubit>();
            final isConnected = printerState.isConnected;
            final isPrinting = printerState.status == PrinterStatus.printing;
            final devices = printerState.pairedDevices;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isConnected
                        ? 'متصل: ${printerState.printerName ?? 'طابعة بلوتوث'}'
                        : 'غير متصل',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isConnected ? AppColors.emeraldMint : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isConnected)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            printerState.isBusy ? null : cubit.disconnectPrinter,
                        child: const Text('فصل الطابعة'),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            printerState.isBusy ? null : cubit.loadPairedPrinters,
                        child: Text(
                          printerState.isScanning
                              ? 'جاري البحث...'
                              : 'بحث عن الطابعات المقترنة',
                        ),
                      ),
                    ),
                  if (printerState.errorMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      printerState.errorMessage!,
                      style: TextStyle(color: errorColor, fontSize: 13),
                    ),
                  ],
                  if (printerState.statusMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      printerState.statusMessage!,
                      style: const TextStyle(
                        color: AppColors.emeraldMint,
                        fontSize: 13,
                      ),
                    ),
                  ],
                  if (devices.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'الطابعات المقترنة:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (final device in devices)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${device.name} (${device.macAddress})',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: ElevatedButton(
                                onPressed: printerState.isBusy ||
                                        printerState
                                                .connectedPrinter?.macAddress ==
                                            device.macAddress
                                    ? null
                                    : () => cubit.connectToPrinter(device),
                                child: Text(
                                  printerState.connectedPrinter?.macAddress ==
                                          device.macAddress
                                      ? 'متصل'
                                      : 'اتصال',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  if (isConnected) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isPrinting
                            ? null
                            : () => cubit.printReceipt(_buildTestReceipt()),
                        child: Text(
                          isPrinting
                              ? 'جاري طباعة الإيصال التجريبي...'
                              : 'طباعة إيصال تجريبي',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}