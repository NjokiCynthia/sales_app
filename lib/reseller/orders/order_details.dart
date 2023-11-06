import 'package:flutter/material.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/models/product_details.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/orders/make_order.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final ProductModel product;
  const OrderDetails({super.key, required this.product});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  double totalValue = 0.0;
  final double pricePerLiter = 200.0;
  bool fetchingDetails = true;
  List<ProductListing> products = [];
  Future<void> _fetchDetails(BuildContext context) async {
    setState(() {
      fetchingDetails = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final postData = {
      'productId': '${widget.product.id}',
    };
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print('${widget.product.id}');

    try {
      final response = await apiClient.post(
        '/product/get-approved-by-account-id-and-depot-id',
        postData,
        headers: headers,
      );

      print('Response: $response');

      if (response['status'] == 1 && response['cartProductsListing'] != null) {
        final data =
            List<Map<String, dynamic>>.from(response['cartProductsListing']);
        final productModels = data.map((productData) {
          return ProductListing(
            product_id: int.parse(productData['product_id'].toString()),
            product_name: productData['product_name'].toString(),
            depot_name: productData['depot_name'].toString(),
            location: productData['location'].toString(),
            product_code: '',
            depot_code: '',
            company_id: int.parse(productData['company_id'].toString()),
            company_name: productData['company_name'],
            company_email: productData['company_email'],
            company_phone: productData['company_phone'],
            minimum_volume_per_order: productData['min_vol'],
            price_per: productData['price'],
            selling_price: productData['selling_price'],
            stock_volume: productData['stock_volume'],
            available_volume: productData['available_volume'],
            min_vol: productData['min_vol'],
            max_vol: productData['max_vol'],
            status: int.parse(productData['status'].toString()),
            commission_rate:
                double.parse(productData['commission_rate'].toString()),
          );
        }).toList();

        setState(() {
          products = productModels;
        });
      } else {
        print('No or invalid products found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error
    }

    setState(() {
      fetchingDetails = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDetails(context);
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
                    child: Icon(
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
              SizedBox(
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
                            '${widget.product.dealerName}',
                            style: textBolderSmall,
                          ),
                          Text(
                            '${widget.product.location}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Depot',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '${widget.product.depot}',
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
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.product.product}',
                                  style: textBolderSmall,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Available volume:',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Minimum volume',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '${widget.product.minimumVolume} litres',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'KES ${widget.product.sellingPrice}/',
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
                                  '${widget.product.availableVolume} litres',
                                  style: textBolderSmall,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Maximum volume',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '${widget.product.maximumVolume} litres',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (index < products.length - 1)
                          Divider(
                            color: Colors.black,
                          ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MakeOrder(
                              productName: widget.product.product,
                              minVolume:
                                  widget.product.minimumVolume.toString() +
                                      ' litres',
                              maxVolume:
                                  widget.product.maximumVolume.toString() +
                                      ' litres',
                              availableVolume:
                                  widget.product.availableVolume.toString() +
                                      ' litres',
                              depotName: widget.product.depot,
                              depotLocation: widget.product.location,
                            )),
                      ),
                    );
                  },
                  child: Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
