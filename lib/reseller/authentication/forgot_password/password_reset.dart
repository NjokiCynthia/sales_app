import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/login.dart';
import 'package:http/http.dart' as http;

class PasswordReset extends StatefulWidget {
  final String pin;

  const PasswordReset({Key? key, required this.pin}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscured = true;
  bool _confirmObscured = true;

  String? _passwordError;
  String? _confirmPasswordError;

  String errorText = ' ';

  Future<void> resetPassword() async {
    // Clear existing error messages
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });
    print('I am here to now send the new password i want');
    // Validate password and confirm password
    _validatePassword(passwordController.text);
    _validateConfirmPassword(confirmPasswordController.text);

    if (_passwordError != null || _confirmPasswordError != null) {
      // If there are validation errors in the password fields, display them as text
      setState(() {
        errorText = 'Error:\n';
        if (_passwordError != null) {
          errorText += '- $_passwordError\n';
        }
        if (_confirmPasswordError != null) {
          errorText += '- $_confirmPasswordError';
        }
      });
      return;
    }
    // setState(() {
    //   errorText = '';
    // });
    // print('I am here to now send the new password i want');
    // if (_passwordError != null || _confirmPasswordError != null) {
    //   // If there are validation errors in the password fields, do not proceed
    //   return;
    // }

    try {
      final response = await http.post(
        // Uri.parse(
        //     'https://petropal.sandbox.co.ke:8040/user/reset-password-mobile'),
        Uri.parse('https://petropal.africa:8050/user/reset-password-mobile'),
        body: {
          'code': widget.pin,
          'new_password': confirmPasswordController.text,
        },
      );
      print('Here is my password and text and pin .....');
      print(widget.pin);
      print(confirmPasswordController.text);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        final status = responseData['status'];
        final message = responseData['message'];

        if (status == 'success') {
          final result = responseData['result'] as List;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Password Reset Success',
                  style: TextStyle(
                      color: primaryDarkColor, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Password reset successfully. Please proceed to Login',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
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
      print('Error during password reset: $error');
      setState(() {
        errorText = 'An error occurred during password reset';
      });
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Password cannot be empty';
        errorText = '';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Confirm password cannot be empty';
        errorText = '';
      });
    } else if (value != passwordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
        errorText = '';
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
      });
    }
  }

  // void _resetPassword() {
  //   if (passwordController.text.isEmpty) {
  //     setState(() {
  //       _passwordError = 'Password cannot be empty';
  //     });
  //   }

  //   if (confirmPasswordController.text.isEmpty) {
  //     setState(() {
  //       _confirmPasswordError = 'Confirm password cannot be empty';
  //     });
  //   }

  //   if (_passwordError == null &&
  //       _confirmPasswordError == null &&
  //       passwordController.text.isNotEmpty &&
  //       confirmPasswordController.text.isNotEmpty) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: ((context) => Login())),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryDarkColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Password reset',
          style: TextStyle(color: primaryDarkColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter your new password to reset.',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: errorText.isNotEmpty
                  ? Text(errorText,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold))
                  : null,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryDarkColor.withOpacity(0.1)),
                  child: Icon(
                    Icons.lock,
                    color: primaryDarkColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Enter your new password.',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              style: bodyText,
              obscureText: _isObscured,
              keyboardType: TextInputType.text,
              onChanged: _validatePassword,
              decoration: InputDecoration(
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[500]),
                labelStyle: TextStyle(color: Colors.grey[500]),
                errorText: passwordController.text.isEmpty && errorText != ' '
                    ? 'Password is required'
                    : null,
                //errorText: _passwordError,
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
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  child: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: primaryDarkColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryDarkColor.withOpacity(0.1)),
                  child: Icon(
                    Icons.lock,
                    color: primaryDarkColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Confirm your new password.',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: confirmPasswordController,
              style: bodyText,
              obscureText: _confirmObscured,
              keyboardType: TextInputType.text,
              onChanged: _validateConfirmPassword,
              decoration: InputDecoration(
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Confirm password',
                hintStyle: TextStyle(color: Colors.grey[500]),
                labelStyle: TextStyle(color: Colors.grey[500]),
                errorText:
                    confirmPasswordController.text.isEmpty && errorText != ' '
                        ? 'Password is required'
                        : null,
                //_confirmPasswordError,
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
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _confirmObscured = !_confirmObscured;
                    });
                  },
                  child: Icon(
                    _confirmObscured ? Icons.visibility_off : Icons.visibility,
                    color: primaryDarkColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDarkColor,
                ),
                onPressed: () {
                  resetPassword();
                },
                // _resetPassword,
                child: Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
