

import 'package:flutter/foundation.dart';
import 'package:petropal/models/driver.dart';

class DriverProvider with ChangeNotifier {
  final List<DriverModel> _drivers = [];

  bool _isLoading = false;

  // Getter to access the list of products
  List<DriverModel> get drivers => _drivers;

  // Method to add drivers to the list.
  void addDrivers(List<DriverModel> drivers){
    _drivers.addAll(drivers);
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

  // Method to add a single driver to the list.
  void addDriver(DriverModel driver) {
    _drivers.add(driver);
    notifyListeners();
  }

}