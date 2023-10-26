import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';


class ResellerProducts extends StatefulWidget {
  const ResellerProducts({super.key});

  @override
  State<ResellerProducts> createState() => _ResellerProductsState();
}

class _ResellerProductsState extends State<ResellerProducts> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: primaryDarkColor,
        ),
        backgroundColor: Colors.grey[50],
        title: Text(
          'Products',
          style: m_title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: ((context, index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Energies Kenya",
                          style: boldText,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.more_vert,
                            color: primaryDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    //  indent: BorderSide.strokeAlignInside,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Depot Location",
                            style: greyText,
                          ),
                          Text(
                            'Mombasa',
                            style: bold,
                          ),
                        ],
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Diesel",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            'KES 200',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  const Padding(
                      padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kerosene",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            'KES 200',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 15, right: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.spa,
                        children: [
                          Text(
                            "Petrol",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            'KES 200',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
              ))),
          itemCount: 20,
        ),
      ),
    );
  }
}
