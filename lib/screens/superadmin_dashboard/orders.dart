import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/theme.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
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
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: ((context, index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(children: [
                          Text(
                            "#1234",
                            style: textBolder,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sun, 15 Feb 2023",
                            style: greyText,
                          ),
                        ]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "Pending",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.check), // Replace with your desired icon
                      Text(
                        "5000 ltrs",
                        style: displayTitle,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Supply Depot",
                        style: greyText,
                      ),
                      Text(
                        "Delivery",
                        style: greyText,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons
                      //     .business), // Replace with your desired company icon
                      Text(
                        "Company Name",
                        style: displayTitle,
                      ),
                      Text(
                        "Location 1",
                        style: displayTitle,
                      ),
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
