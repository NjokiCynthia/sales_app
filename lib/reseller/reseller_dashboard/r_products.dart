// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/currency_convertor.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/list_model.dart';
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

    List<String> dealerList = omcs.map((e) => e.name).toList();
    List<String> productList = productTypes.map((e) => e.name).toList();
    List<String> locationList = locations.map((e) => e.name).toList();

    int dealerIndex = -1, productIndex = -1, locationIndex = -1;

    if (selectedDealer != null) {
      dealerIndex = dealerList.indexOf(selectedDealer ?? '');
    }
    if (selectedProduct != null) {
      productIndex = productList.indexOf(selectedProduct ?? '');
    }
    if (selectedLocation != null) {
      locationIndex = locationList.indexOf(selectedLocation ?? '');
    }

    var postData = {
      "queryParams": {
        //"pageSize": 100,
        "filter": {
          "account_id": selectedDealer != null ? omcs[dealerIndex].id : 0,
          "location_id":
              selectedLocation != null ? locations[locationIndex].id : 0,
          "product":
              selectedProduct != null ? productTypes[productIndex].id : 0,
        },
      },
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
              sellingPrice: double.parse(
                  productData['selling_price']?.toString()?.trim() ?? '0'),
              price:
                  double.parse(productData['price']?.toString()?.trim() ?? '0'),
              // sellingPrice:
              //     double.parse(productData['selling_price'].toString().trim()),
              // price: double.parse(productData['price'].toString()),
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
            filtersApplied = true;
          });
        } catch (e) {
          print('Raw Response: $response');
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

  void _clearFilters() {
    setState(() {
      selectedLocation = null;
      selectedDealer = null;
      selectedProduct = null;
    });
    _fetchProducts(context);
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
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
                items:
                    locations.map((l) => l.name.toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedLocation = value;
                  });
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
              const SizedBox(
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
                  suffixIcon: const Icon(
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
                  setState(() {
                    selectedProduct = value;
                  });
                  print('Depot selected: $value');
                },
              ),
              const SizedBox(
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
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryDarkColor,
                  ),
                ),
                items: omcs
                    .where((e) => e.name != null && e.name.isNotEmpty)
                    .map((e) => e.name)
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

                // items: omcs.map((e) => e.name).map((String value) {
                //   return DropdownMenuItem<String>(
                //     value: value,
                //     child: Text(value),
                //   );
                // }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedDealer = value;
                  });
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
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    _clearFilters();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear Filters'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  onPressed: () {
                    _refreshProducts(context);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Filter'),
                )
              ],
            )
          ],
        );
      },
    );
  }

  bool filtersApplied = false;

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
            // Navigate back to the home screen
            Navigator.popUntil(context, (route) => true);
            bottomNavigationController.jumpToTab(0);
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
          } else if (products.isEmpty && !filtersApplied) {
            return Center(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          _showDropdownDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: primaryDarkColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: primaryDarkColor,
                        ),
                        label: const Text(
                          'Filter Products',
                          style: TextStyle(color: primaryDarkColor),
                        )),
                  ),
                ),
                Image.asset('assets/illustrations/products.png'),
                Text(
                  'No products available at the moment',
                  style: displayTitle,
                )
              ]),
            );
          } else if (products.isEmpty && filtersApplied) {
            // Show a message when there are no products
            return Center(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          _showDropdownDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: primaryDarkColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: primaryDarkColor,
                        ),
                        label: const Text(
                          'Filter Products',
                          style: TextStyle(color: primaryDarkColor),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Image.asset('assets/illustrations/products.png'),
                Text(
                  'No products available in your location',
                  style: displayTitle,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkColor),
                  onPressed: () {
                    // Clear filters when the button is pressed
                    _clearFilters();
                  },
                  child: const Text('Clear Filters'),
                ),
              ]),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          _showDropdownDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: primaryDarkColor,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: primaryDarkColor,
                        ),
                        label: const Text(
                          'Filter Products',
                          style: TextStyle(color: primaryDarkColor),
                        )),
                  ),
                  const SizedBox(
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
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'KES ${currencyFormat.format(product.sellingPrice)}',
                                              style: boldText,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              product.depot!,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // Format the volume with a thousands separator
                                                  NumberFormat.decimalPattern()
                                                      .format(product
                                                          .availableVolume),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                const Text(
                                                  'litres',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  // Format the volume with a thousands separator
                                                  NumberFormat.decimalPattern()
                                                      .format(product
                                                          .minimumVolume),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                const Text(
                                                  'litres',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
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
