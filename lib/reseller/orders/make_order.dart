import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/bank.dart';
import 'package:petropal/models/driver.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/models/truck.dart';
import 'package:petropal/reseller/orders/order_details.dart';
import 'package:petropal/reseller/reseller_dashboard/r_orders.dart';
import 'package:petropal/models/order_product.dart';
import 'package:petropal/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/constants/api.dart';
import 'package:http/http.dart' as http;

class MakeOrder extends StatefulWidget {
  final double totalVolume;
  final String depotName;
  final String depotLocation;
  final List<OrderProductModel> orderProducts;

  const MakeOrder({
    Key? key,
    required this.depotName,
    required this.depotLocation,
    required this.totalVolume,
    required this.orderProducts,
  }) : super(key: key);

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  int currentStep = 0;
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController keroseneVolumeController =
      TextEditingController();
  final TextEditingController dieselVolumeController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController EPRAController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController registrationController = TextEditingController();

  TextEditingController compartmentController = TextEditingController();
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  double totalAmount = 0.0;
  String selectedDriver = 'Driver 1';
  String selectedTruck = '2000, 3000, 2000, 3000';
  String enteredVolume = '';
  String driverPhoneNumber = '';
  String driverIdNumber = '';
  String driverEpraLicense = '';
  String driverDrivingLicense = '';

  String truckNumberPlate = '';
  String truckCompartments = '';
  bool fetchingTrucks = false;
  bool fetchingDrivers = false;
  List<TruckModel> truckModels = [];
  List<DriverModel> driverModels = [];
  List<BankModel> bankModels = [];
  bool addingdriver = true;
  bool addingTruck = true;
  bool fetchingBanks = true;

