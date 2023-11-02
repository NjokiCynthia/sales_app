import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/signup.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';
import 'package:petropal/screens/superadmin_dashboard/dashboard.dart';
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(children: [
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
                    body: {
                      'email': emailAddress.text,
                      'password': password.text,
                    },
                    onSuccess: (res) {
                      print('This is my response');
                      print(res);

                      final isSuccessful = res['isSuccessful'] as bool;
                      final data = res['data'] as Map<String, dynamic>?;

                      if (isSuccessful && data != null) {
                        final userData = data['user'] as Map<String, dynamic>;
                        final token = data['api_token'] as String;

                        final user = User(
                          email: userData['email'].replaceAll(' ', ''),
                          token: token,
                          password: userData['password'],
                          first_name: '',
                          last_name: '',
                          phone_number: '',
                        );

                        userProvider.setUser(user);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResellerDasboard(),
                          ),
                        );
                      } else {
                        final error = res['error'] as String;
                        showToast(
                          context,
                          'Error!',
                          error,
                          Colors.red,
                        );
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
        ]));
  }
}
