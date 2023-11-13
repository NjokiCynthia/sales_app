import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/ListModel.dart';
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
  bool fetchingOptions = true;
  List<ProductModel> products = [];

  List<ListModel> sortOptions = [];
  List<ListModel> locations = [];
  List<ListModel> omcs = [];
  List<ListModel> productTypes = [];

  _fetchProducts(BuildContext context) async {
    setState(() {
      fetchingProducts = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {
      //"queryParams": {"pageSize": 100},
    };
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
              id: int.parse(productData['id'].toString()),
              counter: int.parse(productData['counter'].toString()),
              createdBy: int.parse(productData['created_by'].toString()),
              product: productData['product'].toString(),
              depot: productData['depot'].toString(),
              sellingPrice:
                  double.parse(productData['selling_price'].toString()),
              price: double.parse(productData['price'].toString()),
              location: productData['location'].toString(),
              availableVolume: double.parse(productData['volume'].toString()),
              minimumVolume: double.parse(productData['min_vol'].toString()),
              maximumVolume: double.parse(productData['max_vol'].toString()),
              dealerName: productData['dealer'].toString(),
              commissionRate:
                  double.parse(productData['commission_rate'].toString()),
              status: int.parse(productData['status'].toString()),
              companyId: int.parse(productData['company_id'].toString()),
              remainingVolume:
                  double.parse(productData['remaining_volume'].toString()),
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

  _fetchOptions(BuildContext context) async {
    setState(() {
      fetchingOptions = true;
    });

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

    //get locations
    await apiClient
        .post('/location/query', postData, headers: headers)
        .then((response) {
      print('Locations Response: $response');
      if (response['data'] != null) {
        try {
          final data = List<Map<String, dynamic>>.from(response['data']);
          final locationModels = data.map((data) {
            return ListModel(
              id: int.parse(data['id'].toString()),
              name: data['name'].toString(),
            );
          }).toList();

          setState(() {
            locations = locationModels;
          });
        } catch (e) {
          print('Error parsing locations data: $e');
        }
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No locations found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('Error: $error');
    });

    setState(() {
      fetchingProducts = false;
    });

    //get product types
    await apiClient
        .post('/product-category/query', postData, headers: headers)
        .then((response) {
      print('Product types Response: $response');
      if (response['data'] != null) {
        try {
          final data = List<Map<String, dynamic>>.from(response['data']);
          final productTypeModels = data.map((data) {
            return ListModel(
              id: int.parse(data['id'].toString()),
              name: data['product_name'].toString(),
            );
          }).toList();

          setState(() {
            productTypes = productTypeModels;
          });
        } catch (e) {
          print('Error parsing locations data: $e');
        }
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No locations found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('Error: $error');
    });

    setState(() {
      fetchingProducts = false;
    });

    //get omcs
    await apiClient
        .post('/account/fetch/all/omcs', postData, headers: headers)
        .then((response) {
      print('Omcs Response: $response');
      if (response['data'] != null) {
        try {
          final data = List<Map<String, dynamic>>.from(response['data']);
          final omcModels = data.map((data) {
            return ListModel(
              id: int.parse(data['id'].toString()),
              name: data['company_name'].toString(),
            );
          }).toList();

          setState(() {
            omcs = omcModels;
          });
        } catch (e) {
          print('Error parsing omcs data: $e');
        }
      } else {
        // Handle the case where 'data' is null or not present in the response.
        print('No omcs found in the response');
      }
    }).catchError((error) {
      // Handle the error
      print('Error: $error');
    });

    setState(() {
      fetchingOptions = false;
    });

  }



  @override
  void initState() {
    super.initState();
    _fetchProducts(context);
    _fetchOptions(context);
  }

  Future<void> _refreshProducts(BuildContext context) async {
    // Fetch orders data here
    await _fetchProducts(context);
  }

  void _showDropdownDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select filter Option',
            style: m_title.copyWith(color: primaryDarkColor),
          ),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: bodyTextSmall,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Location',
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
                      width: 2.0,
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
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
                items: locations.map((l)=>l.name.toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  print('OMC selected: $value');
                },
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // DropdownButtonFormField<String>(
              //   dropdownColor: Colors.white,
              //   style: bodyTextSmall,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.white,
              //     labelText: 'Depot',
              //     labelStyle: TextStyle(color: Colors.grey[500]),
              //     border: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         color: Colors.grey,
              //         width: 1.0,
              //       ),
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.grey.shade300,
              //         width: 2.0,
              //       ),
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         color: Colors.grey,
              //         width: 1.0,
              //       ),
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     suffixIcon: Icon(
              //       Icons.keyboard_arrow_down,
              //       color: primaryDarkColor,
              //     ),
              //   ),
              //   items: locations.map((e) => e.name.toString()).map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? value) {
              //     print('Location selected: $value');
              //   },
              // ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: bodyTextSmall,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Product',
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
                      width: 2.0,
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
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
                items: productTypes.map((e) => e.name).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  print('Depot selected: $value');
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                style: bodyTextSmall,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'OMC',
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
                      width: 2.0,
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
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
                items: omcs.map((e) => e.name).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  print('Products selected: $value');
                },
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor.withOpacity(0.1)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Filter'),
                )
              ],
            )
          ],
        );
      },
    );
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
          if (fetchingProducts) {
            // Show loading indicator while fetching products
            return Center(child: CircularProgressIndicator());
          } else if (products.isEmpty) {
            // Show a message when there are no products
            return Center(
              child: Column(children: [
                Image.asset('assets/illustrations/products.png'),
                Text(
                  'No products available at the moment',
                  style: displayTitle,
                )
              ]),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        _showDropdownDialog(context);
                      },
                      icon: Icon(
                        Icons.filter_alt_off_outlined,
                        color: primaryDarkColor,
                      ),
                      label: Text('Filter')),
                  // SizedBox(
                  //   height: 42,
                  //   child: TextFormField(
                  //     style: TextStyle(color: Colors.black),
                  //     decoration: InputDecoration(
                  //         prefixIcon: Icon(
                  //           Icons.search,
                  //           color: primaryDarkColor,
                  //           weight: 1,
                  //         ),
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         labelText: 'Search products',
                  //         labelStyle: TextStyle(color: Colors.grey[500]),
                  //         border: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //             color: Colors.grey,
                  //             width: 1.0,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Colors.grey.shade300,
                  //             width: 1.0,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //             color: Colors.grey,
                  //             width: 1.0,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //         hintStyle: bodyGrey,
                  //         suffixIcon: Icon(
                  //           Icons.filter_alt_off_outlined,
                  //           color: primaryDarkColor,
                  //         )),
                  //     // decoration: InputDecoration(
                  //     //   prefixIcon: Icon(Icons.search),
                  //     //   border: OutlineInputBorder(),
                  //     //   hintText: 'Search products',
                  //     //   hintStyle: bodyGrey,
                  //     //   labelStyle: TextStyle(color: Colors.black),
                  //     // ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _fetchProducts(context);
                      },
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final product =
                              products[index]; // Get the actual product data

                          return GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: OrderDetails(
                                  product: product,
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                                withNavBar: false,
                              );
                              print(product);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.product!,
                                          style: boldText,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: primaryDarkColor
                                                .withOpacity(0.1),
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
                                      bottom: 15,
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Dealer name",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Product price",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Depot",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Available Volume:",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Minimum Order Volume:",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product
                                                  .dealerName!, // Actual dealer name
                                              style: boldText,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'KES ${product.sellingPrice!.toString()}',
                                              style: boldText,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              product.depot!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${product.availableVolume} litres',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${product.minimumVolume} litres',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: products
                            .length, // Use the actual product list length
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
