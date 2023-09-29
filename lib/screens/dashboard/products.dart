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
            'Product prices',
            style: displayBigBoldBlack,
          ),
          backgroundColor: Colors.white,
        ),
        body: CustomTransactionCard()
        // ListView.separated(
        //   itemCount: 10, // Change this to the number of items you want
        //   separatorBuilder: (context, index) => const Padding(
        //     padding: EdgeInsets.all(5),
        //     child: Divider(
        //       color: Colors.grey, // Customize the divider color
        //       thickness: 1.0, // Customize the divider thickness
        //     ),
        //   ),
        //   itemBuilder: (context, index) {
        //     // Customize the data for each item here
        //     return CustomTransactionCard();
        //   },
        // ),
        );
  }
}
