import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/login.dart';

import 'package:petropal/reseller/reseller_dashboard/reseller_profile/bank_account_details.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/organisation_details.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/organisation_profile.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/view_staff.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ResellerProfile extends StatefulWidget {
  const ResellerProfile({Key? key}) : super(key: key);

  @override
  State<ResellerProfile> createState() => _ResellerProfileState();
}

class _ResellerProfileState extends State<ResellerProfile> {
  String errorText = '';

  Future<void> deleteAccount(String password) async {
    print('I am here to delete my account');
    setState(() {
      errorText = '';
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    if (token == null) {
      print('Token is null.');
      return;
    }

    final postData = {
      "password": password,
    }; // Use the passed password parameter

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    print('Request Data: $postData');

    try {
      final response =
          await apiClient.post('/user/delete-user', postData, headers: headers);
      print('Response IS HERE now: $response');

      final Map<String, dynamic> responseData = response;
      print('Response Data: $responseData');

      final status = responseData['status'];
      final message = responseData['message'];

      if (status == 0) {
        // Account deleted successfully
        // Perform any additional actions if needed
        print('Account deleted successfully');
      } else {
        setState(() {
          errorText = message ?? 'An error occurred while deleting the account';
        });
      }
    } catch (e) {
      // Handle network errors or unexpected exceptions
      print('Error: $e');
      setState(() {
        errorText = 'An error occurred. Please try again later.';
      });
    }
  }

  final TextEditingController _textController = TextEditingController();

  void _showDialog(BuildContext context) {
    bool isObscured = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Please confirm you want to delete your account',
            style: bodyText,
          ),
          content: TextFormField(
            controller: _textController,
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Enter your password.',
              labelStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                child: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: primaryDarkColor.withOpacity(0.7),
                ),
              ),
            ),
            obscureText: isObscured,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: primaryDarkColor),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: primaryDarkColor),
                  ),
                ),
                Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
                ElevatedButton(
                  child: const Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  onPressed: () {
                    // Close the dialog

                    // Call the deleteAccount function with the entered password
                    deleteAccount(_textController.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => const Login())));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to show the logout confirmation dialog.
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: primaryDarkColor.withOpacity(0.5)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const Login())));

                //Navigator.of(context).pop();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: primaryDarkColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[50]));
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/icons/avatar.png'),
                        radius: 20,
                      ),
                      Text(
                        'Settings and more',
                        style: m_title,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/icons/avatar.png'),
                      radius: 20,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        userProvider.user?.username ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        userProvider.user?.email ?? '',
                        style: const TextStyle(
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                        screen: const OrganisationDetails());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.location_city,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Organisation Details', style: bodyGrey),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('Essential organisation information',
                            style: greyT),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ), // Adjust the spacing

                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const BankAccountDetails(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.account_balance,
                            color: primaryDarkColor,
                          )
                          // Image.asset(
                          //   'assets/images/bank.png',
                          //   height: 25,
                          //   width: 25,
                          //   color: primaryDarkColor,
                          // )
                          ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Bank Account Details',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('Manage your bank account information',
                            style: greyT),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const ViewStaff(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.phone,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Staff management',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Add staff who can access your account',
                          style: greyT,
                        ),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const OrganisationProfile(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/users.png',
                            height: 25,
                            width: 25,
                            color: primaryDarkColor,
                          )),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Organization Profile',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Customize your organization's public profile",
                          style: greyT,
                        ),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: (() {
                    _showDialog(context);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.lock,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Manage Account',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Delete your profile",
                          style: greyT,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: primaryDarkColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      icon: const Icon(Icons.exit_to_app, color: Colors.red),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red.withOpacity(0.8)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
