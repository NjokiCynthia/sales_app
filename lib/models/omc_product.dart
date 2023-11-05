class OmcProductModel {
  final String productId;
  final String productName;
  final String productCode;
  final String depotName;
  final String location;
  final String companyId;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String minVolumePerOrder;
  final double pricePer;
  final double sellingPrice;
  final double stockVolume;
  final double availableVolume;
  final double minVolume;
  final double maxVolume;
  final String status;
  final double commissionRate;

  OmcProductModel({
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.depotName,
    required this.location,
    required this.companyId,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.minVolumePerOrder,
    required this.pricePer,
    required this.sellingPrice,
    required this.stockVolume,
    required this.availableVolume,
    required this.minVolume,
    required this.maxVolume,
    required this.status,
    required this.commissionRate
  });
}