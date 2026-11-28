import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../printer/cubit/printer_cubit.dart';
import '../../printer/cubit/printer_state.dart';
import '../data/mock_store_data.dart';
import '../widgets/screen_back_header.dart';
import '../widgets/transaction_history_card.dart';

/// Independent transaction history screen.
class TransactionsHistoryScreen extends StatelessWidget {
  const TransactionsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);

    return Scaffold(
      body: ResponsivePageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: layout.itemSpacing),
            const ScreenBackHeader(title: 'سجل العمليات'),
            SizedBox(height: layout.itemSpacing),
            Expanded(
              child: BlocBuilder<PrinterCubit, PrinterState>(
                builder: (context, printerState) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: MockStoreData.recentTransactions.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: layout.smallSpacing),
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
    );
  }
}