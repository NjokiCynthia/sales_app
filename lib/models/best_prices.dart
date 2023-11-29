class BestPrices {
  int? id;
  String? product;
  String? depot;
  String? location;
  double? sellingPrice;
  double? volume;
  double? availableVolume;
  String? dealer;
  double? remainingVolume;
  int? ordersApproved;
  int? ordersPending;

  BestPrices(
      {this.id,
      this.product,
      this.depot,
      this.location,
      this.sellingPrice,
      this.volume,
      this.availableVolume,
      this.dealer,
      this.remainingVolume,
      this.ordersApproved,
      this.ordersPending});
}
