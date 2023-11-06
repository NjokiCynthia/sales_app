class ProductModel {
  final int id;
  final int counter;
  final int createdBy;
  final String product;
  final String depot;
  final double price;
  final double sellingPrice;
  final String location;
  final double availableVolume;
  final double minimumVolume;
  final double maximumVolume;
  final double remainingVolume;
  final String dealerName;
  final double commissionRate;
  final int status;
  final int companyId;

  ProductModel(
      {required this.id,
      required this.counter,
      required this.createdBy,
      required this.product,
      required this.depot,
      required this.sellingPrice,
      required this.dealerName,
      required this.price,
      required this.location,
      required this.remainingVolume,
      required this.availableVolume,
      required this.minimumVolume,
      required this.maximumVolume,
      required this.commissionRate,
      required this.status,
      required this.companyId});
}
