import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/add_customer.dart';
import 'package:petropal/screens/dashboard/add_users/add_omc.dart';
import 'package:petropal/screens/dashboard/add_users/add_reseller.dart';

class AddUsers extends StatefulWidget {
  final String? selectedUserType;
  const AddUsers({super.key, required this.selectedUserType});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      widget.selectedUserType == 'Oil Marketing Company'
                          ? 'Add Oil Marketing Company'
                          : widget.selectedUserType == 'Resellers'
                              ? 'Add New Resellers'
                              : 'Add New Customers',
                      style: displayBigBoldBlack,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.selectedUserType == 'Oil Marketing Company')
                      const AddOMC()
                    else if (widget.selectedUserType == 'Resellers')
                      const AddReseller()
                    else if (widget.selectedUserType == 'Customers')
                      const AddCustomer()
                  ],
                )))));
  }
}
