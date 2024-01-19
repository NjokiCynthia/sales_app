import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/forgot_password/email_reset.dart';
import 'package:petropal/reseller/authentication/signup.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;

  TextEditingController password = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  String errorText = ' ';

  Future<void> login() async {
    setState(() {
      errorText = '';
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final response = await http.post(
         //Uri.parse('https://petropal.sandbox.co.ke:8040/user/login'),
        Uri.parse('https://petropal.africa:8050/user/login'),
        body: {
          'email': emailAddress.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        final status = responseData['status'];
        final message = responseData['message'];

        if (status == 1) {
          final userData = responseData['user'];

          final token = responseData['api_token'] as String;
          final isActivated = userData['is_activated'] as bool;

          final user = User(
            id: userData['id'],
            email: userData['email'],
            password: '',
            token: token,
            first_name: userData['first_name'],
            last_name: userData['last_name'],
            phone: userData['phone'],
            isActivated: isActivated,
            account_id: userData['account_id'],
            companyAddress: userData['companyAddress'],
            companyName: userData['companyName'],
            companyPhone: userData['companyPhone'],
          );

          userProvider.setUser(user);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ResellerDashboard(),
            ),
          );
        } else {
          setState(() {
            errorText = message;
          });
        }
      } else {
        if (response.statusCode == 500) {
          setState(() {
            errorText = 'System under maintenance. Please try later';
          });
        } else {
          setState(() {
            errorText = 'Check your internet connection';
          });
        }
      }
    } catch (error) {
      print('Error during login: $error');
      setState(() {
        errorText = 'An error occurred during login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Image.asset(
                          'assets/images/icons/petropal_logo.png',
                          width: 200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: errorText.isNotEmpty
                          ? Text(errorText,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailAddress,
                      style: bodyText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: Colors.grey,
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Enter email address',
                        errorText: emailAddress.text.isEmpty && errorText != ' '
                            ? 'Email is required'
                            : null,
                        labelStyle: TextStyle(color: Colors.grey[500]),
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
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password,
                      style: bodyText,
                      keyboardType: TextInputType.text,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.grey,
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Enter password',
                        errorText: password.text.isEmpty && errorText != ' '
                            ? 'Password is required'
                            : null,
                        labelStyle: TextStyle(color: Colors.grey[500]),
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
                            color: primaryDarkColor.withOpacity(0.7),
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
                            login();
                          },
                          child: const Text('Login')),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Center(
                        child: Text(
                      "Don't have an account yet?",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const Signup()),
                              ),
                            );
                          },
                          child: const Text('SignUp')),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const ForgotPassword()),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Forgot your password? ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Reset here',
                                  style: TextStyle(
                                      color: primaryDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: ((context) => const Signup()),
                    //       ),
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(bottom: 20),
                    //     child: Center(
                    //       child: Text("Don't have an account yet?");
                    //       child: RichText(
                    //         text: const TextSpan(
                    //           text: "Don't have an account yet?",
                    //           style: TextStyle(color: Colors.black),
                    //           children: <TextSpan>[
                    //             TextSpan(
                    //               text: 'Signup',
                    //               style: TextStyle(color: primaryDarkColor),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
