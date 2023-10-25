import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';

class OrganisationDetails extends StatefulWidget {
  const OrganisationDetails({super.key});

  @override
  State<OrganisationDetails> createState() => _OrganisationDetailsState();
}

class _OrganisationDetailsState extends State<OrganisationDetails> {
  final TextEditingController phone_number_ctrl = TextEditingController();
  final TextEditingController email_ctrl = TextEditingController();
  String phone_number_inpt = '';
  String initialCountry = 'KE';

  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now, // Set the minimum selectable date to today
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  String? selectedDocumentTitle;
  String? selectedKraPinDocumentTitle;
  String? selectedCertTitle;

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

  Future<void> openCertFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file here
      PlatformFile file = result.files.first;
      print('File Name: ${file.name}');
      print('File Size: ${file.size}');
      // You can upload the file to your server or perform other actions.

      setState(() {
        selectedCertTitle = file.name; // Update the selectedDocumentTitle
      });
    } else {
      // User canceled the file picker
    }
  }

  Future<void> openKraPinFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected KRA PIN document here
      PlatformFile file = result.files.first;
      print('KRA PIN Document Name: ${file.name}');
      print('KRA PIN Document Size: ${file.size}');

      setState(() {
        selectedKraPinDocumentTitle = file.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  void validateOrganisationInputs() {
    if (phone_number_inpt == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[10],
    ));
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[10],
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResellerProfile()));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: primaryDarkColor,
                ))),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/icons/avatar.png'),
                  radius: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    setState(() {
                      phone_number_inpt = number.phoneNumber ?? '';
                    });
                    validateOrganisationInputs();
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
                  textFieldController: phone_number_ctrl,
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
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    //labelStyle: bodyTextSmall,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
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
                  onSaved: (PhoneNumber number) {},
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  //obscureText: true,

                  style: bodyText,
                  controller: email_ctrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter Email Address',
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  //obscureText: true,

                  style: bodyText,
                  controller: email_ctrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'EPRA License Number',
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _dateController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Select expriry Date',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: primaryDarkColor,
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
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
                  readOnly: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(children: [
                  GestureDetector(
                    onTap: openFilePicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Upload EPRA license',
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
                ]),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  style: bodyText,
                  controller: email_ctrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'KRA PIN',
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
                SizedBox(
                  height: 10,
                ),
                Column(children: [
                  GestureDetector(
                    onTap: openKraPinFilePicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Upload KRA PIN certificate',
                          style: bodyText,
                        ),
                      ),
                    ),
                  ),
                  if (selectedKraPinDocumentTitle != null)
                    Text(
                      '$selectedKraPinDocumentTitle',
                      style: bodyText,
                    ),
                ]),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  style: bodyText,
                  controller: email_ctrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Cerificate of Incoporation',
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
                SizedBox(
                  height: 10,
                ),
                Column(children: [
                  GestureDetector(
                    onTap: openCertFilePicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Upload certificate of incorporation',
                          style: bodyText,
                        ),
                      ),
                    ),
                  ),
                  if (selectedKraPinDocumentTitle != null)
                    Text(
                      '$selectedCertTitle',
                      style: bodyText,
                    ),
                ]),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResellerProfile()));
                        },
                        child: Text('Confirm')))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
