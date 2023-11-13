class BestPrices {
  int? id;
  String? product;
  String? depot;
  String? location;
  int? sellingPrice;
  int? volume;
  int? availableVolume;
  String? dealer;
  int? remainingVolume;
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
