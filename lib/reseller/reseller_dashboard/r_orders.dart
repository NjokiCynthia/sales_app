import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class ResellerOrders extends StatefulWidget {
  const ResellerOrders({super.key});

  @override
  State<ResellerOrders> createState() => _ResellerOrdersState();
}

class _ResellerOrdersState extends State<ResellerOrders> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: Text(
          'Orders',
          style: m_title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: ((context, index) => Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "#2023/INV/10-0001",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Diesel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Sun, 15 Feb 2023",
                            style: greyText,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 226, 229, 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 8),
                              child: Text(
                                "Pending",
                                style: TextStyle(
                                  color: Color.fromRGBO(246, 78, 96, 1.0),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: "KES 50,000/", style: boldText),
                            TextSpan(
                              text: '50 liters',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey), // Style for the unit
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   "KES 50,000",
                      //   style: textbold,
                      // ),
                      Text(
                        "View more",
                        style: TextStyle(
                          color: primaryDarkColor.withOpacity(0.5),
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryDarkColor,
                          decorationStyle: TextDecorationStyle.dotted,
                          decorationThickness: 3,
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: primaryDarkColor.withOpacity(0.1),
                      //     shape: BoxShape.circle,
                      //   ),
                      //   padding: const EdgeInsets.all(5),
                      //   child: const Icon(
                      //     Icons.keyboard_arrow_down,
                      //     color: primaryDarkColor,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ))),
          itemCount: 20,
        ),
      ),
    );
  }
}
