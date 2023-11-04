import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/orders/order_details.dart';
import 'package:petropal/reseller/reseller_dashboard/r_orders.dart';

class MakeOrder extends StatefulWidget {
  final String productName;
  final String minVolume;
  final String maxVolume;
  final String availableVolume;
  final String depotName;
  final String depotLocation;

  const MakeOrder({
    Key? key,
    required this.productName,
    required this.minVolume,
    required this.maxVolume,
    required this.availableVolume,
    required this.depotName,
    required this.depotLocation,
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

  void calculateTotalAmount() {
    if (volumeController.text.isNotEmpty) {
      double volume = double.tryParse(volumeController.text) ?? 0.0;
      double keroseneVolume =
          double.tryParse(keroseneVolumeController.text) ?? 0.0;
      double dieselVolume = double.tryParse(dieselVolumeController.text) ?? 0.0;
      double pricePerLiter = 200.0;
      setState(() {
        totalAmount = (volume + keroseneVolume + dieselVolume) * pricePerLiter;
      });
    } else {
      setState(() {
        totalAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => OrderDetails())));
            },
            child: Icon(
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
                  'Order Details',
                  style: bodyGrey.copyWith(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          color: primaryDarkColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Enter the volume of petrol you want to purchase',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: bodyText,
                      controller: volumeController,
                      onChanged: (value) {
                        enteredVolume = value;
                        calculateTotalAmount();
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter volume',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                    Text(
                      'Enter the volume of diesel you want to purchase',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: bodyText,
                      controller: dieselVolumeController,
                      onChanged: (value) {
                        enteredVolume = value;
                        calculateTotalAmount();
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter volume',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                    SizedBox(height: 10),
                    Text(
                      'Enter the volume of kerosene you want to purchase',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: bodyText,
                      controller: keroseneVolumeController,
                      onChanged: (value) {
                        enteredVolume = value;
                        calculateTotalAmount();
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter volume',
                        labelStyle:
                            bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                    Row(
                      children: [
                        Text(
                          'Total Amount payable:',
                          style: bodyGrey1,
                        ),
                        Text(
                          'KES $totalAmount', // Display the total amount
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkColor,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor),
                        onPressed: () {},
                        child: Text('Proceed')),
                  ],
                ),
              ),
              Step(
                isActive: currentStep >= 1,
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
                      value: selectedDriver,
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
                      items: driverItems
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
                isActive: currentStep >= 2,
                title: Text(
                  'Confirm and Submit',
                  style: bodyGrey.copyWith(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Details:', style: bodyGrey),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.productName},',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Depot',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Volume Ordered:',
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
                              'KES 200.0 per liter',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${widget.depotName}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${enteredVolume} liters',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Subtotal: KES ${totalAmount.toStringAsFixed(2)}, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
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
                    Text('Total Amunt payable: KES ${totalAmount}',
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
                              '01601719776507 [CYNTHIA NJOKI]',
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
                    'Enter the truck registration number',
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
                  labelText: "Enter the truck registration number",
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
                    'Enter the truck compartments',
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
                  labelText: 'Enter the truck compartments',
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline_sharp,
                    color: primaryDarkColor,
                  ),
                  Text(
                    'Enter the drivers name',
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
                  labelText: "Enter the driver's name",
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
                    'Enter the drivers phone number',
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
                  labelText: 'Enter the drivers phone number',
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
                    'Enter the drivers id number',
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
                    'Enter the drivers EPRA Licence number',
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
                  labelText: 'Enter the EPRA Licence number',
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
                    'Enter the driving licence number',
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
                  labelText: 'Enter the driving licence number',
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the newly entered driver
                String newName = nameController.text;
                setState(() {
                  if (!driverItems.contains(newName)) {
                    driverItems.add(newName);
                  }
                  selectedDriver = newName; // Set the selected driver
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
}
