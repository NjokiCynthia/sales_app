import 'package:flutter/foundation.dart';
import 'package:petropal/models/omc_product.dart';

class OmcProductProvider with ChangeNotifier {
  final List<OmcProductModel> _products = [];
  bool _isLoading = false;

  // Getter to access the list of products
  bool get isLoading => _isLoading;
  List<OmcProductModel> get products => _products;

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
  void addOmcProduct(OmcProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  // setting products.
  void setOmcProducts(List<OmcProductModel> products){
    _products.addAll(products);
    notifyListeners();
  }
}
