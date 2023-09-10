import 'package:flutter/material.dart';
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
        title: Text('Invoices'),
      ),
      body: ListView.builder(
        itemCount: 10, // Change this to the number of cards you want
        itemBuilder: (context, index) {
          // You can customize the data for each card here
          return CustomTransactionCard(
            userName: 'User $index',
            amount: '\$100',
            paymentMethod: 'Payment Method $index',
            date: 'Date $index',
            volume: 'Volume $index',
          );
        },
      ),
    );
  }
}
