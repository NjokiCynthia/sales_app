import 'package:flutter/foundation.dart';
import 'package:petropal/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  // Getter to access the list of products
  List<ProductModel> get products => _products;

  // Method to add a product to the list
  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }
}
