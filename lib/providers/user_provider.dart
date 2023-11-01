import 'package:flutter/material.dart';

class User {
  final String first_name;
  final String last_name;
  final String phone_number;

  final String email;

  final String password;

  final String token;

  User({
    required this.email,
    required this.password,
    required this.token,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
  });
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;

    notifyListeners();
  }
}
