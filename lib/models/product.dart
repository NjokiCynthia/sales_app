class ProductModel {
  final String id;
  final String counter;
  final String createdBy;
  final String product;
  final String depot;
  final double price;
  final double sellingPrice;
  final String location;
  final double availableVolume;
  final double minimumVolume;
  final double maximumVolume;
  final String ordersApproved;
  final String dealerName;
  final double commissionRate;
  final String ordersPending;
  final String status;
  final String companyId;


  ProductModel({
    required this.id,
    required this.counter,
    required this.createdBy,
    required this.product,
    required this.depot,
    required this.sellingPrice,
    required this.dealerName,
    required this.price,
    required this.location,
    required this.availableVolume,
    required this.minimumVolume,
    required this.maximumVolume,
    required this.ordersApproved,
    required this.commissionRate,
    required this.ordersPending,
    required this.status,
    required this.companyId
  });
}
