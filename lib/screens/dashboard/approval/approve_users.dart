import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class ApproveUsers extends StatefulWidget {
  const ApproveUsers({super.key});

  @override
  State<ApproveUsers> createState() => _ApproveUsersState();
}

class _ApproveUsersState extends State<ApproveUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Approve Users',
              style: displayBigBoldBlack,
            )),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),

                  side: BorderSide(
                      color: Colors.grey[300]!), // Add a BorderSide
                ),
                child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/tanker.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    title: const Text(
                      'Shell Limited',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'lucy@example.com',
                            style: TextStyle(
                              color: Colors.black, // Text color
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's price: Kes 100",
                                style: bodyText,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        primaryDarkColor.withOpacity(0.6)),
                                child: const Text('View details'),
                              )
                              // Container(
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: primaryDarkColor),
                              //         borderRadius: BorderRadius.circular(5)),
                              //     child: Padding(
                              //         padding: const EdgeInsets.all(5),
                              //         child: Text(
                              //           'View details',
                              //           style: bodyText,
                              //         )))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              itemCount: 6,
            ),
          )
        ]));
  }
}
