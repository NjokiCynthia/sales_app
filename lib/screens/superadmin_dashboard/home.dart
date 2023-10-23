import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/superadmin_dashboard/chart_data.dart';

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

  late List<ChartData> data;
  @override
  void initState() {
    super.initState();
    data = [
      ChartData(17, 200),
      ChartData(18, 205),
      ChartData(19, 190),
      ChartData(20, 201),
      ChartData(21, 196),
      ChartData(22, 206),
      ChartData(23, 209),
      ChartData(24, 202),
      ChartData(25, 191),
      ChartData(26, 195),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryDarkColor.withOpacity(0.1)
            //primaryDarkColor.withOpacity(0.5), // Set the desired color
            ));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
          // child: Padding(
          //     padding: const EdgeInsets.all(5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
            Container(
              color: primaryDarkColor.withOpacity(0.1),
              child: Column(children: [
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Current price for ${titles[index]}',
                                    style: const TextStyle(color: Colors.black),
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
                          SizedBox(
                            height: 150,
                            child: SfCartesianChart(
                              margin: const EdgeInsets.all(0),
                              borderWidth: 0,
                              borderColor: Colors.transparent,
                              plotAreaBorderWidth: 0,
                              primaryXAxis: NumericAxis(
                                minimum: 17,
                                maximum: 26,
                                isVisible: false,
                              ),
                              primaryYAxis: NumericAxis(
                                minimum: 188,
                                maximum: 211,
                                borderWidth: 0,
                                labelStyle:
                                    const TextStyle(color: primaryDarkColor),
                                isVisible: false,
                              ),
                              series: <ChartSeries<ChartData, int>>[
                                SplineAreaSeries(
                                    dataSource: data,
                                    xValueMapper: (ChartData data, _) =>
                                        data.day,
                                    yValueMapper: (ChartData data, _) =>
                                        data.price,
                                    splineType: SplineType.natural,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(133, 233, 176, 92),
                                        Color.fromARGB(0, 255, 255, 255)
                                      ],
                                      stops: [0.01, 0.75],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )),
                                SplineSeries(
                                  dataSource: data,
                                  color: secondaryDarkColor,
                                  markerSettings: const MarkerSettings(
                                    color: secondaryDarkColor,
                                    borderWidth: 2,
                                    shape: DataMarkerType.circle,
                                    isVisible: false,
                                  ),
                                  xValueMapper: (ChartData data, _) => data.day,
                                  yValueMapper: (ChartData data, _) =>
                                      data.price,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 3,
                    viewportFraction: 1.0,
                    scale: 0.8,
                  ),
                ),

                //const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentgraph == index
                                ? secondaryDarkColor
                                : secondaryDarkColor.withOpacity(0.1)),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: m_title,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                card_titles[selectedCardIndex],
                style: m_title,
              ),
            ),
            getWidgetForCard(selectedCardIndex),
          ])),
      // ),
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
