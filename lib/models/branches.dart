import 'package:flutter/src/material/dropdown.dart';

class Branch {
  int? id;
  String? bankId;
  String? code;
  String? name;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Branch(
      {this.id,
      this.bankId,
      this.code,
      this.name,
      this.active,
      this.createdAt,
      this.updatedAt});

  map(DropdownMenuItem<String> Function(String branch) param0) {}
}
