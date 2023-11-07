class ProductListing {
  final int productId;
  final String productName;
  final String productCode;
  final String depotName;
  final String depotCode;
  final String location;
  final int companyId;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final double minimumVolumePerOrder;
  final double pricePer;
  final double sellingPrice;
  final double stockVolume;
  final double availableVolume;
  final double minVol;
  final double maxVol;
  final int status;
  final double commissionRate;

  ProductListing({
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.depotName,
    required this.depotCode,
    required this.location,
    required this.companyId,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.minimumVolumePerOrder,
    required this.pricePer,
    required this.sellingPrice,
    required this.stockVolume,
    required this.availableVolume,
    required this.minVol,
    required this.maxVol,
    required this.status,
    required this.commissionRate,
  });
}

