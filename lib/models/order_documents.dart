import 'package:petropal/models/product.dart';

class OrderDocumentsModel {
  final int id;
  final int orderStatus;
  final DateTime orderCreatedAt;
  final double orderPayableAmount;
  final double orderOmcAmount;
  final List<ProductModel> products;
  final String orderInvoiceNumber;
  final String vendorName;
  final String vendorEmail;
  final String vendorPhone;
  final String vendorAccountName;
  final String vendorAccountNumber;
  final String vendorBankName;
  final String vendorBranchName;
  final String resellerName;
  final String resellerEmail;
  final String resellerPhone;
  final String depot;
  final String location;
  final String driverName;
  final String driverPhoneNumber;
  final String driverIdNumber;
  final String driverLicenceNumber;
  final String driverEpraLicenceNumber;
  final String truckNumber;
  final String truckCompartment;
  final String? proformaInvoiceDoc;
  final String? resellerProofOfPayment;
  final String? purchaseOrder;
  final String? receipt;
  final String? loadingOrder;
  final String? invoiceOrderDocument;
  final int status;

  OrderDocumentsModel({
    required this.id,
    required this.orderStatus,
    required this.orderCreatedAt,
    required this.orderPayableAmount,
    required this.orderOmcAmount,
    required this.products,
    required this.orderInvoiceNumber,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.vendorAccountName,
    required this.vendorAccountNumber,
    required this.vendorBankName,
    required this.vendorBranchName,
    required this.resellerName,
    required this.resellerEmail,
    required this.resellerPhone,
    required this.depot,
    required this.location,
    required this.driverName,
    required this.driverPhoneNumber,
    required this.driverIdNumber,
    required this.driverLicenceNumber,
    required this.driverEpraLicenceNumber,
    required this.truckNumber,
    required this.truckCompartment,
    this.proformaInvoiceDoc,
    this.resellerProofOfPayment,
    this.purchaseOrder,
    this.receipt,
    this.loadingOrder,
    this.invoiceOrderDocument,
    required this.status,
  });
}
