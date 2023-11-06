import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/providers/products.dart';
import 'package:petropal/reseller/orders/order_details.dart';
import 'package:provider/provider.dart';
import 'package:petropal/constants/api.dart';
import '../../providers/user_provider.dart';

class ResellerProducts extends StatefulWidget {
  const ResellerProducts({super.key});

  @override
  State<ResellerProducts> createState() => _ResellerProductsState();
}

class _ResellerProductsState extends State<ResellerProducts> {
  // List<ProductModel>? products
  String? selectedLocation;
  String? selectedDealer;
  String? selectedProduct;
  double? selectedPrice;

  bool fetchingProducts = true;
  List<ProductModel> products = [];

  _fetchProducts(BuildContext context) async {
    setState(() {
      fetchingProducts = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    await apiClient
        .post('/product/approved-products', postData, headers: headers)
        .then((response) {
      print('Response: $response');
      if (response['data'] != null) {
        try {
          final data = List<Map<String, dynamic>>.from(response['data']);
          final productModels = data.map((productData) {
            return ProductModel(
              id: productData['id'].toString(),
              counter: productData['counter'].toString(),
              createdBy: productData['created_by'].toString(),
              product: productData['product'].toString(),
              depot: productData['depot'].toString(),
              sellingPrice: productData['selling_price'],
              price: productData['price'],
              location: productData['location'].toString(),
              availableVolume: productData['volume'],
              minimumVolume: productData['min_vol'],
              maximumVolume: productData['max_vol'],
              ordersApproved: productData['orders_approved'].toString(),
              dealerName: productData['dealer'].toString(),
              commissionRate: productData['commission_rate'],
              ordersPending: productData['orders_pending'],
              status: productData['status'].toString(),
              companyId: productData['company_id'].toString(),
              remaining_volume: productData['remaining_volume'],
            );
          }).toList();

          setState(() {
            products = productModels;
          });
        } catch (e) {
          print('Error parsing product data: $e');
        }
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No products found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('Error: $error');
    });

    setState(() {
      fetchingProducts = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _products =
        Provider.of<ProductProvider>(context, listen: true).products;

    bool isLoading =
        Provider.of<ProductProvider>(context, listen: true).isLoading;

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
                'Products and Cart',
                style: m_title,
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.shopping_cart,
                  color: primaryDarkColor,
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Provider<ProductProvider>(
          create: (_) => ProductProvider(),
          builder: (context, child) {
            // bool isLoading = context.watch<ProductProvider>().isLoading;
            // List<ProductModel> products = context.watch<ProductProvider>().products;

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(
                  height: 42,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: primaryDarkColor,
                          weight: 1,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Search products',
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintStyle: bodyGrey,
                        suffixIcon: Icon(
                          Icons.filter_alt_off_outlined,
                          color: primaryDarkColor,
                        )),
                    // decoration: InputDecoration(
                    //   prefixIcon: Icon(Icons.search),
                    //   border: OutlineInputBorder(),
                    //   hintText: 'Search products',
                    //   hintStyle: bodyGrey,
                    //   labelStyle: TextStyle(color: Colors.black),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: OrderDetails(),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                              withNavBar: false);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shell Limited",
                                        style: boldText,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              primaryDarkColor.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.add_shopping_cart,
                                          color: primaryDarkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Available Volume:",
                                                style: greytext,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Minimum  Order Volume:",
                                                style: greytext,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Maximum Order Volume:",
                                                style: greytext,
                                              ),
                                            ]),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '10000 litres',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '50 litres',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '50 litres',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ],
                            )),
                      );
                    }),
                    itemCount: 10,
                  ),
                ),
              ]),
            );
          },
        )
        // body:  Text("the pirates are here")
        //   body: Provider<ProductProvider>(
        //     create: (_) => ProductProvider(),
        //     builder: (context,child) {
        // return (
        //     Text("${context.watch<ProductProvider>().products.length}");
        // )
        //     })
        //
        //       }
        //     }
        );
  }
}
