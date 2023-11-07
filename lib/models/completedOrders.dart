class CompletedOrdersModel {
  int? id;
  String? invoiceNumber;
  int? orderProductId;
  num? volume;
  num? payableAmount;
  String? invoiceDocument;
  int? loadingOrder;
  int? driverId;
  int? truckId;
  Null? receiptDocument;
  Null? purchaseOrderDocument;
  Null? invoiceOrderDocument;
  Null? comment;
  int? commissionEarned;
  int? accountId;
  int? status;
  String? orderExpireTime;
  int? createdBy;
  Null? proofOfPaymentDocument;
  String? paymentBankOption;
  String? createdAt;
  String? updatedAt;

  CompletedOrdersModel(
      {this.id,
      this.invoiceNumber,
      this.orderProductId,
      this.volume,
      this.payableAmount,
      this.invoiceDocument,
      this.loadingOrder,
      this.driverId,
      this.truckId,
      this.receiptDocument,
      this.purchaseOrderDocument,
      this.invoiceOrderDocument,
      this.comment,
      this.commissionEarned,
      this.accountId,
      this.status,
      this.orderExpireTime,
      this.createdBy,
      this.proofOfPaymentDocument,
      this.paymentBankOption,
      this.createdAt,
      this.updatedAt});
}
