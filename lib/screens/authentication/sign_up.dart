import 'package:flutter/material.dart';
import 'package:petropal/constants/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Welcome to Petropal'),
          SizedBox(
            height: 20,
          ),
          Text('Log in to proceed to your account'),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            style: bodyText,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email address',
              labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                  .copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
