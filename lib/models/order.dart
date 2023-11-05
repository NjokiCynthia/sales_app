class OrderModel {
  final String id;
  final String commissionEarned;
  final String driverId;
  final String truckId;
  final String invoiceNumber;
  final String payableAmount;
  final String paymentBankOption;
  final String invoiceDocument;
  final String accountId;
  final String status;
  final String createdBy;
  final String createdAt;
  final String updatedAt;


  OrderModel({
    required this.id,
    required this.commissionEarned,
    required this.driverId,
    required this.truckId,
    required this.invoiceNumber,
    required this.payableAmount,
    required this.paymentBankOption,
    required this.invoiceDocument,
    required this.accountId,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt
  });
}