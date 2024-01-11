// ignore_for_file: avoid_print

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/average_price.dart';
import 'package:petropal/models/best_prices.dart';
import 'package:petropal/models/completed_orders.dart';
import 'package:petropal/models/product_categories.dart';
import 'package:petropal/providers/products.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/all_completed_orders.dart';
import 'package:petropal/reseller/orders/completed_orders_documents.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/profile_setup.dart';
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
  String dropDownValue = 'Weekly';
  String token = '';
  List<Average> averagePrices = [];
  List<List<Average>> allAveragePrices = [];
  String formatDate(String dateString) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final outputFormat = DateFormat('d MMM y');

    final DateTime date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }

  final SwiperController _swiperController = SwiperController();

  int _currentGraph = 0;
  bool fetchingAverage = true;
  List<Average> productAverage = [];
  bool _isWidgetMounted = true;
  late Average productAverageItem;

  Future<void> _fetchAverage(
    int productCategoryId,
    int index,
  ) async {
    print('I am here now to see averages');
    if (!_isWidgetMounted) return;

    setState(() {
      fetchingAverage = true;
    });

    final currentYear = DateTime.now().year;
    final postData = {
      'productCategoryId': productCategoryId,
      'year': currentYear,
    };
    print('This is the product category id here');
    print(productCategoryId);
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/product/get-average-price-per-week',
        postData,
        headers: headers,
      );
      print('These are the product averages I have below here');
      print('Response: $response');

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final productAverages = data.map((averageData) {
          return Average.fromJson(averageData);
        }).toList();

        // Only update if the index is still the same as when the async call was initiated
        if (_currentGraph == index) {
          _swiperController.move(index);
          setState(() {
            productAverage = productAverages;
          });
        } else {
          print('Discarding data: Index has changed.');
        }
      } else {
        print('No or invalid averages found in the response');
      }
    } catch (error) {
      print('Average Fetch By ID Error: $error');
    } finally {
      if (_isWidgetMounted) {
        setState(() {
          fetchingAverage = false;
        });
      }
    }
  }

  Future<Average> _fetchAveragePrice(int productCategoryId) async {
    final currentYear = DateTime.now().year;
    final postData = {
      'productCategoryId': productCategoryId,
      'year': currentYear,
    };
    print('This is the product category id here for the values i am fetching');
    print(productCategoryId);
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/product/get-average-price-per-week',
        postData,
        headers: headers,
      );
      print('These are the product average prices i have below here');
      print('Response: $response');

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final productAverages = data.map((averageData) {
          return Average.fromJson(averageData);
        }).toList();
