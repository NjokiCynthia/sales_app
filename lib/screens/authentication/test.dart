// ignore_for_file: unused_import, unnecessary_import, deprecated_member_use, unused_fielimport 'package:country_code_picker/country_code_picker.dart';, avoid_print
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';

class Login extends StatefulWidget {
  static const namedRoute = "/login-screen";

  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  // final GlobalKey<CountryCodePickerState> _countryKey = GlobalKey(
  final _countryCodeController = TextEditingController(text: "+254");
  final _phoneController = TextEditingController();
  final bool _isLoading = false;
  final bool _isFormInputEnabled = true;
  final bool _isPhoneNumber = false;
  String appSignature = "{{app signature}}";
  final termsandConditionsUrl = 'https://chamasoft.com/terms-and-conditions/';

  late FocusNode focusNode;
  final bool _isValid = true;
  final BorderSide _custInputBorderSide = const BorderSide(
    color: Colors.blueGrey,
    width: 1.0,
  );


  @override
  Widget build(BuildContext context) {
    //FirebaseCrashlytics.instance.crash();

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Image(
                        image: AssetImage('assets/images/petropal_logo.png'),
                      ),
                    ),
                    const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                                        // key: _countryKey,
                                        initialSelection: 'KE',
                                        favorite: const ['KE', 'UG', 'TZ', 'RW'],
                                        showCountryOnly: false,

                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        flagWidth: 28.0,
                                        enabled: _isFormInputEnabled,
                                        textStyle: const TextStyle(
                                          fontFamily:
                                              'SegoeUI', /*fontSize: 16,color: Theme.of(context).textSelectionHandleColor*/
                                        ),
                                        searchStyle: TextStyle(
                                            fontFamily: 'SegoeUI',
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionHandleColor),
                                        onChanged: (countryCode) {
                                          setState(() {
                                            _countryCodeController.text =
                                                countryCode.dialCode!;
                                            print(
                                                "Code: ${countryCode.dialCode}");
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
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Phone Number/Email',
                                    ),
                                    enabled: _isFormInputEnabled,
                                    //focusNode: _focusNode,
                                    style: const TextStyle(fontFamily: 'SegoeUI'),
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
                      child: const Row(
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
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {}, child: const Text('Login')),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
