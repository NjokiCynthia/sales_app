import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Orders',
          style: m_title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
            itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(5),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
            separatorBuilder: ((context, index) => Container(
                  height: 50,
                  child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.money_off,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shell Limited',
                              //textScaleFactor: 1.5,
                              style: displayTitle,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.greenAccent),
                                  color: Colors.greenAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, bottom: 4),
                                child: Text(
                                  'Pending',
                                  style:
                                      bodySmall.copyWith(color: Colors.green),
                                ),
                              ),
                            ),
                            Text(
                              'Kes 5000',
                              style: displayTitle,
                            )
                          ]),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1000 litres petrol',
                                style: bodyTextSmall,
                              ),
                              Text(
                                'Commission',
                                style: bodyTextSmall,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12 Sept 2023',
                                style: displaySmallerLightGrey,
                              ),
                              Text(
                                'Kes 5000',
                                style: displaySmallerLightGrey,
                              )
                            ],
                          ),
                        ],
                      )),
                )),
            itemCount: 10),
      ),
    );
  }
}
