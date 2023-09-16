import 'package:flutter/material.dart';

class User {
  String? email;

  String? password;

  final String token;

  User({
    required this.email,
    required this.password,
    required this.token,
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
