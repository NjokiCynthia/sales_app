import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class Resellers extends StatelessWidget {
  const Resellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
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
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's price: Kes 100",
                              style: bodyText,
                            ),
                            SizedBox(
                              height: 28,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('View details'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        primaryDarkColor.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
        itemCount: 6,
      ),
    );
  }
}
