import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/forgot_password/password_reset.dart';
import 'package:http/http.dart' as http;

class OtpReset extends StatefulWidget {
  final int code;

  const OtpReset({Key? key, required this.code}) : super(key: key);

  @override
  State<OtpReset> createState() => _OtpResetState();
}

class _OtpResetState extends State<OtpReset> {
  TextEditingController codeController = TextEditingController();
  String errorText = ' ';
  String pin = '';
  Future<void> verifyPasswordResetCode() async {
    setState(() {
      errorText = '';
    });
    print('I am here to verify email OTP');

    try {
      final requestBody = {'code': pin};
      print("Full request body structure: $requestBody");

      final response = await http.post(
        // Uri.parse(
        //     'https://petropal.sandbox.co.ke:8040/user/forgot-password-code'),
        Uri.parse('https://petropal.africa:8050/user/forgot-password-code'),

        body: requestBody,
      );

      print('Here is the code i am sending');
      print(pin);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        final status = responseData['status'];
        final message = responseData['message'];

        if (status == 1) {
          final userData = responseData['user'];
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Password Reset Code',
                  style: TextStyle(
                      color: primaryDarkColor, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Password reset code verified successfully. Proceed to reset your password.',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PasswordReset(pin: pin))));
                    },
                    child: Text('OK'),
                  )
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
      print('Error during code verification: $error');
      setState(() {
        errorText = 'An error occurred during code verification';
      });
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
          'OTP Verification',
          style: TextStyle(color: primaryDarkColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We have sent you a code to verify your email address. Please enter it below.',
              style: TextStyle(color: Colors.black),
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
                    Icons.numbers_sharp,
                    color: primaryDarkColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Enter the code sent to your email',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 80,
              style: TextStyle(fontSize: 17, color: primaryDarkColor),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
                setState(() {
                  this.pin = pin;
                });
              },
            ),
            // OtpTextField(
            //   numberOfFields: 4,

            //   borderColor: primaryDarkColor,
            //   textStyle: TextStyle(color: primaryDarkColor),
            //   showFieldAsBox: true,
            //   onCodeChanged: (String code) {
            //     print("Completed code is: " + code);
            //     if (code.length == 4) {
            //       setState(() {
            //         this.code = code; // Update the code variable
            //         // Use the 4-digit code immediately
            //         print('MY CODE IS $code');
            //       });
            //     }

            //     // setState(() {
            //     //   this.code = code;
            //     // });
            //   },
            //   decoration: InputDecoration(
            //     prefixIcon: const Icon(Icons.lock),
            //     prefixIconColor: Colors.grey,
            //     filled: true,
            //     fillColor: Colors.white,
            //     labelText: 'Enter password',
            //     errorText: codeController.text.isEmpty && errorText != ' '
            //         ? 'Password is required'
            //         : null,
            //     labelStyle: TextStyle(color: Colors.grey[500]),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: primaryDarkColor.withOpacity(0.1),
            //         width: 0.5,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: primaryDarkColor.withOpacity(0.1),
            //         width: 2.0,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //         color: primaryDarkColor,
            //         width: 1.0,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            //   // onSubmit: (String verificationCode) {
            //   //   showDialog(
            //   //       context: context,
            //   //       builder: (context) {
            //   //         return AlertDialog(
            //   //           title: Text("Verification Code"),
            //   //           content: Text('Code entered is $verificationCode'),
            //   //         );
            //   //       });
            //   // },
            // ),
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
                      verifyPasswordResetCode();

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => PasswordReset())));
                    },
                    child: Text('Continue'))),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Didn't receive a code?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "RESEND.",
                style: TextStyle(color: primaryDarkColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
