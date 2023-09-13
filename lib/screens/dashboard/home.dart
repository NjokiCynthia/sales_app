import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
  int _currentIndex = 0;

  List<String> titles = ['Petrol', 'Diesel', 'Petrol'];

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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/petropal_logo.png',
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          'Petropal',
                          style: m_title, // You can define your own style here
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Swiper(
                      controller: _swiperController,
                      onIndexChanged: (index) {
                        setState(() {
                          _currentIndex = index;
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
                                            style:
                                                const TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Kes 91.30',
                                            style: m_title,
                                          ),
                                        ],
                                      ),
                                      DropdownButton<String>(
                                        value: dropdownvalue,
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
                                        primaryXAxis: CategoryAxis(
                                          // Customize the appearance of the X-axis labels here
                                          majorGridLines: const MajorGridLines(
                                              color: Colors
                                                  .black), // Gridlines color
                                          labelStyle: const TextStyle(
                                              color:
                                                  primaryDarkColor), // X-axis labels color (set to red)
                                          axisLine: const AxisLine(
                                              color: Colors
                                                  .black), // X-axis line color
                                        ),
                                        primaryYAxis: NumericAxis(
                                          // Customize the appearance of the Y-axis here
                                          majorGridLines: const MajorGridLines(
                                              color: Colors
                                                  .black), // Gridlines color
                                          labelStyle: const TextStyle(
                                              color:
                                                  primaryDarkColor), // Y-axis labels color
                                          axisLine:
                                              const AxisLine(color: Colors.black),
                                        ),
                                        series: <LineSeries<SalesData, String>>[
                                          LineSeries<SalesData, String>(
                                            // Bind data source
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
                                          )
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
                            color: _currentIndex == index
                                ? primaryDarkColor // Active dot color
                                : primaryDarkColor
                                    .withOpacity(0.1) // Inactive dot color
                            ),
                      ),
                    ),
                  ),
                  Text(
                    'Transactions',
                    style: m_title,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) => Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.all(10),
                                      color: Colors.green[700],
                                      child: Center(
                                        child: Text('Card $index'),
                                      ),
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ])),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
