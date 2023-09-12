import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/users.dart';

class AddOMC extends StatefulWidget {
  const AddOMC({super.key});

  @override
  State<AddOMC> createState() => _AddOMCState();
}

class _AddOMCState extends State<AddOMC> {

  String initialCountry = 'KE';

  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.perm_identity,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Name of the company',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          style: bodyText,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Enter the name',
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
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Phone number',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            setState(() {
              // phone_number_inpt = number.phoneNumber ?? '';
            });
            //  validateSignupInputs();
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
            labelText: 'Enter Phone number',
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
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.email,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Email address',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          style: bodyText,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Enter Email address',
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
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.edit_document,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Upload EPRA license document',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 150, // Set the desired width
          padding: const EdgeInsets.all(10), // Adjust the padding as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10), // Grey border
          ),
          child: Center(
            child: Text(
              'Upload',
              style: bodyText,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.document_scanner_sharp,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Upload Certificate of Incoporation',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 150, // Set the desired width
          padding: const EdgeInsets.all(10), // Adjust the padding as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10), // Grey border
          ),
          child: Center(
            child: Text(
              'Upload',
              style: bodyText,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(
              Icons.location_pin,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Location',
              style: bodyText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          style: bodyText,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Enter Location',
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
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const UsersScreen()));
              },
              child: const Text(
                'Confirm',
              )),
        )
      ],
    );
  }
}
