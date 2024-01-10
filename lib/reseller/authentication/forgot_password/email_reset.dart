import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/forgot_password/otp_reset.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String errorText = ' ';
  Future<int> forgotPassword() async {
    setState(() {
      errorText = '';
    });
    print('I am here to send email for reset password');

    try {
      final response = await http.post(
        // Uri.parse(
        //     'https://petropal.sandbox.co.ke:8040/user/forgot-password-mobile'),
        Uri.parse(
            'https://petropal.africa:8050/user/forgot-password-mobile'),
        body: {
          'email': emailController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('This is my response here');
        print(responseData);

        final status = responseData['status'];
        final message = responseData['message'];

        if (status == 'success') {
          final result = responseData['result'] as List;
          final code = responseData['code'] as int;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpReset(code: code),
            ),
          );
          return code;
        } else {
          setState(() {
            errorText = message;
          });
          return 0;
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
        return 0;
      }
    } catch (error) {
      print('Error during forgot password: $error');
      setState(() {
        errorText = 'An error occurred during password reset';
      });
      return 0;
    }
  }

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
          'Reset Password',
          style: TextStyle(color: primaryDarkColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter your email address to enable 2-step verification and password reset.',
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
                    Icons.email,
                    color: primaryDarkColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Enter your email address.',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              style: bodyText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // prefixIcon: const Icon(Icons.email),
                errorText: emailController.text.isEmpty && errorText != ' '
                    ? 'Email is required'
                    : null,
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email address',
                hintStyle: TextStyle(color: Colors.grey[500]),
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
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      forgotPassword();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => OtpReset())));
                    },
                    child: Text('Continue')))
          ],
        ),
      ),
    );
  }
}
