import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/forgot_password/password_reset.dart';

class OtpReset extends StatefulWidget {
  const OtpReset({super.key});

  @override
  State<OtpReset> createState() => _OtpResetState();
}

class _OtpResetState extends State<OtpReset> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: primaryDarkColor,
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
            OtpTextField(
              numberOfFields: 4,
              borderColor: primaryDarkColor,
              textStyle: TextStyle(color: primaryDarkColor),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              // onSubmit: (String verificationCode) {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text("Verification Code"),
              //           content: Text('Code entered is $verificationCode'),
              //         );
              //       });
              // },
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PasswordReset())));
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