  Future<void> _showTruckDialog(BuildContext context) async {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Add Truck',
              style: bodyGrey,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      color: primaryDarkColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Truck registration number',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  style: bodyText,
                  controller: registrationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Truck registration number",
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    truckNumberPlate = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.fire_truck_sharp,
                      color: primaryDarkColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Truck compartments',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  controller: compartmentController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Truck compartments',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    truckCompartments = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            actions: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        addTruck();
                      },
                      child: Text('Add truck')))
            ],
          );
        });
  }

  Future<void> addDriver() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    final token = userProvider.user?.token;
    if (token == null) {
      print('Token is null.');
      setState(() {
        addingdriver = false;
      });
      return;
    }

    final postData = {
      "full_name": nameController.text,
      "phone_number": phoneNumberController.text,
      "id_number": idController.text,
      "epra_licence_number": EPRAController.text,
      "driver_licence": licenceController.text,
      "created_by": user!.id
    };

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/driver/create', postData, headers: headers)
        .then((response) {
      print('Response: $response');
      if (response['status'] == 1) {
        final responseData = response['data'];

        if (responseData != null) {
          // Driver added successfully.
          print('Driver added successfully');
          print(responseData);

          // Set the selected driver based on the newly added driver
          selectedDriver = responseData['id'].toString() +
              ' ' +
              responseData['full_name'] +
              ' ' +
              responseData['id_number'] +
              ' ' +
              responseData['phone_number'];

          // Close the dialog
          Navigator.of(context).pop(); // You can access specific data here.
        } else {
          // Handle errors or failed driver addition.
          print('Adding driver failed');
          // Print status code and response body for debugging
          print('Response status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        // Handle non-200 status codes, e.g., 4xx or 5xx errors.
        print('Request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }).catchError((error) {
      // Handle errors from the HTTP request.
      print('Error: $error');
    });
  }

  Future<void> addTruck() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    final token = userProvider.user?.token;
    if (token == null) {
      print('Token is null.');
      setState(() {
        addingdriver = false;
      });
      return;
    }

    final postData = {
      "registration_number": registrationController.text,
      "compartment": compartmentController.text,
      "created_by": user!.id,
      "status": 1,
    };

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/truck/create', postData, headers: headers)
        .then((response) {
      print('Response: $response');
      if (response['status'] == 1) {
        final responseData = response['data'];

        if (responseData != null) {
          // Driver added successfully.
          print('Truck added successfully');
          print(responseData);
          setState(() {
            selectedTruck = responseData['compartment'];
          });
          Navigator.pop(context);

          // You can access specific data here.
        } else {
          // Handle errors or failed driver addition.
          print('Adding truck failed');
          // Print status code and response body for debugging
          print('Response status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        // Handle non-200 status codes, e.g., 4xx or 5xx errors.
        print('Request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }).catchError((error) {
      // Handle errors from the HTTP request.
      print('Error: $error');
    });
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    // final token = userProvider.user?.token;
    if (user == null || user.token == null) {
      // Handle the case where the user or token is null, e.g., show an error message.
      return;
    }
    final token = user.token;
    final user_id = user.id;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Add Driver',
            style: bodyGrey,
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_sharp,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  style: bodyText,
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "driver's name",
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'Phone number',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  controller: phoneNumberController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Phone number',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    driverPhoneNumber = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.numbers,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'ID number',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  controller: idController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'ID number',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    driverIdNumber = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_rounded,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'EPRA Licence number',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  controller: EPRAController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'EPRA Licence number',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    driverEpraLicense = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'Driving licence number',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  controller: licenceController,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Driving licence number',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  onChanged: (value) {
                    driverDrivingLicense = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      addDriver();
                    },
                    child: Text('Add driver')))
          ],
        );
      },
    );
  }

  Future<void> _fetchDrivers(BuildContext context) async {
    setState(() {
      fetchingDrivers = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final userId = userProvider.user?.id;

    final postData = {
      'user_id': userId,
    };
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/driver/get-all',
        postData,
        headers: headers,
      );

      print('Driver Response: $response');

      setState(() {
        driverModels = [];
      });

      if (driverModels.isNotEmpty) {
        selectedDriver = driverModels[0].id.toString() +
            ' ' +
            driverModels[0].fullName +
            ' ' +
            driverModels[0].idNumber +
            ' ' +
            driverModels[0].phoneNumber;
      }

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final tempDriverModels = data.map((driverData) {
          return DriverModel(
            id: int.parse(driverData['id'].toString()),
            epraLicenseNumber: driverData['epra_licence_number'].toString(),
            fullName: driverData['full_name'].toString(),
            idNumber: driverData['id_number'].toString(),
            phoneNumber: driverData['phone_number'].toString(),
            licenseNumber: driverData['licence_number'].toString(),
            createdAt: '',
            createdBy: driverData['created_by'].toString(),
            status: '',
            updatedAt: '',
          );
        }).toList();
        setState(() {
          driverModels = tempDriverModels;
          if (driverModels.isNotEmpty) {
            selectedDriver = driverModels[0].id.toString() +
                ' ' +
                driverModels[0].fullName +
                ' ' +
                driverModels[0].idNumber +
                ' ' +
                driverModels[0].phoneNumber;
          }
        });

        // Explicitly trigger a rebuild of the widget
        setState(() {});
      } else {
        print('No or invalid drivers found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Trucks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingDrivers = false;
    });
  }

  Future<void> _fetchTrucks(BuildContext context) async {
    setState(() {
      fetchingTrucks = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final userId = userProvider.user?.id;

    final postData = {
      'user_id': userId,
    };
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/truck/get-all',
        postData,
        headers: headers,
      );

      print('Trucks Response: $response');

      setState(() {
        truckModels = [];
      });

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final tempTruckModels = data.map((truckData) {
          return TruckModel(
            id: int.parse(truckData['id'].toString()),
            compartment: truckData['compartment'].toString(),
            registrationNumber: truckData['registration_number'].toString(),
            createdAt: '',
            createdBy: truckData['created_by'].toString(),
            status: '',
            updatedAt: '',
          );
        }).toList();

        setState(() {
          truckModels = tempTruckModels;
        });
      } else {
        print('No or invalid trucks found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Trucks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingTrucks = false;
    });
  }

  Future<void> _fetchBanks(BuildContext context) async {
    setState(() {
      fetchingBanks = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final userId = userProvider.user?.id;

    final postData = {
      //'user_id': userId,
    };
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/bank-accounts/query',
        postData,
        headers: headers,
      );

      print('Banks Response: $response');

      setState(() {
        bankModels = [];
      });

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final tempBankModels = data.map((bankData) {
          return BankModel(
              id: int.parse(bankData['id'].toString()),
              dealer: bankData['dealer'],
              accountNumber: bankData['accountNumber'],
              accountName: bankData['accountName'],
              bankBranch: bankData['bankBranch'],
              bankName: bankData['bankName']);
        }).toList();

        setState(() {
          bankModels = tempBankModels;
        });
      } else {
        print('No or invalid banks found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Banks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingBanks = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDrivers(context);
    _fetchTrucks(context);
    _fetchBanks(context);
  }

  double calculateTotal(orderProducts) {
    double total = 0.0;
    for (int i = 0; i < orderProducts.length; i++) {
      total += double.parse(orderProducts[i].price.toString()) *
          double.parse(orderProducts[i].volume.toString());
    }
    return total;
  }

  List<String> driverItems = [
    'Driver 1',
    'Driver 2',
    'Driver 3',
    'Driver 4',
    'Driver 5'
  ];

  List<String> truckItems = [
    '2000, 3000, 2000, 3000',
    '3000, 1000, 2000, 1000',
    '4000, 2000, 2000, 1000',
    '5000, 1000, 1000, 2000',
    '6000, 1000, 2000, 3000'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => OrderDetails(
                            product: ProductModel(
                                id: 1,
                                counter: 1,
                                createdBy: 1,
                                product: 'Kerosene',
                                depot: 'Vivo',
                                sellingPrice: 100.1,
                                dealerName: 'Shell Limited',
                                price: 100.1,
                                location: 'Nairobi',
                                remainingVolume: 100000,
                                availableVolume: 1000,
                                minimumVolume: 390,
                                maximumVolume: 4000,
                                commissionRate: 1.3,
                                status: 1,
                                companyId: 19),
                          ))));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: primaryDarkColor,
            ),
          ),
          title: Text(
            'Make your order',
            style: m_title,
          ),
        ),
        body: Stepper(
            currentStep: currentStep,
            onStepTapped: (index) {
              setState(() => currentStep = index);
            },
            steps: [
              Step(
                isActive: currentStep >= 0,
                title: Text(
                  'Delivery Details',
                  style: bodyGrey.copyWith(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.drive_eta_outlined,
                              color: primaryDarkColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Select a Driver',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          'or',
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(children: [
                          Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              _showAddDialog(context);
                            },
                            child: Text(
                              'Add new Driver',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ])
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      //value: selectedDriver,
                      dropdownColor: Colors.white,
                      style: bodyTextSmall,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Select the driver',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
                        suffixIcon: Icon(
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
                          selectedDriver = newValue!;
                        });
                      },
                      items: driverModels.isNotEmpty
                          ? driverModels
                              .map((driver) =>
                                  driver.id.toString() +
                                  ' ' +
                                  driver.fullName +
                                  ' ' +
                                  driver.idNumber +
                                  ' ' +
                                  driver.phoneNumber)
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : driverItems
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.fire_truck_outlined,
                              color: primaryDarkColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Select truck',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          'or',
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(children: [
                          Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              _showTruckDialog(context);
                            },
                            child: Text(
                              'Add new Truck',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ])
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      value: selectedTruck,
                      style: bodyTextSmall,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Select truck compartments',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                          selectedTruck = newValue!;
                        });
                      },
                      items: truckItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Select bank',
                      style: TextStyle(color: Colors.black),
                    ),
                    DropdownButtonFormField<String>(
                      //value: selectedDriver,
                      dropdownColor: Colors.white,
                      style: bodyTextSmall,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Select the bank',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
                        suffixIcon: Icon(
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
                          selectedDriver = newValue!;
                        });
                      },
                      items: driverModels.isNotEmpty
                          ? driverModels
                              .map((driver) =>
                                  driver.id.toString() +
                                  ' ' +
                                  driver.fullName +
                                  ' ' +
                                  driver.idNumber +
                                  ' ' +
                                  driver.phoneNumber)
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : driverItems
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                  ],
                ),
              ),
              Step(
                isActive: currentStep >= 1,
                title: Text(
                  'Confirm Order Details',
                  style: bodyGrey.copyWith(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Details: ${widget.orderProducts.length}',
                        style: bodyGrey),
                    SizedBox(
                      height: 180.0,
                      child: ListView.builder(
                          itemCount: widget.orderProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final orderedProduct = widget.orderProducts[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          orderedProduct.productName,
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Text(
                                          'Price: ${orderedProduct.price.toStringAsFixed(2)}',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        Text(
                                          'Volume Ordered: ${orderedProduct.volume.toStringAsFixed(2)}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          'Sub Total: ${(orderedProduct.volume * orderedProduct.price).toStringAsFixed(2)}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Total: KES ${calculateTotal(widget.orderProducts).toStringAsFixed(2)}, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Delivery Details:',
                      style: bodyGrey,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Driver Name:',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Phone Number:',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'EPRA License Number: ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Driving License Number: ',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selectedDriver}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${driverPhoneNumber}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${driverEpraLicense}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${driverDrivingLicense}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Truck Details:', style: bodyGrey),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Number Plate:',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Truck Compartments:',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${truckNumberPlate}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${selectedTruck}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Amount payable: KES ${calculateTotal(widget.orderProducts).toStringAsFixed(2)}',
                        style: bodyGrey),
                    Text('Payment Details:', style: bodyGrey),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank:',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Account number:',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EQUITY BANK',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '01601719776507',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResellerOrders()));
                        },
                        child: Text('Confirm Order'))
                  ],
                ),
              ),
            ]));
  }
}
