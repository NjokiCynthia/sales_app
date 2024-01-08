// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/completed_orders.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/completed_orders_documents.dart';
import 'package:provider/provider.dart';

class AllCompletedOrders extends StatefulWidget {
  const AllCompletedOrders({super.key});

  @override
  State<AllCompletedOrders> createState() => _AllCompletedOrdersState();
}

class _AllCompletedOrdersState extends State<AllCompletedOrders> {
  bool fetchingCompletedOrders = true;
  List<CompletedOrdersModel> orders = [];

  _fetchCompleteOrders(BuildContext context) async {
    setState(() {
      fetchingCompletedOrders = true;
    });

    // Retrieve user information from the provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {
      "queryParams": {"pageSize": 100},
    };
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

  @override
  void initState() {
    super.initState();
    _fetchCompleteOrders(context);
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
              'All Completed Orders',
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
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: () => _refreshCompletedOrders(context),
            child: fetchingCompletedOrders
                ? const Center(child: CircularProgressIndicator())
                : orders.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < orders.length) {
                            final order = orders[index]; // Define 'order' here
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
                                        color:
                                            primaryDarkColor.withOpacity(0.1),
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
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formatAmountAsKES(
                                                    order.orderPayableAmount),
                                                //'${order.orderPayableAmount}',
                                                //${order.payableAmount}',
                                                style: displayTitle.copyWith(
                                                    color: primaryDarkColor),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        201, 247, 245, 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
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
                          }
                          return null;
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
    );
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
