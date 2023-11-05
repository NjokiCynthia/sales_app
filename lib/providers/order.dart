import 'package:flutter/foundation.dart';
import 'package:petropal/models/order.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Getter to access the list of products
  List<OrderModel> get orders => _orders;

  // Method to add orders to the list.
  void addOrders(List<OrderModel> orders){
    _orders.addAll(orders);
    notifyListeners();
  }

  void startLoading(){
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading(){
    _isLoading = false;
    notifyListeners();
  }

  // Method to add a single order to the list.
  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }


}