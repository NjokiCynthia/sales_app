import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
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

  bool fetchingDetails = false;
  List<TruckModel> truckModels = [];
  List<DriverModel> driverModels = [];

  Future<void> _fetchDetails(BuildContext context) async {
    setState(() {
      fetchingDetails = true;
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
        });
      } else {
        print('No or invalid drivers found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Trucks Fetch By ID User Id: $error');
      // Handle the error
    }

    setState(() {
      fetchingDetails = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDetails(context);
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
    // print('products');
    // for(var i = 0; i < widget.orderProducts.length; i++){
    //   print(widget.orderProducts[i].show());
    // }

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

  Future<void> _showTruckDialog(BuildContext context) async {
    TextEditingController registrationController = TextEditingController();

    TextEditingController compartmentController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Add Driver',
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newName = compartmentController.text;
                String numberPlate = registrationController.text;
                setState(() {
                  if (!truckItems.contains(newName)) {
                    truckItems.add(newName);
                  }
                  selectedTruck = newName; // Set the selected driver
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
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

    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController EPRAController = TextEditingController();
    TextEditingController licenceController = TextEditingController();

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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            CustomRequestButton(
              url: '/driver/create',
              method: 'POST',
              buttonText: 'Add driver',
              body: {
                "full_name": nameController.text,
                "phone_number": phoneNumberController.text,
                "id_number": idController.text,
                "epra_licence_number": EPRAController.text,
                "driver_licence": licenceController.text,
                "created_by": user_id,
                "status": 1
              },
              headers: {
                'Authorization': 'Bearer $token',
              },
              onSuccess: (res) {
                print('Request payload:'); // Add this line to log the payload
                print({
                  "full_name": nameController.text,
                  "phone_number": phoneNumberController.text,
                  "id_number": idController.text,
                  "epra_licence_number": EPRAController.text,
                  "driver_licence": licenceController.text,
                  "created_by": user_id,
                  "status": 1
                });
                print('This is my response here ');
                print(res);

                final isSuccessful = res['isSuccessful'] as bool;
                final message = res['message'];

                if (isSuccessful) {
                  final data = res['data'] as Map<String, dynamic>?;
                  String newName = nameController.text;
                  setState(() {
                    if (!driverItems.contains(newName)) {
                      driverItems.add(newName);
                    }
                    selectedDriver = newName;
                  });

                  Navigator.pop(context);
                  // Handle the success case as needed.
                } else {
                  // Handle the error case.
                }
              },
            ),
            // TextButton(
            //   onPressed: () {
            //     // Add the newly entered driver
            //     String newName = nameController.text;
            //     setState(() {
            //       if (!driverItems.contains(newName)) {
            //         driverItems.add(newName);
            //       }
            //       selectedDriver = newName; // Set the selected driver
            //     });
            //     Navigator.of(context).pop(); // Close the dialog
            //   },
            //   child: Text('Add'),
            // ),
          ],
        );
      },
    );
  }
}
