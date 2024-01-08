import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/forgot_password/otp_reset.dart';
import 'package:petropal/reseller/authentication/login.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController = TextEditingController();
  bool _isObscured = true;
  bool _confirmObscured = true;
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
              controller: emailController,
              style: bodyText,
              obscureText: _isObscured,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // prefixIcon: const Icon(Icons.email),
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
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
              controller: emailController,
              style: bodyText,
              obscureText: _isObscured,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // prefixIcon: const Icon(Icons.email),
                prefixIconColor: Colors.grey,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Confirm password',
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
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    },
                    child: Text('Reset Password'))),
          ],
        ),
      ),
    );
  }
}
