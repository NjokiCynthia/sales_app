import 'package:flutter/material.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/widgets/widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
            style: displayBigBoldBlack,
          ),
          backgroundColor: Colors.white,
        ),
        body: CustomTransactionCard());
  }
}