//         final productAverages = data.map((averageData) {
//   final averageSellingPrice = averageData['average_selling_price'] ?? 0.0;
//   return Average(
//     day: averageData['day'],
//     averageSellingPrice: averageSellingPrice.toDouble(),
//   );
// }).toList();

        setState(() {
          allAveragePrices.add(productAverages);
        });

        return productAverages.isNotEmpty
            ? productAverages[0]
            : Average(); //set day to fetch average price
      } else {
        print('No or invalid averages found in the response');
        return Average();
      }
    } catch (error) {
      print('Average Fetch By ID Error: $error');
      return Average();
    } finally {
      if (_isWidgetMounted) {
        setState(() {
          fetchingAverage = false;
        });
      }
    }
  }

  bool fetchingCategories = true;
  List<ProductCategories> productCategory = [];
  Future<void> _fetchCategories() async {
    setState(() {
      fetchingCategories = true;
    });

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/product-category/query',
        postData,
        headers: headers,
      );
      print('These are the product categories i have below here');
      print('Response: $response');

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final productCategories = data.map((contactData) {
          return ProductCategories.fromJson(contactData);
        }).toList();

        setState(() {
          productCategory = productCategories;
        });

        for (int x = 0; x < productCategories.length; x++) {
          Average avg = await _fetchAveragePrice(productCategories[x].id ?? 0);
          setState(() {
            averagePrices.add(avg);
          });
        }
      } else {
        print('No or invalid product categories found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('contact Fetch By ID Error: $error');
      // Handle the error
    }

    setState(() {
      fetchingCategories = false;
    });
  }

  int selectedCardIndex = 0;
  bool fetchingCompletedOrders = true;
  List<CompletedOrdersModel> orders = [];

  late List<ChartData> data;
  _fetchCompleteOrders() async {
    setState(() {
      fetchingCompletedOrders = true;
    });

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/order/query-completed-orders', postData, headers: headers)
        .then((response) {
      print('Response for the completed orders is here: $response');
      if (response['data'] != null) {
        setState(() {
          orders = (response['data'] as List).map((orderData) {
            return CompletedOrdersModel(
              id: orderData['id'] as int,
              orderStatus: orderData['orderStatus'],
              orderCreatedAt: orderData['orderCreatedAt'] as String,
              orderPayableAmount: orderData['orderPayableAmount'],
              orderVolume: orderData['orderVolume'],
              orderInvoiceNumber: orderData['orderInvoiceNumber'] as String,
              orderExpiryTime: orderData['orderExpiryTime'] as String,
              orderReceiptDocument:
                  orderData['orderReceiptDocument'] as String? ?? '',
              vendorName: orderData['vendorName'] as String,
              vendorEmail: orderData['vendorEmail'] as String,
              vendorPhone: orderData['vendorPhone'] as String,
            );
          }).toList();
        });
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No orders found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('orders fetch error');
      print(error);
    });

    setState(() {
      fetchingCompletedOrders = false;
    });
  }

  bool fetchingBestPrices = true;
  List<BestPrices> prices = [];
  _fetchBestPrices() async {
    setState(() {
      fetchingBestPrices = true;
    });

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/product/get-cheapest-price-per-product', postData,
            headers: headers)
        .then((response) {
      print('Response for the BEST PRICES IS HERE is here: $response');
      if (response['data'] != null) {
        setState(() {
          prices = (response['data'] as List).map((priceData) {
            return BestPrices(
              id: priceData['id'].toInt(),
              product: priceData['product'] as String?,
              depot: priceData['depot'] as String?,
              location: priceData['location'] as String?,
              sellingPrice: priceData['selling_price'].toDouble(),
              volume: priceData['volume'].toDouble(),
              availableVolume: priceData['available_volume'].toDouble(),
              dealer: priceData['dealer'] as String?,
              remainingVolume: priceData['remaining_volume'].toDouble(),
              ordersApproved: priceData['orders_approved'].toInt(),
              ordersPending: priceData['orders_pending'].toInt(),
            );
          }).toList();
        });
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No orders found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('prices fetch error');
      print(error);
    });

    setState(() {
      fetchingBestPrices = false;
    });
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Awaiting Payment Confirmation';
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

  String _getGreeting() {
    var hour = DateTime.now().hour;
    String greeting = '';

    if (hour < 12) {
      greeting = 'Good Morning,';
    } else if (hour < 17) {
      greeting = 'Good Afternoon,';
    } else {
      greeting = 'Good Evening,';
    }

    return greeting;
  }

  @override
  void initState() {
    super.initState();
    bool isActivated =
        Provider.of<UserProvider>(context, listen: false).isActivated;
    token = Provider.of<UserProvider>(context, listen: false).token!;
    Provider.of<ProductProvider>(context, listen: false);

    if (!isActivated) {
      Future.delayed(const Duration(seconds: 1), () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Activation Required",
              style: TextStyle(color: primaryDarkColor),
            ),
            content: const Text(
              "Your account is not activated. Please complete your profile to activate your account",
              style: TextStyle(color: Colors.grey),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor.withOpacity(0.7)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileSetUp()));
                  },
                  child: const Text(
                    'Activate Now',
                    style: TextStyle(color: primaryDarkColor),
                  )),
            ],
          ),
        );
      });
    }
    _fetchCompleteOrders();
    _fetchBestPrices();
    _fetchCategories();
    _isWidgetMounted = true;
  }

  @override
  void dispose() {
    _isWidgetMounted = false;
    super.dispose();
  }

  Future<void> _refreshCompletedOrders() async {
    // Fetch orders data here
    await _fetchCompleteOrders();
  }

  Widget buildCard(BestPrices price, int index) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [Color(0xffd6e0f0), Color(0xfff4eadc)],
              stops: [0.2, 0.75],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(color: (Colors.grey[100])!)),
        duration: const Duration(seconds: 2),
        width: double.infinity,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(238, 229, 255, 1.0),
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
                      price.dealer ?? '',
                      style: bodyGrey,
                    ),
                    Text(
                      price.depot!,
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
                          price.product!,
                          style: greyT,
                        ),
                        Text(
                          formatDoubleAmountAsKES(price.sellingPrice),
                          //'KES 200',
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
      ),
    );
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
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        Provider.of<UserProvider>(context).user?.first_name ??
                            'User',
                        style: const TextStyle(color: primaryDarkColor)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 210,
                          child: productCategory.isNotEmpty
                              ? Swiper(
                                  controller: _swiperController,
                                  onIndexChanged: (index) async {
                                    // if (index < productCategory.length) {
                                    // print(
                                    //     'This is my product category noted down here: $index');
                                    // print(productCategory.length);
                                    // final currentIndex = index;
                                    // await _fetchAverage(
                                    //   productCategory[index].id!,
                                    //   currentIndex,
                                    // );

                                    print(
                                        'The total average prices: ${allAveragePrices.length}');
                                    setState(() {
                                      _currentGraph = index;
                                      //productAverageItem = averagePrices[index];
                                    });

                                    // }
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ProductCategories product =
                                        productCategory[index];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Current average price for ${product.productName}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: averagePrices
                                                          .isNotEmpty
                                                      ? Text(
                                                          formatDoubleAmountAsKES(
                                                              averagePrices[
                                                                          index]
                                                                      .totalAverageSellingPrice
                                                                      ?.toDouble() ??
                                                                  0),
                                                          style: m_title,
                                                        )
                                                      : const Text(
                                                          'No average prices set yet',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        allAveragePrices.isNotEmpty
                                            ? Expanded(
                                                child: SfCartesianChart(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  borderWidth: 0,
                                                  plotAreaBorderWidth: 0,
                                                  primaryXAxis: NumericAxis(
                                                    isVisible: false,
                                                  ),
                                                  primaryYAxis: NumericAxis(
                                                    isVisible: false,
                                                  ),
                                                  tooltipBehavior:
                                                      TooltipBehavior(
                                                          enable: true),
                                                  series: <ChartSeries<Average,
                                                      int>>[
                                                    SplineAreaSeries(
                                                      dataSource:
                                                          allAveragePrices[
                                                              index],
                                                      xValueMapper:
                                                          (Average data, _) =>
                                                              data.day,
                                                      yValueMapper: (Average
                                                                  data,
                                                              _) =>
                                                          data.averageSellingPrice,
                                                      splineType:
                                                          SplineType.natural,
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          secondaryDarkColor,
                                                          Color.fromARGB(
                                                              0, 255, 255, 255)
                                                        ],
                                                        stops: [0.01, 0.75],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const Center(
                                                child: Text(
                                                  'No average prices obtained yet',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                  itemCount: productCategory.length,
                                  viewportFraction: 1.0,
                                  scale: 0.8,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      productCategory.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentGraph == index
                                ? secondaryDarkColor
                                : secondaryDarkColor.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              prices.isEmpty
                  ? const Text(
                      'No best prices yet in your location',
                      style: TextStyle(fontSize: 16, color: primaryDarkColor),
                    )
                  : CarouselSlider(
                      items: prices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final price = entry.value;
                        return buildCard(price, index);
                      }).toList(),
                      options: CarouselOptions(
                        height: 120,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Completed Orders',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const AllCompletedOrders(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text(
                        'See all',
                        style: bodyText.copyWith(color: primaryDarkColor),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () => _refreshCompletedOrders(),
                child: fetchingCompletedOrders
                    ? const Center(child: CircularProgressIndicator())
                    : orders.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              if (index < orders.length) {
                                final order = orders[index];
                                return Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: CompletedDocuments(
                                              orders: orders[index]),
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                          withNavBar: false,
                                        );
                                      },
                                      child: ListTile(
                                        leading: Container(
                                          decoration: BoxDecoration(
                                            color: primaryDarkColor
                                                .withOpacity(0.1),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${order.vendorName}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              DateFormat('d MMM y').format(
                                                  DateTime.parse(
                                                      order.orderCreatedAt!)),
                                              style: displaySmallerLightGrey
                                                  .copyWith(fontSize: 12),
                                            ),

                                            // Text(
                                            //   // '10 Jan 2023',

                                            //   '${order.orderCreatedAt!}',
                                            //   style: displaySmallerLightGrey
                                            //       .copyWith(fontSize: 12),
                                            // ),
                                          ],
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${order.orderInvoiceNumber}',
                                                    // '${order.paymentBankOption}',
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  // Text(
                                                  //   '12 Sept 2023',
                                                  //   style: displaySmallerLightGrey,
                                                  // ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    formatAmountAsKES(order
                                                        .orderPayableAmount),
                                                    //'${order.orderPayableAmount}',
                                                    //${order.payableAmount}',
                                                    style: displayTitle.copyWith(
                                                        color:
                                                            primaryDarkColor),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            201, 247, 245, 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8,
                                                          top: 4,
                                                          bottom: 4,
                                                          right: 8),
                                                      child: Text(
                                                        "Completed",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              27,
                                                              197,
                                                              189,
                                                              1.0),
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
                                    ),
                                    if (index < 5)
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Divider(
                                          color: Colors.grey[100],
                                          thickness: 1,
                                        ),
                                      ), // Add a divider except for the last item
                                  ],
                                );
                              } else {
                                return null;
                              }
                            },
                            itemCount: orders.length > 5 ? 5 : orders.length,
                          )
                        : Center(
                            child: Column(children: [
                              Image.asset(
                                'assets/illustrations/transactions.png',
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                'No completed orders at the moment',
                                style: displayTitle,
                              )
                            ]),
                          ),
              )),
            ])));
  }
}

String formatAmountAsKES(int? amount) {
  if (amount == null) {
    return 'KES 0.00';
  }
  final currencyFormat = NumberFormat.currency(locale: 'en_KES', symbol: 'KES');
  final double amountDouble = amount.toDouble(); // Convert int to double
  return currencyFormat.format(amountDouble);
}

String formatDoubleAmountAsKES(double? amount) {
  if (amount == null) {
    return 'KES 0.00';
  }
  final currencyFormat =
      NumberFormat.currency(locale: 'en_KES', symbol: 'KES ');
  final double amountDouble = amount.toDouble(); // Convert int to double
  return currencyFormat.format(amountDouble);
}
