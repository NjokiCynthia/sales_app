import 'package:flutter/foundation.dart';
import 'package:petropal/models/truck.dart';

class TruckProvider with ChangeNotifier {
  final List<TruckModel> _trucks = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Getter to access the list of products
  List<TruckModel> get trucks => _trucks;

  // Method to add trucks to the list.
  void addTrucks(List<TruckModel> trucks){
    _trucks.addAll(trucks);
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

  // Method to add a single truck to the list.
  void addTruck(TruckModel truck) {
    _trucks.add(truck);
    notifyListeners();
  }


}