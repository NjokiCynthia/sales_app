// ignore_for_file: avoid_print

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

  String? selectedDealer;

  double? selectedPrice;

  String? selectedOMC;
  String? selectedLocation;
  String? selectedProduct;
  String? selectedSort;
  String? selectedItem;
  List<String>? currentItems;

  Map<String, List<String>> allItems = {
    'OMC': ['OMC1', 'OMC2', 'OMC3'],
    'Location': ['Location1', 'Location2', 'Location3'],
    'Product': ['Product1', 'Product2', 'Product3'],
    'Sort': ['Sort1', 'Sort2', 'Sort3'],
  };

  bool fetchingProducts = true;
  List<ProductModel> products = [];

  _fetchProducts(BuildContext context) async {
    setState(() {
      fetchingProducts = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {
      // "queryParams": {
      //   "pageSize": 100,
      //   "pageNumber": 1,
      //   "sortOption": 1,
      //   "account_id": 0,
      //   "location_id": 0,
      //   "depot_id": 0,
      //   "product": 0,
      // },
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

  @override
  void initState() {
    super.initState();
    _fetchProducts(context);
    selectedItem = 'OMC';
    currentItems = allItems['OMC']!;
  }

  // Future<void> _refreshProducts(BuildContext context) async {
  //   // Fetch orders data here
  //   await _fetchProducts(context);
  // }

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
            return const Center(child: CircularProgressIndicator());
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            style: bodyTextSmall,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Select an item',
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
                            ),
                            value: selectedItem,
                            items: allItems.keys.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedItem = value!;
                                currentItems = allItems[value]!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            style: bodyTextSmall,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Select a ${selectedItem ?? 'item'}',
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
                            ),
                            // decoration: InputDecoration(
                            //   labelText: 'Select a ${selectedItem ?? 'item'}',
                            //   border: OutlineInputBorder(),
                            // ),
                            value: currentItems!.isNotEmpty
                                ? currentItems![0]
                                : null,
                            items: currentItems!.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // Handle the selected value for the current item type
                              print('Selected $selectedItem: $value');
                            },
                          ),
                        ),
                      ),
                    ],
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
                                              'KES ${product.sellingPrice!.toString()}',
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
                                            Text(
                                              '${product.availableVolume} litres',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${product.minimumVolume} litres',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
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
