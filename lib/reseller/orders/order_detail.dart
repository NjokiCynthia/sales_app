import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/best_prices.dart';

import 'package:petropal/models/product_details.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/make_order.dart';
import 'package:provider/provider.dart';
import 'package:petropal/models/order_product.dart';

class OrderDetail extends StatefulWidget {
  final BestPrices price;

  const OrderDetail({super.key, required this.price});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  double totalValue = 0.0;
  double minimumVolumePerOrder = 0.0;
  final double pricePerLiter = 200.0;
  bool fetchingDetails = true;
  List<ProductListing> productList = [];
  List<TextEditingController> orderVolume = [];
  List<OrderProductModel> orderedProducts = [];
  Future<void> _fetchDetails(BuildContext context) async {
    setState(() {
      fetchingDetails = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {
      'productId': '${widget.price.id}',
    };
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print('${widget.price.id}');

    try {
      final response = await apiClient.post(
        '/product/get-approved-by-account-id-and-depot-id',
        postData,
        headers: headers,
      );

      print('Response: $response');

      if (response['status'] == 1 && response['data'] != null) {
        final data =
            List<Map<String, dynamic>>.from(response['cartProductsListing']);
        final productModels = data.map((productData) {
          minimumVolumePerOrder =
              double.parse(productData['minimum_volume_per_order'].toString());
          return BestPrices(
            id: int.parse(productData['id'].toString()),
            product: productData['product'].toString(),
            depot: productData['depot'].toString(),
            location: productData['location'].toString(),
            sellingPrice: int.parse(productData['selling_price'].toString()),
            volume: productData['volume'] != null
                ? int.parse(productData['volume'].toString())
                : null,
            availableVolume: productData['available_volume'] != null
                ? int.parse(productData['available_volume'].toString())
                : null,
            dealer: productData['dealer'].toString(),
            remainingVolume: productData['remaining_volume'] != null
                ? int.parse(productData['remaining_volume'].toString())
                : null,
            ordersApproved:
                int.parse(productData['orders_approved'].toString()),
            ordersPending: int.parse(productData['orders_pending'].toString()),
          );
        }).toList();

        final orderVols = data.map((productData) {
          return TextEditingController();
        }).toList();

        setState(() {
          productList = productModels.cast<ProductListing>();
        });

        setState(() {
          orderVolume = orderVols;
        });
      } else {
        print('No or invalid products found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Product Fetch By ID Error: $error');
      // Handle the error
    }

    setState(() {
      fetchingDetails = false;
    });
  }

  String formatVolume(double volume) {
    final formatter = NumberFormat('#,###.##');
    return formatter.format(volume);
  }

  @override
  void initState() {
    super.initState();
    _fetchDetails(context);
  }

  double calculateOrderVolume() {
    List<double> vols = [];
    List<TextEditingController> orderItems = orderVolume;
    vols = orderItems
        .map((e) =>
            e.text.toString().isEmpty ? 0.0 : double.parse(e.text.toString()))
        .toList();
    double totalVols = vols.reduce((value, element) => value + element);
    return totalVols;
  }

  String checkMinimumMaximumVolume(String value, int index) {
    double minimumVolume = double.parse(productList[index].minVol.toString());
    double maximumVolume =
        double.parse(productList[index].availableVolume.toString());
    if (value.isNotEmpty) {
      double currentVolume = double.parse(value);
      if (currentVolume < minimumVolume) {
        return 'Value is less than minimum volume: $minimumVolume';
      } else if (currentVolume > maximumVolume) {
        return 'Value is greater than available volume: $maximumVolume';
      } else {
        return '';
      }
    }
    return '';
  }

  void updateOrderProducts() {
    orderedProducts.clear();
    for (int index = 0; index < orderVolume.length; index++) {
      String value = orderVolume[index].text.toString();
      if (value.isNotEmpty) {
        double currentVolume = double.parse(value);
        orderedProducts.add(OrderProductModel(
            id: 0,
            orderId: 0,
            productId: productList[index].productId,
            price: productList[index].sellingPrice,
            volume: currentVolume,
            productName: productList[index].productName));
      }
    }
  }

  void updateTotal(total) {
    setState(() {
      totalValue = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryDarkColor,
                    ),
                  ),
                  Text(
                    'Order Details',
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
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.price.dealer}',
                            style: textBolderSmall,
                          ),
                          Text(
                            '${widget.price.location}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Depot',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '${widget.price.depot}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Products Available',
                style: textBolder,
              ),
              SizedBox(
                height: 10,
              ),
              fetchingDetails
                  ? Center(child: CircularProgressIndicator())
                  : productList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: productList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = productList[index];

                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${product.productName}',
                                            style: textBolderSmall,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Available volume:',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Minimum volume',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            '${formatVolume(product.minVol)}litres',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Specify the Volume:',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'KES ${product.sellingPrice}/',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'litre',
                                                  style: bodyTextSmaller,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${formatVolume(product.availableVolume)}  litres',
                                            style: textBolderSmall,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Maximum volume',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            '${formatVolume(product.maxVol)}litres',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              controller: orderVolume[index],
                                              style: TextStyle(
                                                  color: Colors.black),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (text) {
                                                double totalVolumeOrdered =
                                                    calculateOrderVolume();
                                                print(totalVolumeOrdered);
                                                updateTotal(totalVolumeOrdered);
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Volume',
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorText:
                                                    checkMinimumMaximumVolume(
                                                                orderVolume[
                                                                        index]
                                                                    .text,
                                                                index)
                                                            .isNotEmpty
                                                        ? checkMinimumMaximumVolume(
                                                            orderVolume[index]
                                                                .text,
                                                            index)
                                                        : null,
                                                prefixIcon: const Icon(
                                                    Icons.add_circle),
                                                prefixIconColor: Colors.grey,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[500]),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: primaryDarkColor
                                                        .withOpacity(0.1),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: primaryDarkColor
                                                        .withOpacity(0.1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: primaryDarkColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (index < productList.length - 1)
                                    Divider(
                                      color: Colors.black,
                                    ),
                                ],
                              );
                            },
                          ),
                        )
                      : Text(
                          'No products available',
                          style: TextStyle(color: primaryDarkColor),
                        ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Text(
                  'Volume:  ${formatVolume(totalValue)} liters',
                  style: textBolder,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Text(
                  'Minimum Volume: ${formatVolume(minimumVolumePerOrder)} litres',
                  style: textBolderSmall,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: (totalValue < minimumVolumePerOrder)
                    ? Text(
                        'Volume is less than the minimum value required per order: ${minimumVolumePerOrder} liters',
                        style: const TextStyle(color: Colors.red),
                      )
                    : null,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                    disabledBackgroundColor: Theme.of(context)
                        .primaryColor
                        .withOpacity(.3), // Background Color
                    disabledForegroundColor: Colors.white70, // Text Color
                  ),
                  onPressed: totalValue >= minimumVolumePerOrder &&
                          productList.every((product) =>
                              orderVolume[productList.indexOf(product)]
                                  .text
                                  .isEmpty ||
                              checkMinimumMaximumVolume(
                                      orderVolume[productList.indexOf(product)]
                                          .text,
                                      productList.indexOf(product))
                                  .isEmpty)
                      ? () {
                          updateOrderProducts();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => MakeOrder(
                                    totalVolume: totalValue,
                                    orderProducts: orderedProducts,
                                    depotName: widget.price.depot!,
                                    depotLocation: widget.price.location!,
                                  )),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
