import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/orders/make_order.dart';
import 'package:petropal/reseller/reseller_dashboard/r_products.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  double totalValue = 0.0;
  final double pricePerLiter = 200.0;

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
                      Navigator.pop(context);
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
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Energies Kenya',
                            style: textBolderSmall,
                          ),
                          Text(
                            'Mombasa',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Depot Location',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Vivo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Products Available',
                style: textBolder,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      String productName;
                      if (index == 0) {
                        productName = 'Kerosene';
                      } else if (index == 1) {
                        productName = 'Diesel';
                      } else {
                        productName = 'Petrol';
                      }
                      return

                          // return GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: ((context) => MakeOrder(
                          //                   productName:
                          //                       productName, // Pass product name
                          //                   minVolume: '200 litres',
                          //                   maxVolume: '400 litres',
                          //                   availableVolume: '5000 litres',
                          //                   depotName: 'Vivo', // Pass depot name
                          //                   depotLocation: 'Mombasa',
                          //                 ))));
                          //   },
                          Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName,
                                    style: textBolderSmall,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Available volume:',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Minimum volume',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    '200 litres',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: 'KES 200/',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'litre',
                                      style: bodyTextSmaller,
                                    ),
                                  ])),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '5000 litres',
                                    style: textBolderSmall,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Maximum volume',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    '400 litres',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (index < 2)
                            Divider(
                              color: Colors.black,
                            ),
                        ],
                      );
                    }),
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
                              builder: ((context) => MakeOrder(
                                    productName:
                                        'Kerosene', // Pass product name
                                    minVolume: '200 litres',
                                    maxVolume: '400 litres',
                                    availableVolume: '5000 litres',
                                    depotName: 'Vivo', // Pass depot name
                                    depotLocation: 'Mombasa',
                                  ))));
                    },
                    child: Text('Place Order')),
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: primaryDarkColor.withOpacity(0.1)),
              //   child: Padding(
              //     padding: EdgeInsets.all(4),
              //     child: Row(
              //       children: [
              //         Text(
              //           "Place Order",
              //           style: TextStyle(
              //             color: primaryDarkColor.withOpacity(0.5),
              //             fontSize: 12,
              //             decoration: TextDecoration.underline,
              //             decorationColor: primaryDarkColor,
              //             decorationStyle: TextDecorationStyle.dotted,
              //             decorationThickness: 3,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
