import 'package:flutter/material.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/widgets/widget.dart';

class Invoices extends StatefulWidget {
  const Invoices({Key? key}) : super(key: key);

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proforma Invoices',
          style: displayBigBoldBlack,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: 10, // Change this to the number of items you want
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.all(5),
          child: Divider(
            color: Colors.grey, // Customize the divider color
            thickness: 1.0, // Customize the divider thickness
          ),
        ),
        itemBuilder: (context, index) {
          // Customize the data for each item here
          return CustomTransactionCard(
            userName: 'User $index',
            amount: '\$100',
            paymentMethod: 'Payment Method $index',
            date: '5th September 2023',
            volume: 'Volume $index',
          );
        },
      ),
    );
  }
}
