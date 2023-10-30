import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/r_products.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController volumeController = TextEditingController();
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  double totalValue = 0.0;
  final double pricePerLiter = 200.0;

  void validateVolumeInputs() {
    if (volumeController.text.isEmpty) {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter volume';
      });
    } else {
      setState(() {
        buttonError = false;
        buttonErrorMessage = '';
      });
    }
  }

  void calculateTotalValue() {
    // Parse the entered volume, default to 0 if empty or non-numeric.
    final double enteredVolume = double.tryParse(volumeController.text) ?? 0.0;

    // Calculate the total value based on the entered volume and price per liter.
    totalValue = enteredVolume * pricePerLiter;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResellerProducts()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: primaryDarkColor,
                    ),
                  ),
                  Text(
                    'Order Details',
                    style: m_title,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: primaryDarkColor,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Energies Kenya',
                          style: bodyTextSmall,
                        ),
                        Text(
                          'Mombasa',
                          style: bodyTextSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Depot Location',
                          style: bodyTextSmall,
                        ),
                        Text(
                          'Vivo',
                          style: bodyTextSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Products Available',
                style: m_title,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kerosene',
                        style: bodyText,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Available volume',
                        style: bodyText,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Minimum volume',
                        style: bodyText,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '200 litres',
                        style: bodyTextSmaller,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Volume to purchase',
                        style: bodyText,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (text) {
                          calculateTotalValue();
                        },
                        keyboardType: TextInputType.number,
                        style: bodyText,
                        controller: volumeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Volume (litres)',
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
                      SizedBox(height: 10),
                      Text(
                        'Total Value: KES ${totalValue.toStringAsFixed(2)}',
                        style:
                            bodyText, // Display total value below the TextFormField.
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
