import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/invoices.dart';
import 'package:petropal/widgets/widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Dashboard',
          style: displayBigBoldBlack,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              color: Colors.white,
              child: PageView(
                controller: _pageController,
                children: [
                  AnimatedCard(
                    borderColor: primaryDarkColor.withOpacity(0.1),
                    title: 'Oil Marketing Companies',
                    capitalRaised: '\KES 100,000,000',
                    currentCommission: '\KES 10,000',
                  ),
                  AnimatedCard(
                    borderColor: primaryDarkColor.withOpacity(0.1),
                    title: 'Reseller',
                    capitalRaised: '\KES 50,000,000',
                    currentCommission: '\KES 5,000',
                  ),
                  AnimatedCard(
                    borderColor: primaryDarkColor.withOpacity(0.1),
                    title: 'Customers',
                    capitalRaised: '\KES 200,000,000',
                    currentCommission: '\KES 20,000',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Transactions list
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Proforma Invoices',
                style: displayTitle,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Invoices()));
                  },
                  child:
                      Text('View more', style: TextStyle(color: Colors.blue)))
            ]),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(5),
                  child: Divider(
                    color: Colors.grey, // Customize the divider color
                    thickness: 1.0, // Customize the divider thickness
                  ),
                ), // Number of transaction items
                itemBuilder: (context, index) {
                  return CustomTransactionCard(
                    userName: 'Customer $index',
                    amount: '\KES 100.00',
                    paymentMethod: 'Payment Method',
                    date: '2023-09-06',
                    volume: '100000 litres',
                  );
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final Color borderColor;
  final String title;
  final String capitalRaised;
  final String currentCommission;

  AnimatedCard({
    required this.borderColor,
    required this.title,
    required this.capitalRaised,
    required this.currentCommission,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: borderColor, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.money,
                        color: primaryDarkColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Income Raised: ',
                      style: displayTitle,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Kes 50000',
                      style: bodyText,
                    )
                  ],
                ),
                // Text(
                //   'Capital Raised: $capitalRaised',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16,
                //   ),
                // ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.attach_money,
                        color: primaryDarkColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Current Commission:',
                      style: displayTitle,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Kes 1',
                      style: bodyText,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Active OMCs',
                            style: displayTitle,
                          ),
                          Text(
                            '5000',
                            style: bodyText,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            'Inactive OMCs',
                            style: displayTitle,
                          ),
                          Text(
                            '500',
                            style: bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
