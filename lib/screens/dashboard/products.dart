import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/approval/price/price_approval.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50], // Set the desired color
    ));
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10, left: 10),
            child: Row(children: [
              Icon(
                Icons.arrow_back_ios,
                color: primaryDarkColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Products',
                  style: m_title,
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: primaryDarkColor.withOpacity(0.005))),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
                    leading:
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: primaryDarkColor.withOpacity(0.1),
                        //     shape: BoxShape.circle,
                        //   ),
                        //   padding: const EdgeInsets.all(8),
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors
                        //         .transparent, // Set the background color of the circle avatar
                        //     radius: 20, // Adjust the radius as needed
                        //     child: Text(
                        //       'ABC', // Replace with your desired letters
                        //       style: TextStyle(
                        //         color: primaryDarkColor, // Set the text color
                        //         fontSize: 16, // Adjust the font size as needed
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/petrol.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Kerosene',
                        style: displayTitle,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Revenue',
                                  style: displaySmallerLightGrey,
                                ),
                                Text(
                                  "Today's Average price",
                                  style: displaySmallerLightGrey,
                                ),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kes 50000',
                                  style: bodyText,
                                ),
                                Text(
                                  'Kes 150',
                                  style: bodyText,
                                ),
                              ]),
                        ],
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PriceApproval()));
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: primaryDarkColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      )),
    );
  }
}
