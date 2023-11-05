import 'package:flutter/material.dart';

class User {
  final String first_name;
  final String last_name;
  final String phone;

  final String email;

  final String password;

  final String token;
  final bool isActivated;
  final int account_id;
  final String companyName;
  final String companyAddress;
  final String companyPhone;

  User({
    required this.email,
    required this.password,
    required this.token,
    required this.first_name,
    required this.last_name,
    required this.phone,
    required this.isActivated,
    required this.account_id,
    required this.companyAddress,
    required this.companyName,
    required this.companyPhone,
  });
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool _isActivated = false;

  bool get isActivated => _isActivated;
  // Method to update the activation status.
  void updateActivationStatus(bool status) {
    _isActivated = status;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;

    notifyListeners();
  }
}
