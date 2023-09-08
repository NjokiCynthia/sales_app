import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Very light shade of grey
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 30),
                      Text(
                        'Super Admin Profile',
                        style: TextStyle(
                          fontSize: 24, // Adjust the font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                      Icon(Icons.person)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -40),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      'assets/images/icons/avatar.png'),
                                  radius: 50,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Super Admin Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10), // Adjust the spacing

                Card(
                  elevation: 4,
                  // Add elevation
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),

                    side: BorderSide(
                        color: Colors.grey[300]!), // Add a BorderSide
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.email,
                        color: primaryDarkColor,
                      ),
                    ),
                    title: const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                    subtitle: const Text(
                      'superadmin@example.com',
                      style: TextStyle(
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),

// Location Card
                Card(
                  elevation: 4, // Add elevation
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Colors.grey[300]!), // Add a BorderSide
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.location_city,
                        color: primaryDarkColor,
                      ),
                    ),
                    title: const Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                    subtitle: const Text(
                      'Admin Location',
                      style: TextStyle(
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),

// Phone Number Card
                Card(
                  elevation: 4, // Add elevation
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Colors.grey[300]!), // Add a BorderSide
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.phone,
                        color: primaryDarkColor,
                      ),
                    ),
                    title: const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                    subtitle: const Text(
                      'Super Admin Phone',
                      style: TextStyle(
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ), // To fill the remaining space
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20), // Adjust spacing from the bottom
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add your logout functionality here
                      },
                      icon: const Icon(Icons.exit_to_app, color: Colors.red),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red.withOpacity(0.8)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
