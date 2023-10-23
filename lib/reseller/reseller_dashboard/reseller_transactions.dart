import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResellerTransactions extends StatefulWidget {
  const ResellerTransactions({super.key});

  @override
  State<ResellerTransactions> createState() => _ResellerTransactionsState();
}

class _ResellerTransactionsState extends State<ResellerTransactions> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[50]));
    return Scaffold(
      backgroundColor: Colors.grey[50],
    );
  }
}
