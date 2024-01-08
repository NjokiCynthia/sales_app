// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({super.key});

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  String? selectedBank;
  String? selectedBranch;

  final List<String> kenyanBanks = [
    'KCB Bank',
    'Equity Bank',
    'Cooperative Bank',
    'Standard Chartered Bank',
    'Barclays Bank',
    'Absa Bank',
    'National Bank of Kenya',
    'CfC Stanbic Bank',
    'Family Bank',
    'NIC Bank',
    'Sidian Bank',
    'Diamond Trust Bank',
    'Chase Bank',
    'Ecobank',
    'HFC Bank',
    'Credit Bank',
  ];
  final Map<String, List<String>> bankBranches = {
    'KCB Bank': [
      'KCB Nairobi Branch',
      'KCB Mombasa Branch',
      'KCB Kisumu Branch',
      'KCB Nakuru Branch',
      'KCB Eldoret Branch',
      // Add more KCB branches...
    ],
    'Equity Bank': ['Branch A', 'Branch B', 'Branch C'],
    'Cooperative Bank': ['Branch X', 'Branch Y', 'Branch Z'],
    // Add more branches...
  };

// Helper function to capitalize each word
  String capitalize(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toUpperCase();
    }
    return words.join(' ');
  }

  final TextEditingController email_ctrl = TextEditingController();

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';

  void validateBankInputs() {
    if (email_ctrl == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryDarkColor,
                    ),
                  ),
                  Text(
                    'Bank Account Details',
                    style: m_title,
                  ),
                  Container(
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                value: selectedBank,
                dropdownColor: Colors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBank = newValue;
                  });
                },
                items: kenyanBanks.map((String bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child:
                        Text(capitalize(bank)), // Use the capitalize function
                  );
                }).toList(),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Bank Name',
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
                ),
              ),
              const SizedBox(height: 20),
              // Second Dropdown for Branches
              if (selectedBank != null && selectedBank == 'KCB Bank')
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: selectedBranch,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBranch = newValue;
                    });
                  },
                  items: bankBranches[selectedBank]!.map((String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Bank Name',
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
                  ),
                ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (text) {
                  validateBankInputs();
                },
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: email_ctrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Account Number',
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResellerProfile()));
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
