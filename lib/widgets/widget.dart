import 'package:flutter/material.dart';

class CustomTransactionCard extends StatelessWidget {
  final String userName;
  final String amount;
  final String paymentMethod;
  final String date;
  final String volume;

  CustomTransactionCard({
    required this.userName,
    required this.amount,
    required this.paymentMethod,
    required this.date,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 4.0,
        color: Colors.white, // Set background color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Colors
                .green, // Border color is green (you can change it to primaryDark color)
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.assignment, // Replace with your invoice icon
                size: 48.0,
                color: Colors.green, // Icon color
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              'Amount: $amount',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Volume: $volume',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          paymentMethod,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container with alternating status containers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StatusContainer(
                        color: Colors.green, // Green color
                        text: 'Green Text',
                      ),
                      StatusContainer(
                        color: Colors.red, // Red color
                        text: 'Red Text',
                        fadedColor:
                            Colors.red.withOpacity(0.5), // Faded Red color
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  final Color color;
  final String text;
  final Color? fadedColor;

  StatusContainer({
    required this.color,
    required this.text,
    this.fadedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fadedColor ?? color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
