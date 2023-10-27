import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/reseller/orders/product_details.dart';
import 'package:petropal/reseller/reseller_dashboard/r_home.dart';

class ResellerProducts extends StatefulWidget {
  const ResellerProducts({super.key});

  @override
  State<ResellerProducts> createState() => _ResellerProductsState();
}

class _ResellerProductsState extends State<ResellerProducts> {
  List<ProductModel>? products;

  // Add filter variables for selected criteria
  String? selectedLocation;
  String? selectedDealer;
  String? selectedProduct;
  double? selectedPrice;

  @override
  void initState() {
    super.initState();

    products = generateRandomProducts(20);
  }

  List<ProductModel> generateRandomProducts(int count) {
    final List<String> productNames = ["Petrol", "Diesel", "Gasoline"];
    final List<String> dealerNames = [
      "Total Energies Kenya",
      "Shell Limited",
      "Rubis Kenya"
    ];
    final List<String> locations = ["Mombasa", "Nairobi", "Kisumu"];
    final Random random = Random();
    final List<ProductModel> products = [];

    for (int i = 0; i < count; i++) {
      final String productName =
          productNames[random.nextInt(productNames.length)];
      final String dealerName = dealerNames[random.nextInt(dealerNames.length)];
      final double price = (random.nextDouble() * 100).toDouble();
      final String location = locations[random.nextInt(locations.length)];
      final double availableVolume = random.nextDouble() * 1000;
      final double minimumVolume = random.nextDouble() * availableVolume;
      final double maximumVolume = random.nextDouble() * 2 * availableVolume;

      final product = ProductModel(
        productName: productName,
        dealerName: dealerName,
        price: price,
        location: location,
        availableVolume: availableVolume,
        minimumVolume: minimumVolume,
        maximumVolume: maximumVolume,
      );

      products.add(product);
    }

    return products;
  }

  List<ProductModel> filterProducts() {
    return products!.where((product) {
      bool locationMatch =
          selectedLocation == null || product.location == selectedLocation;
      bool dealerMatch =
          selectedDealer == null || product.dealerName == selectedDealer;
      bool productMatch =
          selectedProduct == null || product.productName == selectedProduct;
      bool priceMatch = selectedPrice == null || product.price == selectedPrice;

      return locationMatch && dealerMatch && productMatch && priceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[20],
    ));
    return Scaffold(
      backgroundColor: Colors.grey[20],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ResellerHome()));
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
      body: Padding(
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
                final filteredProducts = filterProducts();

                if (index >= filteredProducts.length) {
                  return Container(); // No more items to display
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails()));
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${filteredProducts[index].dealerName}",
                                  style: boldText,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: primaryDarkColor.withOpacity(0.1),
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
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${filteredProducts[index].productName}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      Text(
                                        "Available Volume:",
                                        style: greytext,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${filteredProducts[index].availableVolume.toStringAsFixed(2)} litres',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Minimum Volume",
                                      style: greytext,
                                    ),
                                    Text(
                                      '${filteredProducts[index].minimumVolume.toStringAsFixed(2)} litres',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 15, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.spa,
                                    children: [
                                      Text(
                                        "KES ${filteredProducts[index].price.toStringAsFixed(2)}",
                                        style: bold,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${filteredProducts[index].location}',
                                        style: bold,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Maximum Volume",
                                        style: greytext,
                                      ),
                                      Text(
                                        '${filteredProducts[index].maximumVolume.toStringAsFixed(2)} litres',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      )),
                );
              }),
              itemCount: filterProducts().length,
            ),
          ),
        ]),
      ),
    );
  }
}
