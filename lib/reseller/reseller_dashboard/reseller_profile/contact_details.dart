// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/positions_model.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/view_staff.dart';

import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String phone_number_inpt = '';
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';

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

  String errorMessage = '';
  void _addContactDetails() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    //final user = userProvider.user;
    final token = userProvider.user?.token;

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final postData = {
      "first_name": firstNameController.text,
      "is_verified": true,
      "last_name": lastNameController.text,
      "phone_number": phoneController.text,
      "email": emailController.text,
      "position_id":
          selectedPositionIndex != -1 ? positions[selectedPositionIndex].id : 0,
    };

    print(postData);

    apiClient
        .post('/contact-persons/create', postData, headers: headers)
        .then((response) {
      print('Response: $response');

      if (response['status'] == 1) {
        // Successfully added contact details, navigate to ViewStaff
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViewStaff()),
        );
      } else if (response['status'] == 0 && response['message'] != null) {
        // Set the error message to display on the page
        setState(() {
          errorMessage = response['message'];
        });
        print('Error: ${response['message']}');
      } else {
        print('Invalid status in the response');
        // Handle the case when 'status' is not 1
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Access the UserProvider and retrieve the user data
    _fetchPositions(context);
    final userProvider = context.read<UserProvider>();
    final token = userProvider.token;
    print('This is my token here');
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
        backgroundColor: Colors.grey[50],
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
                        'Staff Contact Details',
                        style: m_title,
                      ),
                      Container(
                        width: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                            color: Colors.red), // Customize the text style
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: TextFormField(
                            onChanged: (text) {},
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            style: bodyText,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'First name',
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
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            onChanged: (text) {},
                            controller: lastNameController,
                            style: bodyText,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Last name',
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
                        ),
                      ),
                    ],
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Select position',
                        labelStyle: TextStyle(color: Colors.black),
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
                          selectedPosition = newValue!;
                          selectedPositionIndex =
                              positionsDropdownList.indexOf(selectedPosition);
                        });
                      },
                      items: positionsDropdownList.isNotEmpty
                          ? positionsDropdownList
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : positionItems
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {
                          _addContactDetails();
                        },
                        child: Text('Add Details')),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
