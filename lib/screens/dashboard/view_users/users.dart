// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/add_users.dart';
import 'package:petropal/screens/dashboard/approval/approve_users.dart';
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
  String selectedusertype = 'Resellers';

  // List of items in our dropdown menu
  var items = ['Oil Marketing Companies', 'Resellers', 'Customers'];

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
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  value: selectedusertype,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(color: primaryDarkColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedusertype = newValue!;
                    });
                  }),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: primaryDarkColor)),
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
                print("Selected User Type: $selectedusertype");
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: ((context) =>
                          AddUsers(selectedUserType: selectedusertype))),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: ((context) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Choose your preferred actions',
                  style: m_title,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: showAddUserDialog,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: primaryDarkColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Add new user',
                                style: displayTitle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryDarkColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.add,
                                    color: primaryDarkColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ApproveUsers()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: primaryDarkColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Approve users',
                                style: displayTitle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryDarkColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.check,
                                    color: primaryDarkColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                  onTap: showBottomSheet,
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
              //Tab(text: 'Customers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Omcs(),
            Resellers(),
            // Customers(),
          ],
        ),
      ),
    );
  }
}
