import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String input = '';
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool isPhoneNumber(String input) {
    // You can implement your own logic to determine if it's a phone number
    // For simplicity, this example checks if the input contains only digits.
    return RegExp(r'^[0-9]+$').hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPhoneNumber(input)) // Check if input is a phone number
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  setState(() {
                    this.number = number;
                  });
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  setSelectorButtonAsPrefixIcon: true,
                  leadingPadding: 10,
                ),
                textStyle: bodyText,
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                initialValue: number,
                textAlignVertical: TextAlignVertical.top,
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                maxLength: 10,
                inputBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                inputDecoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Phone number',
                  labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                      .copyWith(color: Colors.grey),
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
                      width: 2.0,
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
                onSaved: (PhoneNumber number) {},
              )
            else
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    input = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Phone number or Email',
                  // Other TextFormField properties...
                ),
                keyboardType: TextInputType.text,
              ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (isPhoneNumber(input)) {
                  // Handle phone number input
                  print('Phone Number: ${number.phoneNumber}');
                } else {
                  // Handle email input
                  print('Email: $input');
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => Dashboard())));
              },
              child: Text('Confirm'),
            )
          ],
        ),
      ),
    ));
  }
}
