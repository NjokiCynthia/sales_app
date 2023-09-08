import 'package:flutter/material.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/widgets/widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commission rates'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transactions list
            SizedBox(
              height: 10,
            ),
            Text(
              'Transactions',
              style: displayTitle,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Number of transaction items
                itemBuilder: (context, index) {
                  return CustomTransactionCard(
                    userName:
                        'Customer $index', // Replace with actual user name
                    amount: '\KES 100.00', // Replace with actual data
                    paymentMethod: 'Payment Method', // Replace with actual data
                    date: '2023-09-06',
                    volume: '100000 litres',
                    // Replace with actual data
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
