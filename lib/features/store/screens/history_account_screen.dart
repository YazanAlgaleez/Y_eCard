import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_styles.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../data/mock_store_data.dart';
import '../widgets/printer_connection_card.dart';
import '../widgets/screen_back_header.dart';
import '../widgets/transaction_history_card.dart';

/// Displays Bluetooth thermal printer settings and recent wallet transactions.
class HistoryAccountScreen extends StatelessWidget {
  const HistoryAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.itemSpacing),
              const ScreenBackHeader(title: 'السجل والحساب'),
              const SizedBox(height: AppDimensions.itemSpacing),
              BlocBuilder<PrinterCubit, PrinterState>(
                builder: (context, printerState) {
                  return PrinterConnectionCard(
                    printerState: printerState,
                    onToggleConnection: () =>
                        context.read<PrinterCubit>().toggleConnection(),
                  );
                },
              ),
              const SizedBox(height: AppDimensions.sectionSpacing),
              Text(
                'العمليات الأخيرة',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<PrinterCubit, PrinterState>(
                  builder: (context, printerState) {
                    return ListView.separated(
                      itemCount: MockStoreData.recentTransactions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final transaction =
                            MockStoreData.recentTransactions[index];
                        return TransactionHistoryCard(
                          transaction: transaction,
                          showPrintButton: printerState.isConnected,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
