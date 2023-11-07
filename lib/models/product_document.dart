class ProductDocuments {
  final int orderVolume;
  final double productPrice;
  final double pricePerProduct;
  final double purchasePricePerUnit;
  final String productCategoryCode;
  final String productCategoryName;
  final String productCategoryDescription;

  ProductDocuments({
    required this.orderVolume,
    required this.productPrice,
    required this.pricePerProduct,
    required this.purchasePricePerUnit,
    required this.productCategoryCode,
    required this.productCategoryName,
    required this.productCategoryDescription,
  });
}
