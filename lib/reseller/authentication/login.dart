import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/signup.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';

import 'package:petropal/widgets/buttons.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;

  TextEditingController password = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
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
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: emailAddress,
                        style: bodyText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: Colors.grey,
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter email address',
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomRequestButton(
                      url: '/user/login',
                      method: 'POST',
                      buttonText: 'Login',
                      headers: {},
                      body: {
                        'email': emailAddress.text,
                        'password': password.text,
                      },
                      onSuccess: (res) {
                        print('This is my response');
                        print(res);

                        final isSuccessful = res['isSuccessful'] as bool;

                        if (isSuccessful) {
                          final data = res['data'] as Map<String, dynamic>?;
                          if (data != null && data['status'] != 'loggedOut') {
                            final userData =
                                data['user'] as Map<String, dynamic>?;
                            final token = data['api_token'] as String?;
                            final isActivated = userData!['is_activated'];
                            if (userData != null && token != null) {
                              bool isActivatedValue;
                              if (isActivated is bool) {
                                isActivatedValue = isActivated;
                              } else if (isActivated is String) {
                                isActivatedValue =
                                    isActivated.toLowerCase() == 'true';
                              } else {
                                isActivatedValue = false;
                              }

                              final user = User(
                                id: int.parse(userData['id'].toString()),
                                email: userData['email'].replaceAll(' ', ''),
                                token: token,
                                password: userData['password'] ?? '',
                                first_name: userData['first_name'] ?? '',
                                last_name: userData['last_name'] ?? '',
                                phone: userData['phone'] ?? '',
                                account_id: userData['account_id'] ?? '',
                                isActivated: isActivatedValue,
                                companyAddress:
                                    userData['companyAddress'] ?? '',
                                companyName: userData['companyName'] ?? '',
                                companyPhone: userData['companyPhone'] ?? '',
                              );

                              userProvider.setUser(user);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResellerDasboard(),
                                ),
                              );
                            } else {}
                          } else {
                            final errorObj = res['data'];
                            final error = errorObj['message'].toString();
                            setState(() {
                              errorText = error;
                            });
                          }
                        } else {
                          final error = res['error'] as String;
                          setState(() {
                            errorText = error;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const Signup()),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account yet? ",
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Signup',
                                  style: TextStyle(color: primaryDarkColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
