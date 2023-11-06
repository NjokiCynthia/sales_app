import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class OrderDocuments extends StatefulWidget {
  const OrderDocuments({super.key});

  @override
  State<OrderDocuments> createState() => _OrderDocumentsState();
}

class _OrderDocumentsState extends State<OrderDocuments> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: primaryDarkColor,
            ),
          ),
          backgroundColor: Colors.grey[50],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Information',
                style: m_title,
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.check,
                  color: primaryDarkColor,
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice Number',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Proforma Invoice',
                            style: textBolderSmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Proof of payment',
                            style: textBolderSmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Payment Receipt',
                            style: textBolderSmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Loading Order',
                            style: textBolderSmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Payment receipt',
                            style: textBolderSmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Loading Depot',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#1234566',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryDarkColor.withOpacity(0.1)),
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(children: [
                                    Text(
                                      "View Document",
                                      style: TextStyle(
                                        color:
                                            primaryDarkColor.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryDarkColor,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        decorationThickness: 3,
                                      ),
                                    ),
                                  ]))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryDarkColor.withOpacity(0.1)),
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(children: [
                                    Text(
                                      "View Document",
                                      style: TextStyle(
                                        color:
                                            primaryDarkColor.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryDarkColor,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        decorationThickness: 3,
                                      ),
                                    ),
                                  ]))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryDarkColor.withOpacity(0.1)),
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(children: [
                                    Text(
                                      "View Document",
                                      style: TextStyle(
                                        color:
                                            primaryDarkColor.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryDarkColor,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        decorationThickness: 3,
                                      ),
                                    ),
                                  ]))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryDarkColor.withOpacity(0.1)),
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(children: [
                                    Text(
                                      "View Document",
                                      style: TextStyle(
                                        color:
                                            primaryDarkColor.withOpacity(0.5),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: primaryDarkColor,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                        decorationThickness: 3,
                                      ),
                                    ),
                                  ]))),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Vivo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Transporter Details',
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
                  children: [
                    Text(
                      'Driver Name',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'ID Number',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Phone number',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Epra Licence Number	',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'License Number',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Truck registration number',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Truck Compartments',
                      style: textBolderSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '35979356',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '0797181989',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'E1234567',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '1234567',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'KCA 811A',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '2000, 3000, 2000, 3000',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Item/s ordered',
              style: m_title,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Container(
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Kerosene',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'IK',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              '10000 litres',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unit Price',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'Total Price',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KES 113.00',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'KES 11300.00',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                }),
                itemCount: 3,
              ),
            ),
            Center(
              child: Text(
                'Total Amount Payable: KES 10000000',
                style: m_title.copyWith(color: primaryDarkColor),
              ),
            ),
          ]),
        )));
  }
}
