import 'package:petropal/models/product_document.dart';

class ProductModel {
  final int? id;
  final int? counter;
  final int? createdBy;
  final String? product;
  final String? depot;
  final double? price;
  final double? sellingPrice;
  final String? location;
  final double? availableVolume;
  final double? minimumVolume;
  final double? maximumVolume;
  final double? remainingVolume;
  final String? dealerName;
  final double? commissionRate;
  final int? status;
  final int? companyId;
  final ProductDocuments? productDocuments;

  ProductModel({
    this.id,
    this.counter,
    this.createdBy,
    this.product,
    this.depot,
    this.sellingPrice,
    this.dealerName,
    this.price,
    this.location,
    this.remainingVolume,
    this.availableVolume,
    this.minimumVolume,
    this.maximumVolume,
    this.commissionRate,
    this.status,
    this.companyId,
    this.productDocuments,
  });
}
