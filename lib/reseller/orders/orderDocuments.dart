import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/order.dart';
import 'package:petropal/models/order_documents.dart';
import 'package:petropal/models/orders.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/models/product_document.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDocuments extends StatefulWidget {
  final Order orders;
  const OrderDocuments({super.key, required this.orders});

  @override
  State<OrderDocuments> createState() => _OrderDocumentsState();
}

class _OrderDocumentsState extends State<OrderDocuments> {
  bool fetchingOrderDocuments = true;
  OrderDocumentsModel? orderDocuments;

  _fetchOrderDocuments(BuildContext context) async {
    setState(() {
      fetchingOrderDocuments = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final apiClient = ApiClient();
    final postData = {
      'id': '${widget.orders.id}',
    };
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print('This is the order id ${widget.orders.id}');

    await apiClient
        .post('/order/get', postData, headers: headers)
        .then((response) {
      print('Response is here now: $response');
      if (response['status'] == 1) {
        if (response['data'] != null) {
          try {
            final data = response['data'];
            final orderDocumentsModel = OrderDocumentsModel(
              id: data['id'],
              orderStatus: int.parse(data['orderStatus'].toString()),
              orderCreatedAt: DateTime.parse(data['orderCreatedAt'].toString()),
              orderPayableAmount:
                  double.parse(data['orderPayableAmount'].toString()),
              orderOmcAmount: double.parse(data['orderOmcAmount'].toString()),
              status: int.parse(data['status'].toString()),
              products:
                  List<ProductModel>.from(data['products'].map((productData) {
                return ProductModel(
                  productDocuments: ProductDocuments(
                    orderVolume: productData['orderVolume'],
                    productPrice:
                        double.parse(productData['productPrice'].toString()),
                    pricePerProduct:
                        double.parse(productData['pricePerProduct'].toString()),
                    purchasePricePerUnit: double.parse(
                        productData['purchasePricePerUnit'].toString()),
                    productCategoryCode: productData['productCategoryCode'],
                    productCategoryName: productData['productCategoryName'],
                    productCategoryDescription:
                        productData['productCategoryDescription'],
                  ),
                );
              })),
              orderInvoiceNumber: data['orderInvoiceNumber'].toString(),
              vendorName: data['vendorName'].toString(),
              vendorEmail: data['vendorEmail'].toString(),
              vendorPhone: data['vendorPhone'].toString(),
              vendorAccountName: data['vendorAccountName'].toString() ?? '',
              vendorAccountNumber: data['vendorAccountNumber'].toString() ?? '',
              vendorBankName: data['vendorBankName'].toString() ?? '',
              vendorBranchName: data['vendorBranchName'].toString() ?? '',
              resellerName: data['resellerName'].toString() ?? '',
              resellerEmail: data['resellerEmail'].toString() ?? '',
              resellerPhone: data['resellerPhone'].toString() ?? '',
              depot: data['depot'].toString() ?? '',
              location: data['location'].toString() ?? '',
              driverName: data['driverName'].toString() ?? '',
              driverPhoneNumber: data['driverPhoneNumber'].toString() ?? '',
              driverIdNumber: data['driverIdNumber'].toString() ?? '',
              driverLicenceNumber: data['driverLicenceNumber'].toString() ?? '',
              driverEpraLicenceNumber:
                  data['driverEpraLicenceNumber'].toString() ?? '',
              truckNumber: data['truckNumber'].toString() ?? '',
              truckCompartment: data['truckCompartment'].toString(),
              proformaInvoiceDoc: data['proformaInvoiceDoc'].toString() ?? '',
              resellerProofOfPayment:
                  data['resellerProofOfPayment'].toString() ?? '',
              purchaseOrder: data['purchaseOrder'].toString() ?? '',
              receipt: data['receipt'].toString() ?? '',
              loadingOrder: data['loadingOrder'].toString() ?? '',
              invoiceOrderDocument:
                  data['invoiceOrderDocument'].toString() ?? '',
            );

            setState(() {
              orderDocuments = orderDocumentsModel;
            });
          } catch (e) {
            print('Error parsing order documents data: $e');
          }
        } else {
          // Handle the case where 'data' is null or not present in the response.
          print('No order documents found in the response');
        }
      }
    }).catchError((error) {
      // Handle the error
      print('Error: $error');
    });

    setState(() {
      fetchingOrderDocuments = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchOrderDocuments(context);
  }

  Future<void> _refreshOrderDocuments(BuildContext context) async {
    await _fetchOrderDocuments(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));
    // Check if orderDocuments is not null
    if (orderDocuments != null) {
      final product = orderDocuments!.products;
      final status = orderDocuments!.orderStatus;
      final hasProformaInvoice = [1, 2, 3, 4, 5].contains(status);
      final hasProofOfPayment = [2, 3, 4].contains(status);
      final hasReceipt = [3, 4].contains(status);
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
                  'Order Information',
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
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoice Number',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // ... conditionally show/hide document links ...
                            if (hasProformaInvoice)
                              buildDocumentLink(
                                'Proforma Invoice',
                                orderDocuments?.proformaInvoiceDoc ?? '',
                              ),
                            if (hasProofOfPayment)
                              buildDocumentLink(
                                'Proof of payment',
                                orderDocuments?.resellerProofOfPayment ?? '',
                              ),
                            if (hasReceipt)
                              buildDocumentLink(
                                'Payment Receipt',
                                orderDocuments?.receipt ?? '',
                              ),

                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Loading Order',
                              style: textBolderSmall,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Payment receipt',
                              style: textBolderSmall,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Loading Depot',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.orders.orderInvoiceNumber}',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryDarkColor.withOpacity(0.1)),
                                child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(children: [
                                      Text(
                                        "View Document",
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
                                    ]))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryDarkColor.withOpacity(0.1)),
                                child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(children: [
                                      Text(
                                        "View Document",
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
                                    ]))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryDarkColor.withOpacity(0.1)),
                                child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(children: [
                                      Text(
                                        "View Document",
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
                                    ]))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primaryDarkColor.withOpacity(0.1)),
                                child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(children: [
                                      Text(
                                        "View Document",
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
                                    ]))),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${orderDocuments!.depot ?? ''}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Transporter Details',
                style: m_title,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Driver Name',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ID Number',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Phone number',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Epra Licence Number	',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'License Number',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Truck registration number',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Truck Compartments',
                        style: textBolderSmall,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${orderDocuments?.driverName ?? 'No driver'}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.driverIdNumber ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.driverPhoneNumber ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.driverEpraLicenceNumber ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.driverLicenceNumber ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.truckNumber ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${orderDocuments!.truckCompartment ?? ''}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Item/s ordered',
                style: m_title,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${product?.elementAt(index).productDocuments!.productCategoryName ?? 'N/A'}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${product?.elementAt(index).productDocuments!.productCategoryCode ?? 'N/A'}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                '${product?.elementAt(index).productDocuments!.orderVolume ?? 'N/A'} liters ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unit Price',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    'Total Price',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'KES ${product.elementAt(index).productDocuments!.pricePerProduct ?? 'N/A'}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'KES ${product.elementAt(index).productDocuments!.productPrice ?? 'N/A'}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  }),
                  itemCount: product.length,
                ),
              ),
              Center(
                child: Text(
                  'The total amount payable is: KES ${widget.orders.orderPayableAmount}',
                  style: m_title.copyWith(color: primaryDarkColor),
                ),
              ),
            ]),
          )));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  // Helper function to build clickable document links or "No Document"/"Upload Document" text
  Widget buildDocumentLink(String label, String documentUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textBolderSmall,
        ),
        if (documentUrl.isNotEmpty) // Check if a document URL exists
          InkWell(
            onTap: () {
              launchURL(documentUrl); // Function to open the link
            },
            child: Text(
              'View Document',
              style: TextStyle(
                color: primaryDarkColor.withOpacity(0.5),
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: primaryDarkColor,
                decorationStyle: TextDecorationStyle.dotted,
                decorationThickness: 3,
              ),
            ),
          )
        else
          Text(
            documentUrl.isEmpty ? 'No Document' : 'Upload Document',
            style: TextStyle(
              color: documentUrl.isEmpty ? Colors.red : primaryDarkColor,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

// Function to open the link in a web browser
  Future<void> launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
