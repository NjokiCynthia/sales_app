import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/orders.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResellerOrders extends StatefulWidget {
  const ResellerOrders({super.key});

  @override
  State<ResellerOrders> createState() => _ResellerOrdersState();
}

class _ResellerOrdersState extends State<ResellerOrders> {
  bool fetchingOrders = true;
  List<Order> orders = [];

  _fetchOrders(BuildContext context) async {
    setState(() {
      fetchingOrders = true;
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
            onTap: () {
              Navigator.pop(context);
            },
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
                ? Center(
                    child:
                        CircularProgressIndicator()) // Display a loading indicator while fetching data
                : orders.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          return Container(
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${order.vendorName}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.orderCreatedAt
                                              .toLocal()
                                              .toString(),
                                          style: greyText,
                                        ),
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
                                              getStatusText(order.orderStatus),
                                              style: TextStyle(
                                                color: getStatusColor(
                                                    order.orderStatus),
                                                fontSize: 16,
                                              ),
                                            ),
                                            // child: Text(
                                            //   order.orderStatus,
                                            //   style: TextStyle(
                                            //     color: Color.fromRGBO(
                                            //         246, 78, 96, 1.0),
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
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
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                "KES ${order.orderPayableAmount}/",
                                            style: boldText,
                                          ),
                                          TextSpan(
                                            text: '${order.orderVolume ?? ''}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ), // Style for the unit
                                          ),
                                        ],
                                      ),
                                    ),
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
                          );
                        },
                        itemCount: orders.length,
                      )
                    : Text(
                        'No orders found in the response',
                        style: TextStyle(color: Colors.black),
                      ),
          ),
        ));
  }
}
