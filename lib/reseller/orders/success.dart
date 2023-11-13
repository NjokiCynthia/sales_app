import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:petropal/constants/theme.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have successfully created your account',
                    style: m_title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please await admin approval to proceed',
                    style: m_title.copyWith(color: Colors.grey),
                  ),
                  Image.asset('assets/illustrations/success.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
