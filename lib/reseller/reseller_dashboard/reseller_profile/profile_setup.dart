import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';
import 'package:petropal/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileSetUp extends StatefulWidget {
  const ProfileSetUp({super.key});

  @override
  State<ProfileSetUp> createState() => _ProfileSetUpState();
}

class _ProfileSetUpState extends State<ProfileSetUp>
    with SingleTickerProviderStateMixin {
  String? selectedBranch;

  late TabController _tabController;
  final TextEditingController ONameontroller = TextEditingController();
  final TextEditingController OAddressontroller = TextEditingController();
  final TextEditingController OPhoneontroller = TextEditingController();
  final TextEditingController OEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController eController = TextEditingController();
  final TextEditingController minVolController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController licensedate = TextEditingController();
  final TextEditingController kraController = TextEditingController();
  final TextEditingController kraDocument = TextEditingController();
  final TextEditingController certController = TextEditingController();
  final TextEditingController certUpload = TextEditingController();

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
    'Equity Bank': [
      'Head Office, Equity Centre Branch NAIROBI',
      'CORPORATE Branch, NAIROBI',
      'FOURWAYS Branch, NAIROBI',
      'KANGEMA Branch, KANGEMA',
      'KARATINA Branch, KARATINA',
      'KIRIAINI Branch, KIRIANI',
      'MURARANDIA Branch, MURARANDIA',
      'HARAMBEE A Branch, NAIROBI',
      'KIMATHI ST Branch, NAIROBI',
    ],
    'Cooperative Bank': ['Branch X', 'Branch Y', 'Branch Z'],
    // Add more branches...
  };

  String capitalize(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toUpperCase();
    }
    return words.join(' ');
  }

  List<String> bankNames = [];
  String? selectedBank;

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
        licensedate.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  String? selectedDocumentTitle;
  String? selectedKraPinDocumentTitle;
  String? selectedCertTitle;

  List<PlatformFile>?
      selectedFiles; // Change the variable to hold a list of PlatformFile

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file here
      selectedFiles = result.files; // Assign the selected files to the variable

      if (selectedFiles != null && selectedFiles!.isNotEmpty) {
        PlatformFile file = selectedFiles![
            0]; // Assuming you're handling only the first selected file
        print('File Name: ${file.name}');
        print('File Size: ${file.size}');

        setState(() {
          selectedDocumentTitle = file.name; // Update the selectedDocumentTitle
        });
      }
    } else {
      // User canceled the file picker
    }
  }

  bool _obscurePassword = true;

  PlatformFile? selectedCertificateOfIncorporationDocument; // Add this variable

  Future<void> openCertFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected certificate of incorporation document here
      PlatformFile file = result.files.first;
      print('Certificate of Incorporation Document Name: ${file.name}');
      print('Certificate of Incorporation Document Size: ${file.size}');

      setState(() {
        selectedCertTitle = file.name;
        selectedCertificateOfIncorporationDocument =
            file; // Assign the selected file to the variable
      });
    } else {
      // User canceled the file picker
    }
  }

  PlatformFile? selectedKraCertificatePhoto; // Add this variable

  Future<void> openKraPinFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected KRA certificate photo here
      PlatformFile file = result.files.first;
      print('KRA Certificate Photo Name: ${file.name}');
      print('KRA Certificate Photo Size: ${file.size}');

      setState(() {
        selectedKraPinDocumentTitle = file.name;
        selectedKraCertificatePhoto = file;
      });
    } else {}
  }

  String phone_number_inpt = '';
  String initialCountry = 'KE';

  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  Future<void> sendFormData() async {
    final url =
        Uri.parse('https://petropal.sandbox.co.ke:8040/user/update-profile');
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;

    final token = userProvider.user?.token;

    if (token == null) {
      return;
    }

    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final formData = FormData.fromMap({
        'kra_certificate_number': kraController.text,
        'epra_license_number': licenseController.text,
        'epra_license_expiry_date': selectedDate.toLocal().toString(),
        'certificate_of_incorporation_number': certController.text,
        'email': emailController.text,
        'phone': numberController.text,
        'firstname': user?.first_name ?? '',
        'lastname': user?.last_name ?? '',
        'account_id': user?.account_id.toString() ?? '',
        'minimum_volume_per_order': minVolController.text,
        'pic': '',
      });

      if (selectedKraCertificatePhoto != null) {
        formData.files.add(MapEntry(
          'kra_certificate_photo',
          await MultipartFile.fromFile(
            selectedKraCertificatePhoto!.path.toString(),
            filename: selectedKraCertificatePhoto!.name,
          ),
        ));
      }

      if (selectedFiles != null && selectedFiles!.isNotEmpty) {
        final file = selectedFiles![0];
        formData.files.add(MapEntry(
          'epra_license_photo',
          await MultipartFile.fromFile(file.path.toString(),
              filename: file.name),
        ));
      }

      if (selectedCertificateOfIncorporationDocument != null) {
        formData.files.add(MapEntry(
          'certificate_of_incorporation_photo',
          await MultipartFile.fromFile(
            selectedCertificateOfIncorporationDocument!.path.toString(),
            filename: selectedCertificateOfIncorporationDocument!.name,
          ),
        ));
      }
      print('@############ FILES ########################');
      // Log the specific details of each field in formData
      print(formData.files);

      print('@############ FIELDS ########################');
      // Log the specific details of each field in formData
      for (var entry in formData.fields) {
        print('Field: ${entry.key} - Value: ${entry.value}');
      }

// Log the specific details of each file in formData
      for (var entry in formData.files) {
        print(
            'File Name: ${entry.value.filename} - Field Name: ${entry.key} - Content Type: ${entry.value.contentType}');
      }

// Log the entire request payload for debugging
      print('Request payload details: ${dio.options} $formData');

      final response = await dio.post(
        url.toString(),
        data: formData,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Request was successful. Response data: $responseData');
        _tabController.animateTo(1);
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (err) {
      print('Error sending the request: $err');
    }
  }

  // Future<void> sendBankData() async {
  //   print('sendBankData() called');
  //   final userProvider = UserProvider();
  //   final token = userProvider.user?.token;

  //   if (token == null) {
  //     return;
  //   }

  //   final url = Uri.parse(
  //       'https://petropal.sandbox.co.ke:8040/account/update/bank_details');

  //   // Define the form data
  //   final formData = {
  //     'account_id': '9',
  //     'bank_details':
  //         '[{"bank_name": $selectedBank,"bank_code": "123","bank_branch": $selectedBranch,"account_number": $accountController}]',
  //   };

  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     },
  //     body: formData,
  //   );

  //   if (response.statusCode == 200) {
  //     // Request was successful
  //     print('Request was successful');
  //     print(response);
  //     _tabController.animateTo(2);
  //   } else {
  //     // Request failed
  //     print('Request failed with status code: ${response.statusCode}');
  //   }
  // }

  int currentTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabChange);

    fetchBanks();

    // Access the UserProvider and retrieve the user data
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;

    if (user != null) {
      // Use the user data in your form fields and for debugging
      print('User first name is : ${user.first_name}');
      print('User last name is: ${user.last_name}');

      print('User email is: ${user.email}');
      print('User phone number is: ${user.phone}');
      print('User account id is: ${user.account_id}');
      print('My company email is: ${user.companyAddress}');
      print('My company name is: ${user.companyName}');
      print('My company phone is: ${user.companyPhone}');
      print('My company password is: ${user.password}');
      print('User token is: ${user.token}');

      emailController.text = user.email;
      numberController.text = user.phone;
      nameController.text = user.first_name;
      phoneController.text = user.phone;
      passwordController.text = user.password;
      OEmailController.text = user.companyAddress;
      ONameontroller.text = user.companyName;
      OPhoneontroller.text = user.companyPhone;
    }
  }

  void _handleTabChange() {
    setState(() {
      currentTab = _tabController.index;
    });
  }

  Future<void> fetchBanks() async {
    final baseUrl = 'https://petropal.sandbox.co.ke:8040';
    final response = await http.get(Uri.parse('$baseUrl/bank/get-all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        // Map data to a list of bank names
        bankNames = data.map((bank) => bank['name'].toString()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Set up your profile',
                  style: displayBigBoldBlack,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: primaryDarkColor,
                    labelStyle: displaySmaller,
                    labelColor: primaryDarkColor,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "Organisation",
                      ),
                      Tab(text: "Bank"),
                      Tab(text: "Contact"),
                      Tab(text: "Password"),
                      Tab(text: "Profile"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildFirstPage(),
                      buildSecondPage(),
                      buildThirdPage(),
                      buildFourthPage(),
                      buildFifthPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstPage() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/icons/avatar.png'),
              radius: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                setState(() {
                  phone_number_inpt = number.phoneNumber ?? '';
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
              textFieldController: numberController,
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                //validateOrganisationInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: emailController,
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                //validateOrganisationInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: minVolController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Minimum volume per order',
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
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                //validateOrganisationInputs();
              },
              keyboardType: TextInputType.text,
              //obscureText: true,

              style: bodyText,
              controller: licenseController,
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: licensedate,
              style: bodyText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Select expriry Date',
                suffixIcon: IconButton(
                  icon: const Icon(
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
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                //validateOrganisationInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: kraController,
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
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (text) {
                //validateOrganisationInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: certController,
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
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Call the function to send the form data when the button is pressed
                sendFormData();
              },
              child: Text('Submit'), // You can customize the button text here
            )
          ]),
        ),
      ),
    );
  }

  Widget buildSecondPage() {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;
    return SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
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
                  child: Text(capitalize(bank)), // Use the capitalize function
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
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: primaryDarkColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                  labelText: 'Bank Branch',
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
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (text) {
                // validateBankInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: accountController,
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
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (text) {
                // validateBankInputs();
              },
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: accountName,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Account Name',
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
            CustomRequestButton(
                url: '/account/update/bank_details',
                method: 'POST',
                buttonText: 'Confirm',
                headers: {},
                body: {
                  "account_number": accountController.text,
                  "account_name": accountName.text,
                  "bank_id": 50,
                  "branch_id": 1592,
                  "account_id": user?.account_id.toString() ?? '',
                },
                onSuccess: (res) {
                  print('This is my response');
                  print(res);

                  final isSuccessful = res['isSuccessful'] as bool;

                  final message = res['message'];
                  if (isSuccessful) {
                    final data = res['data'] as Map<String, dynamic>?;

                    if (data != null) {
                      _tabController.animateTo(2);
                    } else {
                      print(message);
                    }
                  }
                })
          ],
        ),
      )),
    );
  }

  Widget buildThirdPage() {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter Name',
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
              SizedBox(
                height: 20,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  setState(() {
                    phone_number_inpt = number.phoneNumber ?? '';
                  });
                  // validateContactInputs();
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
                textFieldController: phoneController,
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: emailController,
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
              const SizedBox(
                height: 40,
              ),
              CustomRequestButton(
                  url: '/contact-persons/create',
                  method: 'POST',
                  buttonText: 'Add details',
                  headers: {},
                  body: {
                    "name": nameController.text,
                    "phone": phoneController.text,
                    "email": emailController.text,
                    "position": positionController.text,
                    "accountId": user?.account_id.toString() ??
                        '', //account id of the reseller
                    "created_by": 61 // id of the logged in user
                  },
                  onSuccess: (res) {
                    print('This is my response');
                    print(res);

                    final isSuccessful = res['isSuccessful'] as bool;

                    final message = res['message'];
                    if (isSuccessful) {
                      final data = res['data'] as Map<String, dynamic>?;

                      if (data != null) {
                        _tabController.animateTo(3);
                      } else {
                        print(message);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFourthPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              //obscureText: true,
              obscureText: _obscurePassword,
              style: bodyText,
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Current password',
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
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Forgot password?",
              style: TextStyle(color: primaryDarkColor),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              //obscureText: true,
              obscureText: _obscurePassword,
              style: bodyText,
              controller: confirmController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'New password',
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
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              //obscureText: true,
              obscureText: _obscurePassword,
              style: bodyText,
              controller: verifyController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Verify password',
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
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
                child: const Text('Confirm'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFifthPage() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: ONameontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Organisation Name',
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
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: OEmailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Organisation address',
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
                height: 20,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  setState(() {
                    phone_number_inpt = number.phoneNumber ?? '';
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
                textFieldController: OPhoneontroller,
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
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: bodyText,
                controller: OEmailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Organisation Email',
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
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  child: const Text('Confirm Details'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ResellerDasboard())));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
