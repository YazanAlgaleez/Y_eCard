import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/store_transaction_model.dart';
import 'app_surface_card.dart';

/// Displays a single wallet or purchase history entry with an optional print button.
class TransactionHistoryCard extends StatelessWidget {
  final StoreTransactionModel transaction;
  final bool showPrintButton;
  final VoidCallback? onPrintPressed;

  const TransactionHistoryCard({
    super.key,
    required this.transaction,
    required this.showPrintButton,
    this.onPrintPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                transaction.amountLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: transaction.isCredit ? AppColors.emeraldMint : null,
                ),
              ),
              if (showPrintButton && transaction.isPrintable) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.print_outlined, size: 20),
                  onPressed: onPrintPressed ?? () {},
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
