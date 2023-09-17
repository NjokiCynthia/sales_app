import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class CustomTransactionCard extends StatelessWidget {
  final String userName;
  final String amount;
  final String paymentMethod;
  final String date;
  final String volume;

  const CustomTransactionCard({
    super.key,
    required this.userName,
    required this.amount,
    required this.paymentMethod,
    required this.date,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryDarkColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            // Replace with your icon or image widget
            child: const Icon(Icons.attach_money, color: primaryDarkColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National Oil', style: bodyText),
                Text('#2342 | 2/10/2023', style: bodyText),
                const SizedBox(
                  height: 10,
                ),
                Text('Ngong Road', style: bodyText),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Kes 500,000',
                style: bodyText,
                // TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                child: Text(
                  'Pending',
                  style: bodyText.copyWith(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Omcs extends StatelessWidget {
  const Omcs({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(5),
        child: Divider(
          color: Colors.grey,
        ),
      ),
      separatorBuilder: ((context, index) => Card(
            elevation: 4,
            // Add elevation
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
                    width: 20,
                    height: 20,
                  ),
                ),
                title: Text(
                  'Lucy and Company',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'lucy@example.com',
                        style: TextStyle(
                          color: Colors.black, // Text color
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Today's price: Kes 100",
                        style: bodyText,
                      )
                    ],
                  ),
                )),
          )),
      itemCount: 6,
    ));
  }
}

class Resellers extends StatelessWidget {
  const Resellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(5),
        child: Divider(
          color: Colors.grey,
        ),
      ),
      separatorBuilder: ((context, index) => Card(
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
                    'assets/images/reseller.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                title: Text(
                  'Lucy and Company',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'lucy@example.com',
                        style: TextStyle(
                          color: Colors.black, // Text color
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Today's price: Kes 100",
                        style: bodyText,
                      )
                    ],
                  ),
                )),
          )),
      itemCount: 6,
    ));
  }
}

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              title: Text(
                'Lucy and Company',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'lucy@example.com',
                      style: TextStyle(
                        color: Colors.black, // Text color
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's price: Kes 100",
                          style: bodyText,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: primaryDarkColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'View details',
                                  style: bodyText,
                                )))
                      ],
                    )
                  ],
                ),
              )),
        ),
        itemCount: 6,
      ),
    );
  }
}

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => Padding(
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
                    title: Container(
                      child: Row(
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
                    ),
                    subtitle: Container(
                      child: Row(
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
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(5),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
          separatorBuilder: ((context, index) => Container(
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
                              padding:
                                  EdgeInsets.only(left: 4, right: 4, bottom: 4),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.perm_identity,
                    color: primaryDarkColor,
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: primaryDarkColor.withOpacity(0.1),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.perm_identity,
                    color: primaryDarkColor,
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: primaryDarkColor.withOpacity(0.1),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.perm_identity,
                    color: primaryDarkColor,
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                child: TextFormField(
                  style: bodyText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: primaryDarkColor.withOpacity(0.1),
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
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
