class ProductModel {
  final String productName;
  final String dealerName;
  final double price;
  final String location;
  final double availableVolume;
  final double minimumVolume;
  final double maximumVolume;

  ProductModel({
    required this.productName,
    required this.dealerName,
    required this.price,
    required this.location,
    required this.availableVolume,
    required this.minimumVolume,
    required this.maximumVolume,
  });
}
