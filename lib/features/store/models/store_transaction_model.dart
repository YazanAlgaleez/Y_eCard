/// Represents a wallet or purchase history entry shown in the account screen.
class StoreTransactionModel {
  final String title;
  final String subtitle;
  final String amountLabel;
  final bool isCredit;
  final bool isPrintable;

  const StoreTransactionModel({
    required this.title,
    required this.subtitle,
    required this.amountLabel,
    this.isCredit = false,
    this.isPrintable = true,
  });
}
