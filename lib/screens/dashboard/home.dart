import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

import 'package:petropal/widgets/widget.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> cardColors = [
    const Color(0xFF012F6D), // #012F6D
    const Color(0xFFFF9A00), // #FF9A00
    const Color(0xFFAABBCC), // Another color of your choice
  ];

  // Initial Selected Value
  String dropdownvalue = 'Weekly';

  // List of items in our dropdown menu
  var items = [
    'Weekly',
    'Monthly',
  ];
  final SwiperController _swiperController = SwiperController();

  int _currentgraph = 0;

  List<String> titles = ['Petrol', 'Diesel', 'Kerosene'];
  List<String> card_titles = [
    'Transactions',
    'Products',
    'Orders',
    'Users',
  ];

  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 210,
                    child: Swiper(
                      controller: _swiperController,
                      onIndexChanged: (index) {
                        setState(() {
                          _currentgraph = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: Colors.white,

                            // color: cardColors[index % cardColors.length],
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Current price for ${titles[index]}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Kes 91.30',
                                            style: m_title,
                                          ),
                                        ],
                                      ),
                                      DropdownButton<String>(
                                        value: dropdownvalue,
                                        dropdownColor: Colors.white,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: primaryDarkColor,
                                        ),
                                        items: items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  color: primaryDarkColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          primaryDarkColor
                                              .withOpacity(0.5), // Start color
                                          Colors.white, // End color
                                        ],
                                        stops: <double>[
                                          0.0,
                                          1.0
                                        ], // Gradient stops
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    height: 150,
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          borderColor: primaryDarkColor,
                                          isVisible: true,
                                          labelStyle: const TextStyle(
                                              color: primaryDarkColor),
                                        ),
                                        primaryYAxis: NumericAxis(
                                          borderColor: primaryDarkColor,
                                          isVisible: true,

                                          labelStyle: const TextStyle(
                                              color:
                                                  primaryDarkColor), // Y-axis labels color
                                          axisLine: const AxisLine(
                                              color: primaryDarkColor),
                                        ),
                                        series: <LineSeries<SalesData, String>>[
                                          LineSeries<SalesData, String>(
                                            dataSource: <SalesData>[
                                              SalesData('Mon', 5),
                                              SalesData('Tue', 18),
                                              SalesData('Wed', 7),
                                              SalesData('Thur', 11),
                                              SalesData('Fri', 6),
                                              SalesData('Sat', 16),
                                              SalesData('Sun', 10)
                                            ],
                                            xValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.year,
                                            yValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.sales,
                                          ),
                                        ]),
                                  ),
                                ]));
                      },
                      itemCount: 3,
                      viewportFraction: 1.0,
                      scale: 0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentgraph == index
                                ? primaryDarkColor // Active dot color
                                : primaryDarkColor
                                    .withOpacity(0.1) // Inactive dot color
                            ),
                      ),
                    ),
                  ),
                  Text(
                    'Summary',
                    style: m_title,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 150,
                          child: ListView.builder(
                              itemCount: card_titles.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                String cardTitle = card_titles[index];
                                String activeLabel;
                                String inactiveLabel;
                                String titleLabel;

                                switch (cardTitle) {
                                  case 'Transactions':
                                    titleLabel = 'Revenue';
                                    activeLabel = 'Active:';
                                    inactiveLabel = 'Inactive:';
                                    break;
                                  case 'Orders':
                                    titleLabel = 'Revenue';
                                    activeLabel = 'Pending:';
                                    inactiveLabel = 'Completed:';
                                    break;
                                  case 'Users':
                                    titleLabel = 'Total:';
                                    activeLabel = 'Approved:';
                                    inactiveLabel = 'Pending Approval:';
                                    break;
                                  case 'Products':
                                    titleLabel = 'Revenue';
                                    activeLabel = 'Sold:';
                                    inactiveLabel = 'Available:';
                                    break;
                                  default:
                                    titleLabel = '';
                                    activeLabel = '';
                                    inactiveLabel = '';
                                    break;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCardIndex = index;
                                    });
                                  },

                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: primaryDarkColor
                                                .withOpacity(0.1))),
                                    color: Colors.grey[100],
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            card_titles[index],
                                            style: bodyText,
                                          ),
                                          Text(
                                            '1000',
                                            style: m_title,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    titleLabel,
                                                    style: bodyText,
                                                  ),
                                                  Text(
                                                    activeLabel,
                                                    style: bodyText,
                                                  ),
                                                  Text(
                                                    inactiveLabel,
                                                    style: bodyText,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kes 5,000',
                                                    style: displayTitle,
                                                  ),
                                                  Text(
                                                    '700',
                                                    style: displayTitle,
                                                  ),
                                                  Text(
                                                    '300',
                                                    style: displayTitle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //),
                                );
                              })),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    card_titles[selectedCardIndex],
                    style: m_title,
                  ),
                  getWidgetForCard(selectedCardIndex),
                ])),
      ),
    );
  }

  Widget getWidgetForCard(int index) {
    print('<<<<<<<<<<<<<<<<<<<<<<<<<< called >>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print(index);
    switch (index) {
      case 0:
        return const Transactions();
      case 1:
        return const Products();
      // return const Resellers();
      case 2:
        return const Orders();

      case 3:
        return const Users();

      default:
        return Container();
    }
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
