class CompletedOrdersModel {
  int? id;
  int? orderStatus;
  String? orderCreatedAt;
  int? orderPayableAmount;
  Null orderVolume;
  String? orderInvoiceNumber;
  String? orderExpiryTime;
  String? orderReceiptDocument;
  String? vendorName;
  String? vendorEmail;
  String? vendorPhone;

  CompletedOrdersModel(
      {this.id,
      this.orderStatus,
      this.orderCreatedAt,
      this.orderPayableAmount,
      this.orderVolume,
      this.orderInvoiceNumber,
      this.orderExpiryTime,
      this.orderReceiptDocument,
      this.vendorName,
      this.vendorEmail,
      this.vendorPhone});
}
