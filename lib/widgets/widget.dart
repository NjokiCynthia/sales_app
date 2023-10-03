import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/approval/approve_prices.dart';

class CustomTransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: primaryDarkColor)),
          child: Padding(
            padding: EdgeInsets.all(20),
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
                SizedBox(height: 20),
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
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primaryDarkColor)),
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

class Resellers extends StatelessWidget {
  const Resellers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),

            side: BorderSide(color: Colors.grey[300]!), // Add a BorderSide
          ),
          child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/tanker.png',
                  width: 25,
                  height: 25,
                ),
              ),
              title: const Text(
                'Lucy and Company',
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
                      'lucy@example.com',
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
                          child: const Text('View details'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  primaryDarkColor.withOpacity(0.6)),
                        )
                        // Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: primaryDarkColor),
                        //         borderRadius: BorderRadius.circular(5)),
                        //     child: Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Text(
                        //           'View details',
                        //           style: bodyText,
                        //         )))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
      itemCount: 6,
    );
  }
}

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),

            side: BorderSide(color: Colors.grey[300]!), // Add a BorderSide
          ),
          child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/customer.png',
                  width: 25,
                  height: 25,
                ),
              ),
              title: const Text(
                'Lucy and Company',
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
                      'lucy@example.com',
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
                          child: const Text('View details'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  primaryDarkColor.withOpacity(0.6)),
                        )
                        // Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: primaryDarkColor),
                        //         borderRadius: BorderRadius.circular(5)),
                        //     child: Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Text(
                        //           'View details',
                        //           style: bodyText,
                        //         )))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
      itemCount: 6,
    );
  }
}

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),

              side: BorderSide(color: Colors.grey[300]!), // Add a BorderSide
            ),
            child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: primaryDarkColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/tanker.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                title: const Text(
                  'Lucy and Company',
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
                        'lucy@example.com',
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
                            child: const Text('View details'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    primaryDarkColor.withOpacity(0.6)),
                          )
                          // Container(
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: primaryDarkColor),
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: Padding(
                          //         padding: const EdgeInsets.all(5),
                          //         child: Text(
                          //           'View details',
                          //           style: bodyText,
                          //         )))
                        ],
                      )
                    ],
                  ),
                )),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}

class Omcs extends StatelessWidget {
  const Omcs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),

            side: BorderSide(color: Colors.grey[300]!), // Add a BorderSide
          ),
          child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/fuel-station.png',
                  width: 25,
                  height: 25,
                ),
              ),
              title: const Text(
                'Lucy and Company',
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
                      'lucy@example.com',
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ApprovePricing()));
                          },
                          child: const Text('View details'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  primaryDarkColor.withOpacity(0.6)),
                        )
                        // Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: primaryDarkColor),
                        //         borderRadius: BorderRadius.circular(5)),
                        //     child: Padding(
                        //         padding: const EdgeInsets.all(5),
                        //         child: Text(
                        //           'View details',
                        //           style: bodyText,
                        //         )))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
      itemCount: 6,
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
          separatorBuilder: ((context, index) => Container(
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
                      ),
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shell Limited',
                            //textScaleFactor: 1.5,
                            style: displayTitle,
                          ),
                          Text(
                            'Kes 5000',
                            style: displayTitle,
                          )
                        ]),
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
                    )),
              )),
          itemCount: 6),
    );
  }
}

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(5),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
          separatorBuilder: ((context, index) => SizedBox(
                height: 50,
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
                      ),
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shell Limited',
                            //textScaleFactor: 1.5,
                            style: displayTitle,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                //border: Border.all(color: Colors.greenAccent),
                                color: Colors.greenAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 4),
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
                        ]),
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
                    )),
              )),
          itemCount: 5),
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
      'Diesel'
    ];

    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final productTitle = productTitles[index]; // Get the product title
          return const Padding(
            padding: EdgeInsets.all(5),
            child: Divider(
              color: Colors.grey,
            ),
          );
        },
        separatorBuilder: ((context, index) => SizedBox(
              child: ListTile(
                leading: Container(
                    decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/images/petrol.png')
                    //  const Icon(
                    //   Icons.money_off,
                    //   color: primaryDarkColor,
                    // ),
                    ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productTitles[index], // Use the product title here
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
                          '1000 litres ${productTitles[index].toLowerCase()}', // Use the product title here
                          style: bodyTextSmall,
                        ),
                        Text(
                          'Commission generated',
                          style: bodyTextSmall,
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
            )),
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
