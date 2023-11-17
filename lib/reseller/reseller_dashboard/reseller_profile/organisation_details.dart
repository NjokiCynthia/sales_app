// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/profile.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganisationDetails extends StatefulWidget {
  const OrganisationDetails({super.key});

  @override
  State<OrganisationDetails> createState() => _OrganisationDetailsState();
}

class _OrganisationDetailsState extends State<OrganisationDetails> {
  final TextEditingController phone_number_ctrl = TextEditingController();
  final TextEditingController email_ctrl = TextEditingController();
  final TextEditingController volume_ctrl = TextEditingController();
  final TextEditingController licence_ctrl = TextEditingController();
  final TextEditingController expiry_ctrl = TextEditingController();
  final TextEditingController epra_ctrl = TextEditingController();
  final TextEditingController krapin_ctrl = TextEditingController();
  final TextEditingController kra_ctrl = TextEditingController();
  final TextEditingController certno_ctrl = TextEditingController();
  final TextEditingController cert_ctrl = TextEditingController();
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
        // Format the date received from the server
        _dateController.text = DateFormat('d MMM y').format(selectedDate);
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

  bool fetchingProfile = true;
  Profile? profile;

  _fetchProfile(BuildContext context) async {
    setState(() {
      fetchingProfile = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final token = userProvider.user?.token;
    final accountId = userProvider.user?.account_id;
    if (token == null) {
      print('Token is null.');
      setState(() {
        fetchingProfile = false;
      });
      return;
    }

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final postData = {
      'id': accountId,
    };
    print('Request postData:');
    print(postData);
    print('This is my account id');
    print(accountId);
    if (accountId == null) {
      return;
    }

    print('Fetching profile');

    await apiClient
        .post('/account/get-by-id', postData, headers: headers)
        .then((response) {
      print('Profile Response: $response');
      if (response['data'] != null) {
        setState(() {
          profile = Profile(
            id: response['data']['id'] ?? '',
            companyName: response['data']['company_name'] ?? '',
            companyEmail: response['data']['company_email'] ?? '',
            companyPhone: response['data']['company_phone'] ?? '',
            kraCertificateNumber:
                response['data']['kra_certificate_number'] ?? '',
            kraCertificatePhoto:
                response['data']['kra_certificate_photo'] ?? '',
            epraLicenseNumber: response['data']['epra_license_number'] ?? '',
            isVerified: response['data']['is_verified'] ?? "",
            epraLicenseExpiryDate:
                response['data']['epra_license_expiry_date'] ?? '',
            epraLicensePhoto: response['data']['epra_license_photo'] ?? '',
            certificateOfIncorporationNumber:
                response['data']['certificate_of_incorporation_number'] ?? "",
            certificateOfIncorporationPhoto:
                response['data']['certificate_of_incorporation_photo'] ?? '',
            minimumVolumePerOrder:
                response['data']['minimum_volume_per_order'] ?? '',
            isActivated: response['data']['is_activated'] ?? '',
            accountType: response['data']['account_type'] ?? '',
          );
        });
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No profile found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('Error fetching profile');
      print(error);
    });

    setState(() {
      fetchingProfile = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProfile(context).then((_) {
      // Access profile data only after it has been fetched
      if (profile != null) {
        email_ctrl.text = '${profile!.companyEmail}';
        phone_number_ctrl.text = '${profile!.companyPhone}';
        epra_ctrl.text = '${profile!.epraLicenseNumber}';
        expiry_ctrl.text = '${profile!.epraLicenseExpiryDate}';
        kra_ctrl.text = '${profile!.kraCertificatePhoto}';
        krapin_ctrl.text = '${profile!.kraCertificateNumber}';
        cert_ctrl.text = '${profile!.certificateOfIncorporationNumber}';
        _dateController.text = '${profile!.epraLicenseExpiryDate}';
      }

      print('${profile?.companyName}');
      print('${profile?.companyPhone}');
      print(('${profile?.epraLicenseExpiryDate}'));
      print(('${profile!.kraCertificateNumber}'));
    });
    print('object are my fetched details');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    // Check if profile is still being fetched
    if (fetchingProfile) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Display a loading indicator
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
            backgroundColor: Colors.grey[50],
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryDarkColor,
                ))),
        body: SingleChildScrollView(
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
                    labelText: 'Company phone',
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
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  style: bodyText,
                  controller: email_ctrl,
                  //initialValue: '${profile!.companyEmail}',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Company email',
                    labelStyle: TextStyle(color: Colors.black),
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
                  //initialValue: '${profile!.epraLicenseNumber}',
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  //obscureText: true,

                  style: bodyText,
                  controller: epra_ctrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Epra license number',
                    labelStyle: TextStyle(color: Colors.black),
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
                  controller: _dateController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Expiry date',
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
                InkWell(
                  onTap: () => launchUrl(
                      Uri.parse(profile!.epraLicensePhoto.toString() ?? '')),
                  child: const Text(
                    'Download Epra License',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  style: bodyText,
                  controller: krapin_ctrl,
                  //initialValue: '${profile!.kraCertificateNumber}',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'KRA PIN ',
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
                InkWell(
                  onTap: () => launchUrl(
                      Uri.parse(profile!.kraCertificatePhoto.toString() ?? '')),
                  child: const Text(
                    'Download KRA Certificate',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    validateOrganisationInputs();
                  },
                  keyboardType: TextInputType.text,
                  style: bodyText,
                  controller: cert_ctrl,
                  // initialValue: '${profile!.certificateOfIncorporationNumber!}',
                  decoration: InputDecoration(
                    //hintText: '${profile!.certificateOfIncorporationNumber!}',
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
                InkWell(
                  onTap: () => launchUrl(Uri.parse(
                      profile!.certificateOfIncorporationPhoto.toString() ??
                          '')),
                  child: const Text(
                    'Download Certificate of Incooporation',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ResellerProfile())));
                          // Navigator.push(MaterialPageRoute(
                          //     builder: (context) => const ResellerProfile()));
                        },
                        child: const Text('Confirm'))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
