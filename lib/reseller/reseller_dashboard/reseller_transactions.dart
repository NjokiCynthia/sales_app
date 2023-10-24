import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class ResellerTransactions extends StatefulWidget {
  const ResellerTransactions({super.key});

  @override
  State<ResellerTransactions> createState() => _ResellerTransactionsState();
}

class _ResellerTransactionsState extends State<ResellerTransactions> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[50]));
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_outward,
                        color: primaryDarkColor,
                        size: 15,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shell Limited',
                          textScaleFactor: 1,
                          style: displayTitle,
                        ),
                        Text(
                          'Kes 5,000',
                          style: displayTitle,
                        )
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment for kerosene',
                                style: bodyGrey1,
                              ),
                              Text(
                                '12 Sept 2023',
                                style: displaySmallerLightGrey,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '#12345678h',
                                style: bodyGrey1,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(201, 247, 245, 1.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8,
                                      //top: 8,
                                      bottom: 4,
                                      right: 8),
                                  child: Text(
                                    "Successful",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(27, 197, 189, 1.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < 5)
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Divider(
                        color: Colors.grey[200],
                        thickness: 2,
                      ),
                    ), // Add a divider except for the last item
                ],
              );
            },
            itemCount: 6,
          ),
        ));
  }
}
