/// Structured payload formatted for thermal ESC/POS receipt printing.
class ReceiptPrintData {
  final String storeName;
  final String operationType;
  final String itemTitle;
  final int quantity;
  final double totalPrice;
  final String currencyLabel;
  final String referenceLabel;
  final String referenceValue;
  final String orderNumber;
  final String timestamp;
  final double? remainingBalance;
  final String? divby;

  const ReceiptPrintData({
    this.storeName = 'Y eCard',
    required this.operationType,
    required this.itemTitle,
    required this.quantity,
    required this.totalPrice,
    required this.currencyLabel,
    required this.referenceLabel,
    required this.referenceValue,
    required this.orderNumber,
    required this.timestamp,
    this.remainingBalance,
    this.divby,
  });
}
