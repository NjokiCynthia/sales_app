// import 'package:flutter/material.dart';
// import 'package:petropal/constants/color_contants.dart';
// import 'package:petropal/constants/theme.dart';

// class Customer extends StatelessWidget {
//   const Customer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {
//           return const CustomerCard();
//         },
//       ),
//     );
//   }
// }

// class CustomerCard extends StatefulWidget {
//   const CustomerCard({super.key});

//   @override
//   State<CustomerCard> createState() => _CustomerCardState();
// }

// class _CustomerCardState extends State<CustomerCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: Card(
//         color: Colors.white,

//         //elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           side: BorderSide(
//             color: primaryDarkColor.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Image.asset(
//                 'assets/images/customer.png', // Use the same image for all cards
//                 width: 48,
//                 height: 48,
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     title: Text('Oscar Limited', style: displayTitle),
//                     subtitle: Text(
//                       'customer@example.com',
//                       style: bodyText,
//                     ),
//                     trailing: const Icon(
//                       Icons.edit,
//                       color: primaryDarkColor,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           color: primaryDarkColor.withOpacity(0.7),
//                         ),
//                         const SizedBox(width: 8.0),
//                         Text(
//                           'Location',
//                           style: TextStyle(
//                             color: primaryDarkColor.withOpacity(0.7),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
