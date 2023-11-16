// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/banks_model.dart';
import 'package:petropal/models/branches.dart';
import 'package:petropal/models/positions_model.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/success.dart';
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

  String selectedPosition = 'Select Location';
  int selectedPositionIndex = -1;
  List<PositionModel> positions = [];

  List<String> positionsDropdownList = [];
  List<String> positionItems = ['Select location'];

  bool fetchingPositions = true;
  void _fetchPositions(BuildContext context) async {
    setState(() {
      fetchingPositions = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/position/get-all',
        postData,
        headers: headers,
      );

      print('This is my positions Response: $response');
      //Rprint();

      setState(() {
        positions = [];
        positionsDropdownList = [];
      });

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final tempPositionModels = data.map((positionData) {
          return PositionModel(
            id: int.parse(positionData['id'].toString()),
            name: positionData['name'].toString(),
            description: positionData['description'].toString(),
          );
        }).toList();

        setState(() {
          positions = tempPositionModels;
          selectedPosition = '${positions[0].id}';
          positionsDropdownList =
              tempPositionModels.map((position) => '${position.name}').toList();
        });
      } else {
        print('No or invalid positions found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Positions Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingPositions = false;
    });
  }

  String capitalize(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toUpperCase();
    }
    return words.join(' ');
  }

  List<String> bankNames = [];

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
    // final url =
    //     Uri.parse('https://app.petropal.africa:8050/user/update-profile');
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
        'epra_license_expiry_date':
            DateFormat('yyyy-MM-dd').format(selectedDate.toLocal()),

        //'epra_license_expiry_date': selectedDate.toLocal().toString(),
        'certificate_of_incorporation_number': certController.text,
        'email': emailController.text,
        'phone': numberController.text,
        'firstname': user?.first_name ?? '',
        'lastname': user?.last_name ?? '',
        'account_id': user?.account_id.toString() ?? '',
        'minimum_volume_per_order': 0.0,
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

  int currentTab = 0;
  bool fetchingBanks = true;
  List<Bank> banks = [];
  int selectedBankIndex = -1;
  int selectedBranchIndex = -1;

  List<String> banksDropdownList = [];
  List<String> bankItems = ['Select bank'];
  String selectedBank = 'Select Bank';
  void _fetchBanks(BuildContext context) async {
    setState(() {
      fetchingBanks = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      apiClient
          .post(
        '/bank/get-all',
        postData,
        headers: headers,
      )
          .then((response) {
        print('This is my banks Response: $response');
        setState(() {
          banks = [];
          banksDropdownList = [];
        });

        if (response['status'] == 1 && response['data'] != null) {
          final data = List<Map<String, dynamic>>.from(response['data']);
          final tempBankModels = data.map((bankData) {
            return Bank(
              id: int.parse(bankData['id'].toString()),
              name: bankData['name'].toString(),
              active: bankData['active'] as bool?,
              bankId: bankData['bank_id'] as int?,
              createdAt: bankData['createdAt'] as String?,
              updatedAt: bankData['updatedAt'] as String?,
            );
          }).toList();

          setState(() {
            banks = tempBankModels;
            selectedBank = '${banks[0].id}';
            banksDropdownList =
                tempBankModels.map((bank) => '${bank.name}').toList();
          });
        } else {
          print('No or invalid bankss found in the response');
          // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
        }
      });
    } catch (error) {
      print('Banks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingBanks = false;
    });
  }

  bool fetchingBranches = false;
  List<Branch> branches = [];
  List<String> branchesDropdownList = [];
  String selectedBranch = 'Select Branch';
  void _fetchBankBranches(BuildContext context, String bankId) async {
    setState(() {
      fetchingBranches = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {
      "queryParams": bankId,
    };
    print('This is the bank id i am passing');
    print(bankId);
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/bank-branch/get-all',
        postData,
        headers: headers,
      );

      print('This is my branches Response: $response');

      setState(() {
        branches = [];
        branchesDropdownList = [];
      });

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final tempBranchModels = data.map((branchData) {
          return Branch(
            id: int.parse(branchData['id'].toString()),
            bankId: branchData['bank_id'].toString(),
            code: branchData['code'].toString(),
            name: branchData['name'].toString(),
            active: branchData['active'] as bool?,
            createdAt: branchData['createdAt']?.toString(),
            updatedAt: branchData['updatedAt']?.toString(),
          );
        }).toList();

        setState(() {
          branches = tempBranchModels;
          selectedBranch = '${branches[0].id}';
          branchesDropdownList =
              tempBranchModels.map((branch) => '${branch.name}').toList();
        });
      } else {
        print('No or invalid branches found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Banks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingBranches = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBanks(context);
    _fetchPositions(context);
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
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
                  padding: const EdgeInsets.all(0),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: primaryDarkColor,
                    labelStyle: displaySmaller,
                    labelColor: primaryDarkColor,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: "Organisation",
                      ),
                      Tab(text: "Bank"),
                      Tab(text: "Contact"),
                      // Tab(text: "Password"),
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
                      // buildFourthPage(),
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
            // TextFormField(
            //   onChanged: (text) {
            //     //validateOrganisationInputs();
            //   },
            //   keyboardType: TextInputType.text,
            //   style: bodyText,
            //   controller: minVolController,
            //   decoration: InputDecoration(
            //     filled: true,
            //     fillColor: Colors.white,
            //     labelText: 'Minimum volume per order',
            //     labelStyle: TextStyle(color: Colors.grey[500]),
            //     border: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //         color: Colors.grey,
            //         width: 1.0,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.grey.shade300,
            //         width: 1.0,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //         color: Colors.grey,
            //         width: 1.0,
            //       ),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            // ),
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
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
                onPressed: () {
                  sendFormData();
                },
                child: const Text('Submit'),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildSecondPage() {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;
    final token = userProvider.user?.token;
    print('Here is my token');
    print(token);
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
              isExpanded: true,
              dropdownColor: Colors.white,
              style: bodyTextSmall,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Select your bank',
                labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                ),
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
              onChanged: (String? newValue) {
                setState(() {
                  selectedBank = newValue!;
                  selectedBranch = 'Select Branch';
                  branchesDropdownList = [];
                  // Find the selected bank object
                  Bank selectedBankObject = banks.firstWhere(
                    (bank) => bank.name == selectedBank,
                  );

                  // Pass the bank ID to _fetchbranches
                  _fetchBankBranches(
                      context, selectedBankObject.bankId.toString());

                  selectedBankIndex = banksDropdownList.indexOf(selectedBank);

                  // _fetchbranches(context, selectedBank);
                  //selectedBankIndex = banksDropdownList.indexOf(selectedBank);

                  print('This is my selected banks index');
                  print(selectedBankIndex);
                });
              },
              items: banksDropdownList.isNotEmpty
                  ? banksDropdownList
                      .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : bankItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: selectedBranch,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBranch = newValue!;
                });
              },
              items: branches.isNotEmpty
                  ? branches.map<DropdownMenuItem<String>>((Branch branch) {
                      return DropdownMenuItem<String>(
                        value: branch.id.toString(),
                        child: Text(branch.name!),
                      );
                    }).toList()
                  : [],
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
                suffixIcon: const Icon(
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
            const SizedBox(
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
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
                body: {
                  "account_number": accountController.text,
                  "account_name": accountName.text,
                  "bank_id": selectedBankIndex != -1
                      ? banks[selectedBankIndex].bankId
                      : 0,
                  "branch_id": selectedBranch != -1 ? selectedBranch : 0,
                  "account_id": user?.account_id.toString() ?? '',
                  "is_petropal_account": 0,
                },
                onSuccess: (res) {
                  print('This is my selected bank value');
                  print(banks[selectedBankIndex].bankId);
                  print('This is my selected branch value');
                  print(selectedBranch);

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

    final token = userProvider.user?.token;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
                  headers: const {},
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

  // Widget buildFourthPage() {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding: EdgeInsets.all(15),
  //       child: Column(
  //         children: [
  //           TextFormField(
  //             keyboardType: TextInputType.text,
  //             //obscureText: true,
  //             obscureText: _obscurePassword,
  //             style: bodyText,
  //             controller: passwordController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               labelText: 'Current password',
  //               labelStyle: TextStyle(color: Colors.grey[500]),
  //               border: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Colors.grey.shade300,
  //                   width: 2.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               suffixIcon: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     _obscurePassword = !_obscurePassword;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   _obscurePassword ? Icons.visibility_off : Icons.visibility,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "Forgot password?",
  //             style: TextStyle(color: primaryDarkColor),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           TextFormField(
  //             keyboardType: TextInputType.text,
  //             //obscureText: true,
  //             obscureText: _obscurePassword,
  //             style: bodyText,
  //             controller: confirmController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               labelText: 'New password',
  //               labelStyle: TextStyle(color: Colors.grey[500]),
  //               border: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Colors.grey.shade300,
  //                   width: 2.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               suffixIcon: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     _obscurePassword = !_obscurePassword;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   _obscurePassword ? Icons.visibility_off : Icons.visibility,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           TextFormField(
  //             keyboardType: TextInputType.text,
  //             //obscureText: true,
  //             obscureText: _obscurePassword,
  //             style: bodyText,
  //             controller: verifyController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               labelText: 'Verify password',
  //               labelStyle: TextStyle(color: Colors.grey[500]),
  //               border: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Colors.grey.shade300,
  //                   width: 2.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: const BorderSide(
  //                   color: Colors.grey,
  //                   width: 1.0,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               suffixIcon: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     _obscurePassword = !_obscurePassword;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   _obscurePassword ? Icons.visibility_off : Icons.visibility,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           SizedBox(
  //             width: double.infinity,
  //             height: 50,
  //             child: ElevatedButton(
  //               style:
  //                   ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
  //               child: const Text('Confirm'),
  //               onPressed: () {},
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildFifthPage() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Success()),
                      (Route<dynamic> route) => false,
                    );
                    // Navigator.pushAndRemoveUntil(context,
                    //     MaterialPageRoute(builder: ((context) => Success())));
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
