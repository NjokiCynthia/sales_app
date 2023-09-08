import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/dashboard.dart';

class Login extends StatefulWidget {
  static const namedRoute = "/login-screen";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _countryCodeController = TextEditingController(text: "+254");
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isFormInputEnabled = true;
  bool _isPhoneNumber = false;
  bool _isValid = true;
  BorderSide _custInputBorderSide = BorderSide(
    color: Colors.blueGrey,
    width: 1.0,
  );

  _printLatestValues() {
    final text = _phoneController.text;
    bool containsDigit = text.contains(RegExp(r'[0-9]'));

    if (containsDigit) {
      // Check if the first character is a digit
      if (text.isNotEmpty && !text[0].contains(RegExp(r'[0-9]'))) {
        setState(() {
          _isPhoneNumber = false;
          _isValid = true;
        });
      } else {
        setState(() {
          _isPhoneNumber = true;
        });
      }
    } else {
      setState(() {
        _isPhoneNumber = false;
        _isValid = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_printLatestValues);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_printLatestValues);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                        image:
                            AssetImage('assets/images/icons/petropal_logo.png'),
                        width: 100,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Let's get you started",
                        style: displayTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please enter your phone number or email address to proceed',
                      style: bodyText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: _custInputBorderSide,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Visibility(
                                  visible: _isPhoneNumber,
                                  child: Row(
                                    children: <Widget>[
                                      CountryCodePicker(
                                        initialSelection: 'KE',
                                        favorite: ['KE', 'UG', 'TZ', 'RW'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        flagWidth: 28.0,
                                        enabled: _isFormInputEnabled,
                                        searchStyle: bodyText,
                                        textStyle: bodyText,
                                        onChanged: (countryCode) {
                                          setState(() {
                                            _countryCodeController.text =
                                                countryCode.dialCode!;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    cursorColor: primaryDarkColor,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Phone Number/Email',
                                        hintStyle: bodyText),
                                    style: bodyText,
                                    enabled: _isFormInputEnabled,
                                    onSaved: (value) {
                                      // _identity = value.trim();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !_isValid,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.5),
                            child: Text(
                              'Enter valid email or mobile number',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => Dashboard())));
                            },
                            child: Text('Confirm'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryDarkColor),
                          ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
