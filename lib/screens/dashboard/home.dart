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
        title: Text('Commission rates'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            // Animated Cards
            Container(
              height: 200,
              color: Colors.white,
              child: PageView(
                controller: _pageController,
                children: [
                  AnimatedCard(
                    borderColor: primaryDarkColor,
                    title: 'OMC',
                    capitalRaised: '\KES 100,000,000',
                    currentCommission: '\KES 10,000',
                    imagePath: 'assets/images/rubis.png',
                  ),
                  AnimatedCard(
                    borderColor: primaryDarkColor,
                    title: 'Reseller',
                    capitalRaised: '\KES 50,000,000',
                    currentCommission: '\KES 5,000',
                    imagePath: 'assets/images/reseller.png',
                  ),
                  AnimatedCard(
                    borderColor: primaryDarkColor,
                    title: 'Customers',
                    capitalRaised: '\KES 200,000,000',
                    currentCommission: '\KES 20,000',
                    imagePath: 'assets/images/customer.png',
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
                'Transactions',
                style: displayTitle,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Invoices()));
                  },
                  child:
                      Text('view more', style: TextStyle(color: Colors.blue)))
            ]),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Number of transaction items
                itemBuilder: (context, index) {
                  return CustomTransactionCard(
                    userName: 'Customer $index',
                    amount: '\KES 100.00',
                    paymentMethod: 'Payment Method',
                    date: '2023-09-06',
                    volume: '100000 litres',
                  );
                },
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
  final String imagePath;

  AnimatedCard({
    required this.borderColor,
    required this.title,
    required this.capitalRaised,
    required this.currentCommission,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: borderColor, width: 2.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text(
                  'Capital Raised: $capitalRaised',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Current Commission: $currentCommission',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
