import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'dart:math';

import 'package:petropal/constants/theme.dart';

enum SearchOption { Name, Amount }

class Product {
  final String name;
  final double amount;
  final String description;

  Product(
      {required this.name, required this.amount, required this.description});
}

class PriceApproval extends StatefulWidget {
  const PriceApproval({Key? key}) : super(key: key);

  @override
  State<PriceApproval> createState() => _PriceApprovalState();
}

class _PriceApprovalState extends State<PriceApproval> {
  SearchOption _selectedSearchOption =
      SearchOption.Name; // Selected search option

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios,
            color: primaryDarkColor.withOpacity(0.7),
          ),
          title: Text(
            'Product List',
            style: m_title,
          ),
          bottom: const TabBar(
            labelColor: primaryDarkColor,
            indicatorColor: primaryDarkColor,
            tabs: [
              Tab(
                text: 'Approved Prices',
              ),
              Tab(text: 'Unapproved Prices'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ApprovedPricesScreen(),
            UnapprovedPricesScreen(
              selectedSearchOption: _selectedSearchOption,
            ), // Pass selected search option
          ],
        ),
      ),
    );
  }
}

class ApprovedPricesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('List of Approved Prices'),
    );
  }
}

// ignore: must_be_immutable
class UnapprovedPricesScreen extends StatefulWidget {
  SearchOption selectedSearchOption; // Selected search option

  UnapprovedPricesScreen({required this.selectedSearchOption});

  @override
  _UnapprovedPricesScreenState createState() => _UnapprovedPricesScreenState();
}

class _UnapprovedPricesScreenState extends State<UnapprovedPricesScreen> {
  final TextEditingController _searchController = TextEditingController();
  double _maxAmount = 95;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _showApproveButton = false;

  @override
  void initState() {
    super.initState();
    _generateRandomProducts();
    _filteredProducts = List.of(_products);
  }

  void _generateRandomProducts() {
    final random = Random();
    for (int i = 1; i <= 20; i++) {
      final product = Product(
        name: 'OLA Energy',
        amount: 80 + random.nextDouble() * 20,
        description: 'Aug 24, 4.38pm',
      );
      _products.add(product);
    }
  }

  void _filterByName(String query) {
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      _updateShowApproveButton();
    });
  }

  void _filterByAmount(String query) {
    setState(() {
      try {
        final double queryAmount = double.parse(query);
        _filteredProducts = _products.where((product) {
          return product.amount >= queryAmount && product.amount <= _maxAmount;
        }).toList();

        _updateShowApproveButton();
      } catch (e) {}
    });
  }

  void _updateShowApproveButton() {
    setState(() {
      _showApproveButton = _filteredProducts.isNotEmpty;
    });
  }

  void _filterProducts(String query) {
    if (widget.selectedSearchOption == SearchOption.Name) {
      _filterByName(query);
    } else {
      _filterByAmount(query);
    }
  }

  void _showApprovalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Approval',
            style: bodyText,
          ),
          content: Text(
            'Do you want to approve the price ranges?',
            style: bodyTextSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDisapprovalDialog();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: primaryDarkColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: primaryDarkColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDisapprovalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Disapproval'),
          content: const Text('Do you want to disapprove all other products?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                DefaultTabController.of(context)
                    .animateTo(0); // Switch to the first tab.
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<SearchOption>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      dropdownColor: Colors.white,
                      iconDisabledColor: primaryDarkColor,
                      iconEnabledColor: primaryDarkColor,
                      value: widget
                          .selectedSearchOption, // Use selected search option
                      onChanged: (SearchOption? newValue) {
                        if (newValue != null) {
                          setState(() {
                            widget.selectedSearchOption =
                                newValue; // Update selected search option
                          });
                        }
                      },
                      items: SearchOption.values.map((SearchOption option) {
                        return DropdownMenuItem<SearchOption>(
                          value: option,
                          child: Text(
                            option == SearchOption.Name
                                ? 'Search by Name'
                                : 'Search by Amount',
                            style: bodyText,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      style: bodyTextSmall,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Search',
                        labelStyle: bodyTextSmall.copyWith(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryDarkColor.withOpacity(0.1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryDarkColor.withOpacity(0.1),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: primaryDarkColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType:
                          widget.selectedSearchOption == SearchOption.Amount
                              ? TextInputType.number
                              : TextInputType.text,
                      onChanged: _filterProducts,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];

                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/reseller.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: displayTitle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${product.description}',
                                    style:
                                        bodyText.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kes ${product.amount.toStringAsFixed(2)}',
                                    style: displayTitle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/tick.png',
                                        width: 30,
                                        height: 20,
                                        color: Colors.redAccent,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Image.asset(
                                          'assets/images/cancel.png',
                                          width: 15,
                                          height: 15,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Divider(
                          color: Colors.grey[200],
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
        if (_showApproveButton)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: primaryDarkColor),
              onPressed: () {
                _showApprovalDialog();
              },
              child: const Text('Approve Price'),
            ),
          ),
      ],
    );
  }
}
