import 'package:flutter/material.dart';

class User {
  final int id;
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
  String get username => '$first_name $last_name';

  User({
    required this.id,
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
  bool _isActivated = true;

  bool get isActivated => _isActivated;

  void setUser(User user) {
    _user = user;
    _isActivated = user.isActivated;
    notifyListeners();
  }
}
