import 'package:flutter/material.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
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
                      child: Image.asset(
                        'assets/images/icons/petropal_logo.png',
                        width: 200,
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(right: 10),
                      //       child: Image.asset(
                      //         'assets/images/icons/petropal_logo.png',
                      //         width: 40,
                      //       ),
                      //     ),
                      //     // Text(
                      //     //   'Petropal',
                      //     //   style: Theme.of(context)
                      //     //       .textTheme
                      //     //       .titleLarge!
                      //     //       .copyWith(color: Colors.black),
                      //     // )
                      //   ],
                      // ),
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
                        controller: emailAddress,
                        style: bodyText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: primaryDarkColor.withOpacity(0.1),
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
                        controller: password,
                        style: bodyText,
                        keyboardType: TextInputType.text,
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: primaryDarkColor.withOpacity(0.1),
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
                              color: primaryDarkColor.withOpacity(0.2),
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
                              builder: (context) => const Dashboard(),
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
                    )
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 48,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: primaryDarkColor),
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: ((context) => Dashboard())));
                    //     },
                    //     child: const Text('Login'),
                    //   ),
                    // ),
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
