import 'package:flutter/foundation.dart';
import 'package:petropal/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _products = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Getter to access the list of products
  List<ProductModel> get products => _products;

  // start loading.
  void startLoading(){
    _isLoading = true;
    notifyListeners();
  }

  // stop loading.
  void stopLoading(){
    _isLoading = false;
    notifyListeners();
  }

  // Method to add a product to the list
  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  // setting products.
  void setProducts(List<ProductModel> products){
    _products.addAll(products);
    // notifyListeners();
  }
}
