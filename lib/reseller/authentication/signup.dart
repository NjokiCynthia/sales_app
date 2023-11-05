import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/user_details.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/login.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';
import 'package:petropal/widgets/buttons.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController first_name_ctrl = TextEditingController();
  final TextEditingController last_name_ctrl = TextEditingController();
  final TextEditingController email_ctrl = TextEditingController();
  final TextEditingController phone_number_ctrl = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String firstName = '';
  String lastName = '';
  String firstPagePhoneNumber = '';
  String email = '';
  String userItems = 'Reseller';
  String organizationName = '';
  String organizationLocation = '';
  String organizationEmail = '';
  String secondPagePhoneNumber = '';
  String password = '';
  String confrimPassword = '';

  String phone_number_inpt = '';
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  bool _obscurePassword = true;
  UserDetails? userDetails;

  int currentTab = 0;

  void validateSignupInputs() {
    if (first_name_ctrl.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter first name';
      });
      return;
    }
    if (last_name_ctrl.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter last name';
      });
      return;
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
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
      return;
    }
    if (passwordController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter password';
      });
      return;
    }
    if (passwordController.text.length < 8) {
      setState(() {
        buttonError = true;
        buttonErrorMessage =
            'Minimum password length must be at least 8 characters';
      });
      return;
    }
    print('buttonError');
    print(buttonError);
    setState(() {
      buttonError = false;
      buttonErrorMessage = 'Enter sending request';
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange); // Add listener for tab change
    validateSignupInputs();
  }

  void _handleTabChange() {
    setState(() {
      currentTab = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  String dropdownvalue = 'Nairobi';
  var locations = [
    'Eldoret',
    'Kisumu',
    'Konza',
    'Mombasa',
    'Nairobi',
    'Nakuru',
    'Nanyuki',
  ];

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

// Add a GlobalKey for each form to validate it independently
  final GlobalKey<FormState> _page1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _page2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _page3Key = GlobalKey<FormState>();

  void validateAndMoveToNextPage(GlobalKey<FormState> currentPageKey) {
    if (currentPageKey.currentState!.validate()) {
      // Move to the next page
      _tabController.animateTo(_tabController!.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));

    return DefaultTabController(
      length: 3,
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
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Image.asset(
                      'assets/images/icons/petropal_logo.png',
                      width: 200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign Up',
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
                        text: "Personal details",
                      ),
                      Tab(text: "Organisation details"),
                      Tab(text: "Confirm Details"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Form(
                        key: _page1Key, // Use the key for the first page
                        child: buildFirstPage(),
                      ),
                      Form(
                        key: _page2Key, // Use the key for the second page
                        child: buildSecondPage(),
                      ),
                      Form(
                        key: _page3Key, // Use the key for the third page
                        child: buildThirdPage(),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Login()),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: primaryDarkColor),
                            ),
                          ],
                        ),
                      ),
                    ),
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
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
            const SizedBox(height: 30),
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
                firstName = first_name_ctrl.text;
                lastName = last_name_ctrl.text;
                firstPagePhoneNumber = phone_number_inpt;
                email = email_ctrl.text;
                _tabController.animateTo(1);
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
      ),
    );
  }

  Widget buildSecondPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
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
                  userItems = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
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
              keyboardType: TextInputType.text,
              style: bodyText,
              controller: emailController,
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                userItems = userItems;
                organizationName = nameController.text;
                organizationLocation = dropdownvalue;
                organizationEmail = emailController.text;
                secondPagePhoneNumber = phoneController.text;
                _tabController.animateTo(2);
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
      ),
    );
  }

  Widget buildThirdPage() {
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('First Page Phone Number: $firstPagePhoneNumber');
    print('Email: $email');
    print('User Item: $userItems');
    print('Organization Name: $organizationName');
    print('Organization Location: $organizationLocation');
    print('Organization Email: $organizationEmail');
    print('Second Page Phone Number: $secondPagePhoneNumber');
    final userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (text) {
                validateSignupInputs();
              },
              keyboardType: TextInputType.text,
              obscureText: _obscurePassword,
              style: bodyText,
              controller: passwordController,
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
              controller: confirmController,
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
            CustomRequestButton(
                url: '/account/sign-up/reseller',
                method: 'POST',
                buttonText: 'SignUp',
                body: {
                  "user": {
                    "bankDetails": [],
                    "companyEmail": emailController.text,
                    "companyName": nameController.text,
                    "companyPhone": phoneController.text,
                    "confirmPassword": passwordController.text,
                    "contactDetails": [],
                    "email": email_ctrl.text,
                    "first_name": first_name_ctrl.text,
                    "is_verified": false,
                    "last_name": last_name_ctrl.text,
                    "location": dropdownvalue,
                    "password": passwordController.text,
                    "phone_number": phone_number_ctrl.text,
                    "role_id": 3,
                  }
                },
                onSuccess: (res) {
                  print('Signup Response: $res');
                  final isSuccessful = res['isSuccessful'] as bool;
                  final message = res['message'];

                  if (isSuccessful) {
                    final data = res['data'] as Map<String, dynamic>?;

                    if (data != null) {
                      //final userData = data['user'] as Map<String, dynamic>?;

                      print(message);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      print(message);
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
