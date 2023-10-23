import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_transactions.dart';
import 'package:petropal/screens/superadmin_dashboard/chart_data.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ResellerHome extends StatefulWidget {
  const ResellerHome({super.key});

  @override
  State<ResellerHome> createState() => _ResellerHomeState();
}

class _ResellerHomeState extends State<ResellerHome> {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: primaryDarkColor.withOpacity(0.1)));

    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Column(children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Current price for ${titles[index]}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
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
                                      labelStyle: const TextStyle(
                                          color: primaryDarkColor),
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
                                        xValueMapper: (ChartData data, _) =>
                                            data.day,
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
                    ])),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: mytitle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResellerTransactions()));
                      },
                      child: Text(
                        'See all',
                        style: bodyText.copyWith(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '#12345678h',
                                      style: bodyGrey1,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              201, 247, 245, 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                            color: Color.fromRGBO(
                                                27, 197, 189, 1.0),
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
              )
            ])));
  }
}
