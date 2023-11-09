import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/orders.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/orderDocuments.dart';
import 'package:provider/provider.dart';

class ResellerOrders extends StatefulWidget {
  const ResellerOrders({super.key});

  @override
  State<ResellerOrders> createState() => _ResellerOrdersState();
}

class _ResellerOrdersState extends State<ResellerOrders> {
  bool fetchingOrders = true;
  List<Order> orders = [];
  String formatDateTime(DateTime dateTime) {
    final outputFormat = DateFormat('d MMM y');
    return outputFormat.format(dateTime);
  }

  _fetchOrders(BuildContext context) async {
    setState(() {
      fetchingOrders = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final token = userProvider.user?.token;
    if (token == null) {
      print('Token is null.');
      setState(() {
        fetchingOrders = false;
      });
      return;
    }

    final postData = {
      "queryParams": {"pageSize": 100},
    };

    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    print(postData);

    await apiClient
        .post('/order/query', postData, headers: headers)
        .then((response) {
      print('Response: $response');
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
      fetchingOrders = false;
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
        return const Color.fromARGB(255, 35, 31, 31);
      case 2:
        return Colors.orange;
      case 3:
        return Colors.purple;
      case 4:
        return Color.fromRGBO(27, 197, 189, 1.0);
      case 5:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Color getStatusContainerColor(int status) {
    switch (status) {
      case 1:
        return const Color.fromARGB(
            255, 245, 245, 245); // Lighter shade of blue
      case 2:
        return const Color.fromARGB(255, 255, 224, 178);
      //const Color.fromARGB(255, 255, 249, 196);
      case 3:
        return Color.fromARGB(255, 252, 237, 252); // Lighter shade of grey
      case 4:
        return Color.fromRGBO(201, 247, 245, 1.0); // Lighter shade of orange
      case 5:
        return const Color.fromARGB(255, 255, 205, 210); // Lighter shade of red
      default:
        return Colors.black; // You can specify the default color here
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders(context);
  }

  Future<void> _refreshOrders(BuildContext context) async {
    // Fetch orders data here
    await _fetchOrders(context);
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
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios,
              color: primaryDarkColor,
            ),
          ),
          backgroundColor: Colors.grey[50],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Orders',
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
          padding: EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: fetchingOrders
                ? Center(child: CircularProgressIndicator())
                : orders.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          return GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDocuments(
                                  orders: order,
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                                withNavBar: false,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(color: Colors.white),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#${order.orderInvoiceNumber}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${order.vendorName}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${order.orderCreatedAt}',
                                            // '${formatDateTime(order.orderCreatedAt)}',
                                            style: displaySmallerLightGrey
                                                .copyWith(fontSize: 12),
                                          ),

                                          // Text(
                                          //   // '${formatDate(order.orderCreatedAt!)}',
                                          //   order.orderCreatedAt
                                          //       .toLocal()
                                          //       .toString(),
                                          //   style: greyText,
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: getStatusContainerColor(
                                                    order.orderStatus),
                                                // color: Color.fromRGBO(
                                                //     255, 226, 229, 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 4,
                                                  bottom: 4,
                                                  left: 8,
                                                  right: 8),
                                              child: Text(
                                                getStatusText(
                                                    order.orderStatus),
                                                style: TextStyle(
                                                  color: getStatusColor(
                                                      order.orderStatus),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'KES ${order.orderPayableAmount}',
                                        style: boldText.copyWith(
                                            color: primaryDarkColor),
                                      ),
                                      // RichText(
                                      //   text: TextSpan(
                                      //     style: DefaultTextStyle.of(context)
                                      //         .style,
                                      //     children: <TextSpan>[
                                      //       TextSpan(
                                      //         text:
                                      //             "KES ${order.orderPayableAmount}/",
                                      //         style: boldText,
                                      //       ),
                                      //       TextSpan(
                                      //         text:
                                      //             '${order.orderVolume ?? ''}',
                                      //         style: TextStyle(
                                      //           fontSize: 14,
                                      //           color: Colors.grey,
                                      //         ), // Style for the unit
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Text(
                                        "View more",
                                        style: TextStyle(
                                          color:
                                              primaryDarkColor.withOpacity(0.5),
                                          fontSize: 12,
                                          decoration: TextDecoration.underline,
                                          decorationColor: primaryDarkColor,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          decorationThickness: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: orders.length,
                      )
                    : Center(
                        child: Column(children: [
                          Image.asset('assets/illustrations/orders.png'),
                          Text(
                            'No orders made at the moment',
                            style: displayTitle,
                          )
                        ]),
                      ),
          ),
        ));
  }
}
