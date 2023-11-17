class ProductCategories {
  int? id;
  String? productCode;
  String? productName;
  String? description;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  ProductCategories({
    this.id,
    this.productCode,
    this.productName,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  // Add a factory method to create a ProductCategories instance from a map
  factory ProductCategories.fromJson(Map<String, dynamic> json) {
    return ProductCategories(
      id: json['id'],
      productCode: json['product_code'],
      productName: json['product_name'],
      description: json['description'],
      createdBy: json['created_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
