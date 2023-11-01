import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/user_details.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController first_name_ctrl = TextEditingController();
  final TextEditingController last_name_ctrl = TextEditingController();
  final TextEditingController email_ctrl = TextEditingController();
  final TextEditingController phone_number_ctrl = TextEditingController();
  final TextEditingController property_name_ctrl = TextEditingController();
  final TextEditingController property_location_ctrl = TextEditingController();
  final TextEditingController password_ctrl = TextEditingController();
  String phone_number_inpt = '';
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  bool _obscurePassword = true;
  UserDetails? userDetails;

  validateSignupInputs() {
    if (first_name_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter first name';
      });
    }
    if (last_name_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter last name';
      });
    }
    if (!buttonError) {
      userDetails = UserDetails(
        firstName: first_name_ctrl.text,
        lastName: last_name_ctrl.text,
        phoneNumber: phone_number_inpt,
        email: email_ctrl.text,
      );
    }

    if (phone_number_inpt == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
    }
    if (password_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter password';
      });
    }
    if (password_ctrl.text.length < 8) {
      return setState(() {
        buttonError = true;
        buttonErrorMessage =
            'Minimum password length must be at least 8 characters';
      });
    }
    print('buttonError');
    print(buttonError);
    return setState(() {
      buttonError = false;
      buttonErrorMessage = 'Enter sending request';
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Initialize the TabController
    validateSignupInputs();
  }

  @override
  void dispose() {
    _tabController
        ?.dispose(); // Make sure to dispose of the TabController when the widget is disposed
    super.dispose();
  }

  // Initial Selected Value
  String dropdownvalue = 'Nairobi';

  // List of items in our dropdown menu
  var locations = [
    'Nairobi',
    'Mombasa',
    'Kisumu',
    'Konza',
    'Eldoret',
    'Nanyuki',
  ];
  String userItems = 'Oil Marketing Company';

  // List of items in our dropdown menu
  var users = [
    'Oil Marketing Company',
    'Reseller',
  ];
  bool agreedToTerms = false;

  toggleAgreement(value) {
    setState(() {
      agreedToTerms = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TabBar(
                  indicatorColor: primaryDarkColor,
                  labelStyle: displaySmaller,
                  labelColor: primaryDarkColor,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Personal details",
                    ),
                    Tab(text: "Organisation details"),
                    Tab(text: "Confirm"),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TabBarView(
                    children: [
                      buildFirstPage(),

                      buildSecondPage(),

                      // Third Page
                      buildThirdPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstPage() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: TextFormField(
                    onChanged: (text) {
                      validateSignupInputs();
                    },
                    controller: first_name_ctrl,
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
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    onChanged: (text) {
                      validateSignupInputs();
                    },
                    controller: last_name_ctrl,
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
          const SizedBox(height: 20),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                phone_number_inpt = number.phoneNumber ?? '';
              });
              validateSignupInputs();
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
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (text) {
              validateSignupInputs();
            },
            keyboardType: TextInputType.text,
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
          GestureDetector(
            onTap: () {
              //  _tabController.animateTo(_tabController.index + 1);
              if (validateSignupInputs()) {
                // Navigate to the next tab
                _tabController!.animateTo(_tabController!.index + 1);
              }
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_forward,
                  color: primaryDarkColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSecondPage() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: userItems,
            dropdownColor: Colors.white,
            iconDisabledColor: primaryDarkColor,
            iconEnabledColor: primaryDarkColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
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
            items: users.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item,
                        style: const TextStyle(color: primaryDarkColor),
                      ),
                    ]),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (text) {
              validateSignupInputs();
            },
            controller: first_name_ctrl,
            keyboardType: TextInputType.name,
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Orgnisation name',
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
              value: dropdownvalue,
              dropdownColor: Colors.white,
              iconDisabledColor: primaryDarkColor,
              iconEnabledColor: primaryDarkColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
              items: locations.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item,
                          style: const TextStyle(color: primaryDarkColor),
                        ),
                      ]),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (text) {
              validateSignupInputs();
            },
            keyboardType: TextInputType.text,
            //obscureText: true,
            obscureText: _obscurePassword,
            style: bodyText,
            controller: password_ctrl,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Organisation Email Address',
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
              validateSignupInputs();
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
              labelText: 'Organisation Phone number',
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
          const SizedBox(height: 20),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: primaryDarkColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_forward,
                color: primaryDarkColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThirdPage() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          onChanged: (text) {
            validateSignupInputs();
          },
          keyboardType: TextInputType.text,
          //obscureText: true,
          obscureText: _obscurePassword,
          style: bodyText,
          controller: password_ctrl,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Enter password',
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
          onChanged: (text) {
            validateSignupInputs();
          },
          keyboardType: TextInputType.text,
          //obscureText: true,
          obscureText: _obscurePassword,
          style: bodyText,
          controller: password_ctrl,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Confirm password',
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
        Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (!states.contains(MaterialState.selected)) {
                  return primaryDarkColor.withOpacity(0.1);
                }
                return null;
              }),
              side: const BorderSide(color: primaryDarkColor, width: 2),
              value: agreedToTerms,
              onChanged: toggleAgreement,
            ),
            Text(
              'I agree to the Terms and Conditions',
              style: bodyText,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResellerDasboard()));
              },
              child: Text('SignUp')),
        )
      ]),
    );
  }
}
