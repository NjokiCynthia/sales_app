import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/superadmin_dashboard/view_users/users.dart';

class AddOMC extends StatefulWidget {
  const AddOMC({super.key});

  @override
  State<AddOMC> createState() => _AddOMCState();
}

class _AddOMCState extends State<AddOMC> {
  String initialCountry = 'KE';

  String enteredDate = ''; // Store the entered date
  String enteredNumber = ''; // Store the entered number

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Enter the EPRA license expiry date',
                              style: bodyText),
                          const SizedBox(height: 10),
                          TextFormField(
                            style: bodyText,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                enteredDate = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Enter date',
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
                          Text('Enter your EPRA license number',
                              style: bodyText),
                          const SizedBox(height: 10),
                          TextFormField(
                            style: bodyText,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                enteredNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Enter number',
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
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryDarkColor),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Close the bottom sheet
                                _showConfirmation(); // Display the confirmation dialog
                              },
                              child: const Text('Confirm'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Please confirm the details',
            style: displayTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Entered Date: $enteredDate',
                style: bodyText,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Entered Number: $enteredNumber',
                style: bodyText,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: primaryDarkColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: bodyText,
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    child: Text(
                      'Confirm',
                      style: bodyText,
                    ))
              ],
            )
          ],
        );
      },
    );
  }

  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  String? selectedDocumentTitle; // To store the selected document title

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file here
      PlatformFile file = result.files.first;
      print('File Name: ${file.name}');
      print('File Size: ${file.size}');
      // You can upload the file to your server or perform other actions.

      setState(() {
        selectedDocumentTitle = file.name; // Update the selectedDocumentTitle
      });
    } else {
      // User canceled the file picker
    }
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: openFilePicker,
                  child: Container(
                    width: 150, // Set the desired width
                    padding: const EdgeInsets.all(
                        10), // Adjust the padding as needed
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
                ),
                if (selectedDocumentTitle != null)
                  Text(
                    '$selectedDocumentTitle',
                    style: bodyText,
                  ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _openBottomSheet(context);
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'EPRA no. and date',
                    style: bodyText,
                  ),
                ),
              ),
            ),
          ],
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
              Icons.document_scanner_sharp,
              color: primaryDarkColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Upload Business Permit Document',
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
              'Upload KRA Pin Certifcate',
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UsersScreen()));
              },
              child: const Text(
                'Confirm',
              )),
        )
      ],
    );
  }
}
