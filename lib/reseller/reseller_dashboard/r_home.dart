import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_transactions.dart';
import 'package:petropal/screens/superadmin_dashboard/chart_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class ResellerHome extends StatefulWidget {
  const ResellerHome({super.key});

  @override
  State<ResellerHome> createState() => _ResellerHomeState();
}

class _ResellerHomeState extends State<ResellerHome> {
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
      statusBarColor: Colors.grey[50],
    ));

    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Column(children: [
                Container(
                    color: Colors.grey[50],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Current average price for ${titles[index]}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Kes 91.30',
                                            style: m_title,
                                          ),
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
                                              // primaryDarkColor.withOpacity(0.5),
                                              secondaryDarkColor,
                                              //Color.fromARGB(133, 216, 161, 79),
                                              Color.fromARGB(0, 255, 255, 255)
                                            ],
                                            stops: [0.01, 0.75],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )),
                                      SplineSeries(
                                        dataSource: data,
                                        color: secondaryDarkColor,
                                        // primaryDarkColor.withOpacity(0.02),
                                        markerSettings: const MarkerSettings(
                                          color: secondaryDarkColor,
                                          borderWidth: 1,
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
              CarouselSlider(
                items: List.generate(5, (index) => buildCard(index)),
                options: CarouselOptions(
                  height: 120,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                ),
              ),
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
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ResellerTransactions(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
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
                              Row(
                                children: [
                                  Text(
                                    'Shell Limited ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    '| 12 Sept 2023',
                                    style: displaySmallerLightGrey.copyWith(
                                        fontSize: 12),
                                  ),
                                  Text('')
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '#12345678h',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              201, 247, 245, 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            top: 4,
                                            bottom: 4,
                                            right: 8),
                                        child: Text(
                                          "Successful",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
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
                              color: Colors.grey[100],
                              thickness: 1,
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

Widget buildCard(int index) {
  return AnimatedContainer(
    height: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/icons/blob.png"),
        //   fit: BoxFit.cover,
        //   alignment: Alignment.topCenter,
        // ),
        gradient: LinearGradient(
          colors: [Color(0xffd6e0f0), Color(0xfff4eadc)],
          stops: [0.2, 0.75],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: (Colors.grey[100])!)),
    duration: Duration(seconds: 1),
    width: double.infinity,
    child: Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(238, 229, 255, 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                "Best price!!",
                style: TextStyle(color: Color.fromRGBO(137, 80, 252, 1)),
              ),
            ),
          ),
        ),
        ListTile(
            // leading: Image.asset(
            //   'assets/images/icons/blob.png',
            //   height: 5,
            //   width: 5,
            // ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shell Limited',
                  style: bodyGrey,
                ),
                Text(
                  'Nairobi',
                  style: greyT,
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Petrol',
                      style: greyT,
                    ),
                    Text(
                      'KES 200',
                      style: bodyGrey,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: primaryDarkColor,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    ),
  );
}
