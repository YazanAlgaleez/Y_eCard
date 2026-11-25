/// Represents a purchasable denomination/package for a store product.
class PackageOptionModel {
  final String label;
  final double price;

  const PackageOptionModel({
    required this.label,
    required this.price,
  });
}
