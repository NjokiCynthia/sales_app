import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/orders.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/authentication/login.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/profile_setup.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_transactions.dart';
import 'package:petropal/screens/superadmin_dashboard/chart_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

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
  List<String> title = ['Petrol', 'Diesel', 'Kerosene'];

  int selectedCardIndex = 0;
  bool fetchingCompletedOrders = true;
  List<Order> orders = [];

  late List<ChartData> data;
  _fetchCompleteOrders(BuildContext context) async {
    setState(() {
      fetchingCompletedOrders = true;
    });

    // Retrieve user information from the provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/order/fetch/complete', postData, headers: headers)
        .then((response) {
      print('Response for the completed orders is here: $response');
      if (response['data'] != null) {
        setState(() {
          orders = (response['data'] as List).map((orderData) {
            return Order(
              id: orderData['id'].toString(),
              orderStatus: orderData['orderStatus'] as int,
              orderPayableAmount:
                  orderData['orderPayableAmount'].toString() ?? '',
              orderVolume: orderData['orderVolume'].toString() ?? '',
              orderInvoiceNumber:
                  orderData['orderInvoiceNumber'].toString() ?? '',
              vendorName: orderData['vendorName'].toString() ?? '',
              vendorEmail: orderData['vendorEmail'].toString() ?? '',
              orderCreatedAt:
                  DateTime.parse(orderData['orderCreatedAt'].toString() ?? ''),
            );
          }).toList();
        });
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No orders found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('error');
      print(error);
    });

    setState(() {
      fetchingCompletedOrders = false;
    });
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Awaiting Payment';
      case 2:
        return 'Awaiting Confirmation';
      case 3:
        return 'Pending Loading Order';
      case 4:
        return 'Completed';
      case 5:
        return 'Expired';
      default:
        return 'Unknown Status';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors
            .black; // You can specify the existing color or a custom color here
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.black; // You can specify the default color here
    }
  }

  Color getStatusContainerColor(int status) {
    switch (status) {
      case 1:
        return const Color.fromARGB(
            255, 187, 222, 251); // Lighter shade of blue
      case 2:
        return const Color.fromARGB(
            255, 255, 249, 196); // Lighter shade of yellow
      case 3:
        return const Color.fromARGB(
            255, 245, 245, 245); // Lighter shade of grey
      case 4:
        return const Color.fromARGB(
            255, 255, 224, 178); // Lighter shade of orange
      case 5:
        return const Color.fromARGB(255, 255, 205, 210); // Lighter shade of red
      default:
        return Colors.black; // You can specify the default color here
    }
  }

  @override
  void initState() {
    super.initState();
    bool isActivated =
        Provider.of<UserProvider>(context, listen: false).isActivated;
    print('The status of my account is ........ $isActivated');
    if (!isActivated) {
      Future.delayed(Duration(seconds: 1), () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Activation Required"),
            content: Text(
                "Your account is not activated. Please complete your profile to activate your account"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Login())));
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileSetUp()));
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      });
    }
    _fetchCompleteOrders(context);
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

  Future<void> _refreshCompletedOrders(BuildContext context) async {
    // Fetch orders data here
    await _fetchCompleteOrders(context);
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
                items: List.generate(3, (index) => buildCard(index)),
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
                  itemCount: 5,
                ),
              )
            ])));
  }
}

Widget buildCard(int index) {
  List<String> title = ['Petrol', 'Diesel', 'Kerosene'];
  return AnimatedContainer(
    height: 100,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [Color(0xffd6e0f0), Color(0xfff4eadc)],
          stops: [0.2, 0.75],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: (Colors.grey[100])!)),
    duration: Duration(seconds: 2),
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
                      title[index],
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
