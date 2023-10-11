import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class CustomTransactionCard extends StatelessWidget {
  const CustomTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryDarkColor.withOpacity(0.1)),
                        child: Image.asset(
                          'assets/images/fuel-station.png',
                          width: 20,
                          height: 20,
                        )),
                    Text(
                      'Kerosene',
                      style: m_title,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Average Price',
                          style: bodyText,
                        ),
                        Text(
                          'Kes 90',
                          style: displayTitle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Today's average",
                          style: bodyText,
                        ),
                        Text(
                          'Kes 92',
                          style: displayTitle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: primaryDarkColor)),
                      onPressed: () {},
                      child: Text(
                        'Approve prices',
                        style: bodyText,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGreyBackground = true; // Track the background color

    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          // Toggle background color
          isGreyBackground = !isGreyBackground;
          final backgroundColor =
              isGreyBackground ? Colors.grey[100] : Colors.white;

          return Container(
            color: backgroundColor, // Set the background color
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/tanker.png',
                  width: 20,
                  height: 20,
                ),
              ),
              title: const Text(
                'Rubis Kenya',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'rubis@example.com',
                      style: TextStyle(
                        color: Colors.black, // Text color
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's price: Kes 100",
                          style: bodyText,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor.withOpacity(0.6),
                          ),
                          child: const Text('View details'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGreyBackground = true; // Track the background color

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          // Toggle background color
          isGreyBackground = !isGreyBackground;
          final backgroundColor =
              isGreyBackground ? Colors.grey[200] : Colors.white;

          return Container(
            color: backgroundColor, // Set the background color
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_outward,
                  color: primaryDarkColor,
                  size: 15,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shell Limited',
                    textScaleFactor: 1,
                    style: displayTitle,
                  ),
                  Text(
                    'Kes 5000',
                    style: displayTitle,
                  )
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment for kerosene',
                    style: bodyTextSmall,
                  ),
                  Text(
                    '12 Sept 2023',
                    style: displaySmallerLightGrey,
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGreyBackground = true; // Track the background color

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          // Toggle background color
          isGreyBackground = !isGreyBackground;
          final backgroundColor =
              isGreyBackground ? Colors.grey[200] : Colors.white;

          return Container(
            color: backgroundColor, // Set the background color
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.money_off,
                  color: primaryDarkColor,
                  size: 15,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shell Limited',
                    // textScaleFactor: 1.5,
                    style: displayTitle,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                      child: Text(
                        'Pending',
                        style: bodySmall.copyWith(color: Colors.green),
                      ),
                    ),
                  ),
                  Text(
                    'Kes 5000',
                    style: displayTitle,
                  )
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1000 litres petrol',
                        style: bodyTextSmall,
                      ),
                      Text(
                        'Commission',
                        style: bodyTextSmall,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '12 Sept 2023',
                        style: displaySmallerLightGrey,
                      ),
                      Text(
                        'Kes 5000',
                        style: displaySmallerLightGrey,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> productTitles = [
      'Petrol',
      'Kerosene',
      'Diesel',
    ];

    bool isGreyBackground = true; // Track the background color

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final productTitle = productTitles[index]; // Get the product title

          // Toggle background color
          isGreyBackground = !isGreyBackground;
          final backgroundColor =
              isGreyBackground ? Colors.grey[200] : Colors.white;

          return Container(
            color: backgroundColor, // Set the background color
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/petrol.png',
                  width: 15,
                  height: 15,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productTitle, // Use the product title here
                    style: displayTitle,
                  ),
                  Text(
                    'Kes 50,000',
                    style: displayTitle,
                  )
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current price:',
                        style: bodyText,
                      ),
                      Text(
                        '1000 litres ${productTitle.toLowerCase()}', // Use the product title here
                        style: bodyTextSmaller,
                      ),
                      Text(
                        'Commission generated',
                        style: bodyTextSmaller,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kes 200',
                        style: bodyText,
                      ),
                      Text(
                        '12 Sept 2023',
                        style: displaySmallerLightGrey,
                      ),
                      Text(
                        'Kes 5000',
                        style: displaySmallerLightGrey,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount:
            productTitles.length, // Use the length of the productTitles list
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          // Remove the height property to allow the modal to take the height of its content
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Set Commison Rates for users',
                style: m_title,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.monetization_on,
                      color: primaryDarkColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Oil Marketing Companies to Resellers',
                    style: bodyText,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter value',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryDarkColor.withOpacity(0.1),
                        width: 0.5,
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.monetization_on,
                      color: primaryDarkColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Resellers to Customers',
                    style: bodyText,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter value',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryDarkColor.withOpacity(0.1),
                        width: 0.5,
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.monetization_on,
                      color: primaryDarkColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Oil Marketing Companies to Customers',
                    style: bodyText,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter value',
                    labelStyle: bodyTextSmall.copyWith(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryDarkColor.withOpacity(0.1),
                        width: 0.5,
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    child: const Text('Confirm'),
                  )),
            ],
          ),
        ),
      );
    },
  );
}




 







//     Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: 10), // Adjust horizontal padding
//         child: Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               side: BorderSide(
//                 color: primaryDarkColor.withOpacity(0.1),
//                 width: 1.0,
//               ),
//             ),
//             child: Column(children: [
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Icon(
//                   Icons.assignment,
//                   size: 48.0,
//                   color: primaryDarkColor,
//                 ),
//               ),
//               Text(
//                 userName,
//                 style: displayTitle,
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Text('Proforma Invoice ',
//                     //'Amount: $amount',
//                     style: displayTitle),
//                 Text(
//                   '#20001',
//                   style: bodyText,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(date, style: bodyText),
//                     StatusContainer(
//                       color: Colors.green,
//                       text: 'Pending',
//                     ),
//                   ],
//                 ),
//               ]),
//             ])));
//   }
// }

// class StatusContainer extends StatelessWidget {
//   final Color color;
//   final String text;
//   final Color? fadedColor;

//   StatusContainer({
//     required this.color,
//     required this.text,
//     this.fadedColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.greenAccent.withOpacity(0.1),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8.0),
//             bottomRight: Radius.circular(8.0),
//           ),
//           border: Border.all(color: Colors.greenAccent)),
//       padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//       child: Text(
//         text,
//         style: TextStyle(color: Colors.greenAccent),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:petropal/constants/color_contants.dart';
// // import 'package:petropal/constants/theme.dart';

// // class TransactionCard extends StatelessWidget {
// //   const TransactionCard({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Column(
// //         children: [
// //           Icon(
// //             Icons.assignment,
// //           ),
// //           Row(children: [
// //             Text(
// //               'Proforma Invoice #20001',
// //               style: displayTitle,
// //             ),
// //             Text('Kes 500,000')
// //           ]),
// //           Row(children: [
// //             Text('5th September 2023: '),
// //             Container(
// //               decoration:
// //                   BoxDecoration(color: Colors.greenAccent.withOpacity(0.1)),
// //               child: Text(
// //                 'pending',
// //                 style: TextStyle(color: Colors.greenAccent),
// //               ),
// //             )
// //           ]),
// //         ],
// //       ),
// //     );
// //   }
// // }
