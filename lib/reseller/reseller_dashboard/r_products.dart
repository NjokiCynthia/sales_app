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

  @override
  void initState() {
    super.initState();
    // print("the profile is here");
    // products = generateRandomProducts(20);
  }

  // fetching the products.
  @override
  void didChangeDependencies() {
    _fetchProducts();
    super.didChangeDependencies();
  }

  void  _fetchProducts () async {
    print("the start of fetching products000000");



    await ApiClient().fetchProducts("$ipAddress/product/approved-products");


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

    // for (int i = 0; i < count; i++) {
    //   final String productName =
    //       productNames[random.nextInt(productNames.length)];
    //   final String dealerName = dealerNames[random.nextInt(dealerNames.length)];
    //   final double price = (random.nextDouble() * 100).toDouble();
    //   final String location = locations[random.nextInt(locations.length)];
    //   final double availableVolume = random.nextDouble() * 1000;
    //   final double minimumVolume = random.nextDouble() * availableVolume;
    //   final double maximumVolume = random.nextDouble() * 2 * availableVolume;
    //
    //   final product = ProductModel(
    //     product: productName,
    //     dealerName: dealerName,
    //     price: price,
    //     location: location,
    //     availableVolume: availableVolume,
    //     minimumVolume: minimumVolume,
    //     maximumVolume: maximumVolume,
    //   );
    //
    //   products.add(product);
    // }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _products = Provider
        .of<ProductProvider>(context, listen: true)
        .products;

    bool isLoading = Provider
        .of<ProductProvider>(context, listen: true)
        .isLoading;

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
        create:(_) => ProductProvider(),
        builder: (context,child){
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
              // Text("isLoading $isLoading"),
              // Text("the products length ${_products.length}"),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Shell Limited",
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
                                                fontWeight: FontWeight.normal),
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
