import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class Resellers extends StatelessWidget {
  const Resellers({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ResellerCard();
        },
      ),
    );
  }
}

class ResellerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        color: Colors.white,

        //elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: primaryDarkColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/reseller.png', // Use the same image for all cards
                width: 48,
                height: 48,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Reseller Name',
                      style: displayTitle,
                    ),
                    subtitle: Text(
                      'reseller@example.com',
                      style: bodyText,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: primaryDarkColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryDarkColor.withOpacity(0.7),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Location',
                          style: TextStyle(
                            color: primaryDarkColor.withOpacity(0.7),
                          ),
                        ),
                      ],
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
