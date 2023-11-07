class CompletedOrders {
  final int id;
  final String invoiceNumber;
  final int orderProductId;
  final double volume;
  final double payableAmount;
  final String invoiceDocument;
  final int loadingOrder;
  final int driverId;
  final int truckId;
  final String receiptDocument;
  final String purchaseOrderDocument;
  final String invoiceOrderDocument;
  final String comment;
  final double commissionEarned;
  final int accountId;
  final int status;
  final DateTime orderExpireTime;
  final int createdBy;
  final String proofOfPaymentDocument;
  final String paymentBankOption;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompletedOrders({
    required this.id,
    required this.invoiceNumber,
    required this.orderProductId,
    required this.volume,
    required this.payableAmount,
    required this.invoiceDocument,
    required this.loadingOrder,
    required this.driverId,
    required this.truckId,
    required this.receiptDocument,
    required this.purchaseOrderDocument,
    required this.invoiceOrderDocument,
    required this.comment,
    required this.commissionEarned,
    required this.accountId,
    required this.status,
    required this.orderExpireTime,
    required this.createdBy,
    required this.proofOfPaymentDocument,
    required this.paymentBankOption,
    required this.createdAt,
    required this.updatedAt,
  });
}
