import 'package:flutter/rendering.dart';

class Order {
  final String id;
  final String orderStatus;
  final String orderPayableAmount;
  final String? orderVolume;
  final String orderInvoiceNumber;
  final String vendorName;
  final String vendorEmail;
  final DateTime orderCreatedAt;

  Order({
    required this.id,
    required this.orderStatus,
    required this.orderPayableAmount,
    this.orderVolume,
    required this.orderInvoiceNumber,
    required this.vendorName,
    required this.vendorEmail,
    required this.orderCreatedAt,
  });
}
