import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

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
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  double totalAmount = 0.0;
  String selectedDriver = 'Driver 1';
  String selectedTruck = '2000, 3000, 2000, 3000';
  String enteredVolume = '';

  void calculateTotalAmount() {
    if (volumeController.text.isNotEmpty) {
      // Calculate the total amount based on the entered volume and price per liter
      double volume = double.tryParse(volumeController.text) ?? 0.0;
      double pricePerLiter = 200.0;
      setState(() {
        totalAmount = volume * pricePerLiter;
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
        body: Center(
            child: Stepper(
                currentStep: currentStep,
                onStepTapped: (index) {
                  setState(() => currentStep = index);
                },
                steps: [
          Step(
            isActive: currentStep >= 0,
            title: Text(
              'Order Details',
              style: bodyGrey,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the volume you want to purchase',
                  style: TextStyle(color: Colors.black),
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
                    prefixIcon: Icon(
                      Icons.shopping_basket_outlined,
                      color: primaryDarkColor,
                    ),
                    labelText: 'Enter volume',
                    labelStyle: bodyTextSmall,
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
                )
              ],
            ),
          ),
          Step(
            isActive: currentStep >= 1,
            title: Text(
              'Delivery Details',
              style: bodyGrey,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a Driver:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedDriver,
                  style: bodyTextSmall,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Select the driver',
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
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDriver = newValue!;
                    });
                  },
                  items: <String>[
                    'Driver 1',
                    'Driver 2',
                    'Driver 3',
                    'Driver 4',
                    'Driver 5',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  'Select a Truck:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedTruck,
                  style: bodyTextSmall,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Select truct compartments',
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
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTruck = newValue!;
                    });
                  },
                  items: <String>[
                    '2000, 3000, 2000, 3000',
                    '3000, 1000, 2000, 1000',
                    '4000, 2000, 2000, 1000',
                    '5000, 1000, 1000, 2000',
                    '6000, 1000, 2000, 3000',
                  ].map<DropdownMenuItem<String>>((String value) {
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
              style: bodyGrey,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Details
                Text(
                  'Product Details:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  '${widget.productName},',
                  style: bodyText,
                ),
                Text('${widget.depotName}'),
                Text(
                  'Price per Liter: KES 200.0',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Volume Ordered: $enteredVolume liters',
                  style: TextStyle(color: Colors.black),
                ),
                Text('Subtotal: KES ${totalAmount.toStringAsFixed(2)}'),

                SizedBox(height: 20),

                Text(
                  'Delivery Details:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  'Driver Name: ${selectedDriver}',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Phone Number: 123-456-7890',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'ID Number: 123456789',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'EPRA License Number: 987654321',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Driving License Number: DL-123456',
                  style: TextStyle(color: Colors.black),
                ),

                SizedBox(height: 20),

                Text(
                  'Truck Details:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  'Number Plate: ABC 123D',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Truck Compartments: 3',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ])));
  }
}
