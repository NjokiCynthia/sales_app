import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';

class ResellerTransactions extends StatefulWidget {
  const ResellerTransactions({Key? key}) : super(key: key);

  @override
  State<ResellerTransactions> createState() => _ResellerTransactionsState();
}

class _ResellerTransactionsState extends State<ResellerTransactions> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[10]));
    return Scaffold(
      backgroundColor: Colors.grey[10],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ResellerDashboard()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: primaryDarkColor,
          ),
        ),
        backgroundColor: Colors.grey[50],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All transactions',
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
      body: Column(
        children: <Widget>[
          Expanded(
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
                          Row(
                            children: [
                              const Text(
                                'Shell Limited ',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '| 12 Sept 2023',
                                style: displaySmallerLightGrey.copyWith(
                                    fontSize: 12),
                              ),
                              const Text('')
                            ],
                          ),
                          // Text(
                          //   'Shell Limited | 12 Sept 2023',
                          //   style: TextStyle(color: Colors.black),
                          // ),
                          Text(
                            'Kes 5,000',
                            style: displayTitle,
                          )
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment for kerosene',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                // Text(
                                //   '12 Sept 2023',
                                //   style: displaySmallerLightGrey,
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '#12345678h',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          201, 247, 245, 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, top: 4, bottom: 4, right: 8),
                                    child: Text(
                                      "Successful",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(27, 197, 189, 1.0),
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
                        padding: const EdgeInsets.all(8),
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
          ),
        ],
      ),
    );
  }
}
