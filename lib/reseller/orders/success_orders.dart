import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class OrdersSuccess extends StatefulWidget {
  const OrdersSuccess({super.key});

  @override
  State<OrdersSuccess> createState() => _OrdersSuccessState();
}

class _OrdersSuccessState extends State<OrdersSuccess> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/illustrations/success.png'),
                Text(
                  'You have successfully created the order',
                  style: m_title,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Volume ordered is ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '1000 litres',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total payable amount is ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'KES 500',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {},
                    child: Text('Confirm Order'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
