import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import 'app_surface_card.dart';

/// Displays the itemized receipt details, optional voucher code copy box, and QR.
class ReceiptCard extends StatelessWidget {
  final String productTitle;
  final bool isDirectIdDelivery;
  final String playerId;
  final String? voucherCode;
  final int quantity;
  final double totalPaid;
  final double remainingBalance;
  final String currencyLabel;

  const ReceiptCard({
    super.key,
    required this.productTitle,
    required this.isDirectIdDelivery,
    required this.playerId,
    this.voucherCode,
    required this.quantity,
    required this.totalPaid,
    required this.remainingBalance,
    required this.currencyLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const Text(
            'Y eCard',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryViolet,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            productTitle,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isDirectIdDelivery ? 'شحن مباشر (ID)' : 'كود رقمي فوري',
            style: const TextStyle(
              color: AppColors.emeraldMint,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const Divider(height: 24),
          if (isDirectIdDelivery)
            _ReceiptDetailRow(
              label: 'رقم اللاعب (Player ID)',
              value: playerId,
            ),
          if (voucherCode != null)
            _VoucherCodeBox(voucherCode: voucherCode!),
          _ReceiptDetailRow(label: 'الكمية', value: '$quantity'),
          const _ReceiptDetailRow(
            label: 'طريقة الدفع',
            value: 'المحفظة الإلكترونية',
          ),
          _ReceiptDetailRow(
            label: 'المبلغ المدفوع',
            value: '${totalPaid.toStringAsFixed(2)} $currencyLabel',
            valueColor: AppColors.emeraldMint,
          ),
          _ReceiptDetailRow(
            label: 'الرصيد المتبقي',
            value: '${remainingBalance.toStringAsFixed(2)} $currencyLabel',
          ),
          const SizedBox(height: AppDimensions.sectionSpacing),
          const Icon(Icons.qr_code_2_rounded, size: 68),
          const SizedBox(height: 6),
          Text(
            'شكراً لتعاملكم مع Y eCard',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _VoucherCodeBox extends StatelessWidget {
  final String voucherCode;

  const _VoucherCodeBox({required this.voucherCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryViolet.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              voucherCode,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 1.2,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 19),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: voucherCode));
            },
          ),
        ],
      ),
    );
  }
}

class _ReceiptDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ReceiptDetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
