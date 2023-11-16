import 'package:flutter/foundation.dart';
import 'package:petropal/models/completed_orders.dart';

class OrderProvider with ChangeNotifier {
  final List<CompletedOrdersModel> _orders = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Getter to access the list of products
  List<CompletedOrdersModel> get orders => _orders;

  // Method to add orders to the list.
  void addOrders(List<CompletedOrdersModel> orders) {
    _orders.addAll(orders);
    notifyListeners();
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // Method to add a single order to the list.
  void addOrder(CompletedOrdersModel order) {
    _orders.add(order);
    notifyListeners();
  }
}
