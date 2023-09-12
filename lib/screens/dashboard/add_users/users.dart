// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/add_users.dart';
import 'package:petropal/screens/dashboard/view_users/customer.dart';
import 'package:petropal/screens/dashboard/view_users/omc.dart';
import 'package:petropal/screens/dashboard/view_users/reseller.dart';

class User {
  final String name;
  final String email;
  final String location;

  User({required this.name, required this.email, required this.location});
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? selectedusertype;

  void showAddUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Add new user",
            style: TextStyle(
              color: primaryDarkColor, // Set text color to primaryDarkColor
              fontSize: 20, // Adjust font size if needed
            ),
          ),
          backgroundColor: Colors.white, // Set background color to white
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select the type of user you want to create:",
                style: TextStyle(
                  color: primaryDarkColor, // Set text color to primaryDarkColor
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Oil Marketing Company',
                    child: Text(
                      'Oil Marketing Company',
                      style: TextStyle(
                        color: primaryDarkColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Resellers',
                    child: Text(
                      'Resellers',
                      style: TextStyle(
                        color: primaryDarkColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Customers',
                    child: Text(
                      'Customers',
                      style: TextStyle(
                        color: primaryDarkColor,
                      ),
                    ),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedusertype = newValue;
                    print('this is my selected user $selectedusertype');
                  });
                },
                value: selectedusertype ??
                    'Resellers', // Set initial value to 'Resellers'
                isExpanded: true,
                dropdownColor: Colors.white,
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: primaryDarkColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(color: primaryDarkColor),
              ),
              onPressed: () {
                // Perform the action when the "Add" button is pressed

                print("Selected User Type: $selectedusertype");
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: ((context) =>
                          AddUsers(selectedUserType: selectedusertype))),
                );
                // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users',
                style: displayBigBoldBlack,
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: showAddUserDialog,
                  child: const Icon(
                    Icons.add,
                    color: primaryDarkColor,
                  ),
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: primaryDarkColor,
            tabs: [
              Tab(text: 'Oil Marketing Companies'),
              Tab(text: 'Resellers'),
              Tab(text: 'Customers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Omcs(),
            const Resellers(),
            const Customer(),
          ],
        ),
      ),
    );
  }
}
