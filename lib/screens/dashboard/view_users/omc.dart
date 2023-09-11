import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class User {
  final String name;
  final String email;
  final String location;
  final String imagePath;

  User(
      {required this.name,
      required this.email,
      required this.location,
      required this.imagePath});
}

class Omcs extends StatelessWidget {
  final List<User> users = [
    User(
        name: 'Rubis Energy Kenya',
        email: 'user1@example.com',
        location: 'Location 1',
        imagePath: 'assets/images/rubis.png'),
    User(
        name: 'Ola Energy',
        email: 'user2@example.com',
        location: 'Location 2',
        imagePath: 'assets/images/libya_oil.png'),
    User(
        name: 'National Oil Kenya',
        email: 'user3@example.com',
        location: 'Location 3',
        imagePath: 'assets/images/national_oil.png'),
    User(
        name: 'Shell Global',
        email: 'user4@example.com',
        location: 'Location 4',
        imagePath: 'assets/images/shell_global.png'),
    User(
        name: 'Total Energies Kenya',
        email: 'user5@example.com',
        location: 'Location 5',
        imagePath: 'assets/images/total-logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: primaryDarkColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                user.imagePath,
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
                      user.name,
                      style: displayTitle,
                    ),
                    subtitle: Text(user.email, style: bodyText),
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
                          user.location,
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
