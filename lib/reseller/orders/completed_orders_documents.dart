// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/completed_orders.dart';
import 'package:petropal/models/order_documents.dart';
import 'package:petropal/models/product.dart';
import 'package:petropal/models/product_document.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedDocuments extends StatefulWidget {
  final CompletedOrdersModel orders;
  const CompletedDocuments({super.key, required this.orders});

  @override
  State<CompletedDocuments> createState() => _CompletedDocumentsState();
}

class _CompletedDocumentsState extends State<CompletedDocuments> {
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
              vendorAccountName: data['vendorAccountName'].toString(),
              vendorAccountNumber: data['vendorAccountNumber'].toString(),
              vendorBankName: data['vendorBankName'].toString(),
              vendorBranchName: data['vendorBranchName'].toString(),
              resellerName: data['resellerName'].toString(),
              resellerEmail: data['resellerEmail'].toString(),
              resellerPhone: data['resellerPhone'].toString(),
              depot: data['depot'].toString(),
              location: data['location'].toString(),
              driverName: data['driverName'].toString(),
              driverPhoneNumber: data['driverPhoneNumber'].toString(),
              driverIdNumber: data['driverIdNumber'].toString(),
              driverLicenceNumber: data['driverLicenceNumber'].toString(),
              driverEpraLicenceNumber:
                  data['driverEPRALicenceNumber'].toString(),
              truckNumber: data['truckNumber'].toString(),
              truckCompartment: data['truckCompartment'].toString(),
              proformaInvoiceDoc: data['proformaInvoiceDoc'].toString(),
              resellerProofOfPayment: data['resellerProofOfPayment'].toString(),
              purchaseOrder: data['purchaseOrder'].toString(),
              receipt: data['receipt'].toString(),
              loadingOrder: data['loadingOrder'].toString(),
              invoiceOrderDocument: data['invoiceOrderDocument'].toString(),
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

  // Future<void> _refreshOrderDocuments(BuildContext context) async {
  //   await _fetchOrderDocuments(context);
  // }

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
      final hasLoadingOrder = [4].contains(status);
      return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (status == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please upload proof of payment',
                      style: m_title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showUploadDialog(context);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primaryDarkColor,
                            border: Border.all(color: primaryDarkColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Upload Proof of Payment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationStyle: TextDecorationStyle.dotted,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Invoice Number',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${widget.orders.orderInvoiceNumber}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Loading Depot',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              orderDocuments!.depot.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // ... conditionally show/hide document links ...
                        if (hasProformaInvoice)
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(
                                orderDocuments?.proformaInvoiceDoc.toString() ??
                                    '')),
                            child: const Text(
                              'Download Proforma-Invoice',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (hasProofOfPayment)
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(orderDocuments
                                    ?.resellerProofOfPayment
                                    .toString() ??
                                '')),
                            child: const Text(
                              'Download Proof of Payment',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (hasReceipt)
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(
                                orderDocuments?.receipt.toString() ?? '')),
                            child: const Text(
                              'Download Receipt',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),

                        const SizedBox(
                          height: 5,
                        ),
                        if (hasLoadingOrder)
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(
                                orderDocuments?.loadingOrder.toString() ?? '')),
                            child: const Text(
                              'Download Loading order',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Transporter Details',
                style: m_title,
              ),
              const SizedBox(
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
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ID Number',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Phone number',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Epra Licence Number	',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'License Number',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Truck registration number',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Truck Compartments',
                        style: textBolderSmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderDocuments?.driverName ?? 'No driver',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.driverIdNumber,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.driverPhoneNumber,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.driverEpraLicenceNumber.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.driverLicenceNumber,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.truckNumber,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        orderDocuments!.truckCompartment,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Item/s ordered',
                style: m_title,
              ),
              const SizedBox(
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
                                    product
                                        .elementAt(index)
                                        .productDocuments!
                                        .productCategoryName,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product
                                        .elementAt(index)
                                        .productDocuments!
                                        .productCategoryCode,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                '${product.elementAt(index).productDocuments!.orderVolume} liters ',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
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
                                    'KES ${product.elementAt(index).productDocuments!.purchasePricePerUnit}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'KES ${product.elementAt(index).productDocuments!.productPrice}',
                                    style: const TextStyle(color: Colors.grey),
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
                  'The total cost is: KES ${widget.orders.orderPayableAmount}',
                  style: m_title.copyWith(color: primaryDarkColor),
                ),
              ),
            ]),
          )));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  PlatformFile? selectedProofOfPayment; // Add this variable
  String selectedProofOfPaymentName = '';

  Future<void> openPOPFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected KRA certificate photo here
      PlatformFile file = result.files.first;
      print('POP File Name: ${file.name}');
      print('POP File Size: ${file.size}');

      setState(() {
        selectedProofOfPaymentName = file.name;
        selectedProofOfPayment =
            file; // Assign the selected file to the variable
      });
    } else {
      // User canceled the file picker
    }
  }

  void uploadPOP(transactionCode, uploadedFile) async {
    FormData formData = FormData();

    formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          uploadedFile!.path.toString(),
          filename: uploadedFile!.name,
        )));

    final url = Uri.parse('https://petropal.africa:8050/order/upload-receipt');
    final url2 = Uri.parse('https://petropal.africa:8050/payment/record');
    // final url =
    //     Uri.parse('https://petropal.sandbox.co.ke:8040/order/upload-receipt');
    // final url2 =
    //     Uri.parse('https://petropal.sandbox.co.ke:8040/payment/record');
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    if (token == null) {
      return;
    }

    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    await dio
        .post(
      url.toString(),
      data: formData,
    )
        .then((response) {
      print(response);
      String filename = response.data['name'].toString();
      return dio.post(
        url2.toString(),
        data: {
          'order_id': widget.orders.id,
          'transaction_code': transactionCode.toString(),
          'payment_mode': 1,
          'payment_date': DateTime.now().toString(),
          'payment_document': filename
        },
      ).then((response2) {
        Navigator.of(context).pop(); // Close the dialog
      });
    });
  }

  Future<void> _showUploadDialog(BuildContext context) async {
    TextEditingController transactionCodeController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Add Proof of Payment',
            style: bodyGrey,
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.comment_bank,
                      color: primaryDarkColor,
                    ),
                    Text(
                      'Transaction Code',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextFormField(
                  style: bodyText,
                  controller: transactionCodeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorText: transactionCodeController.text.isEmpty
                        ? 'Please add a transaction code'
                        : null,
                    labelText: "Transaction Code",
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey[500]),
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(children: [
                  GestureDetector(
                    onTap: openPOPFilePicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Upload Proof of Payment',
                          style: bodyText,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    selectedProofOfPaymentName,
                    style: bodyText,
                  ),
                ]),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the newlyuploaded file
                uploadPOP(
                    transactionCodeController.text, selectedProofOfPayment);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }
}
