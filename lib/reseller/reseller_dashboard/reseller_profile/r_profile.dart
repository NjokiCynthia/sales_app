import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/authentication/signup.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/bank_account_details.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/change_pass.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/contact_details.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/organisation_details.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/organisation_profile.dart';
import 'package:petropal/widgets/widget.dart';

class ResellerProfile extends StatefulWidget {
  const ResellerProfile({Key? key}) : super(key: key);

  @override
  State<ResellerProfile> createState() => _ResellerProfileState();
}

class _ResellerProfileState extends State<ResellerProfile> {
  // Function to show the logout confirmation dialog.
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: primaryDarkColor.withOpacity(0.5)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Signup())));

                //Navigator.of(context).pop();
              },
              child: Text(
                'Confirm',
                style: TextStyle(color: primaryDarkColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey[50] // Set the desired color
        ));
    return Scaffold(
      backgroundColor: Colors.grey[50], // Very light shade of grey
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/icons/avatar.png'),
                        radius: 20,
                      ),
                      Text(
                        'Settings and more',
                        style: m_title,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/icons/avatar.png'),
                      radius: 20,
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        'Digital Vision Resellers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'reseller@example.com',
                        style: TextStyle(
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                        screen: OrganisationDetails());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
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
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Organisation Details', style: bodyGrey),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('Essential organisation information',
                            style: greyT),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ), // Adjust the spacing

                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: BankAccountDetails(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.account_balance,
                            color: primaryDarkColor,
                          )
                          // Image.asset(
                          //   'assets/images/bank.png',
                          //   height: 25,
                          //   width: 25,
                          //   color: primaryDarkColor,
                          // )
                          ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Bank Account Details',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('Manage your bank account information',
                            style: greyT),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: ContactDetails(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8)),
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
                      title: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Contact Details',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Stay in touch with us',
                          style: greyT,
                        ),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: OrganisationProfile(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/users.png',
                            height: 25,
                            width: 25,
                            color: primaryDarkColor,
                          )),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Organization Profile',
                          style: bodyGrey,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Customize your organization's public profile",
                          style: greyT,
                        ),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryDarkColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: ChangePassword(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.lock,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Change Password',
                          style: bodyGrey,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: primaryDarkColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context);
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
