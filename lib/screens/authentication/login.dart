import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/images/icons/petropal_logo.png',
                              width: 40,
                            ),
                          ),
                          Text(
                            'Petropal',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // Text(
                    //   'Enter email address',
                    //   style: bodyText.copyWith(color: Colors.grey),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        style: bodyText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: primaryDarkColor.withOpacity(0.1),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter email address',
                          labelStyle:
                              bodyTextSmall.copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryDarkColor.withOpacity(0.1),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryDarkColor.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: primaryDarkColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Enter password',
                    //   style: bodyText.copyWith(color: Colors.grey),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        style: bodyText,
                        keyboardType: TextInputType.text,
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: primaryDarkColor.withOpacity(0.1),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter password',
                          labelStyle:
                              bodyTextSmall.copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryDarkColor.withOpacity(0.1),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryDarkColor.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: primaryDarkColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            child: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryDarkColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => const Dashboard())));
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
