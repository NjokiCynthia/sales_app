import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/users.dart';
import 'package:petropal/screens/dashboard/invoices.dart';
import 'package:petropal/screens/dashboard/profile.dart';
import 'package:petropal/screens/dashboard/home.dart';
import 'package:petropal/widgets/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PersistentTabController? _bottomNavigationController;

  @override
  void initState() {
    super.initState();
    // Initialize the PersistentTabController
    _bottomNavigationController = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const DashboardScreen(),
      const Invoices(),
      const UsersScreen(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.assignment),
        title: ("Products"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people),
        title: ("Orders"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Settings"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _bottomNavigationController,
            screens: _buildScreens(),
            items: _navBarsItems(),
            // ... other properties for PersistentTabView
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0, right: 16.0),
              child: SpeedDial(
                backgroundColor: primaryDarkColor.withOpacity(0.6),
                animatedIcon: AnimatedIcons.menu_close,
                children: [
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.people,
                      color: primaryDarkColor,
                    ),
                    label: 'Users',
                    labelBackgroundColor: Colors.white,
                    labelStyle: bodyText.copyWith(color: primaryDarkColor),
                  ),
                  SpeedDialChild(
                    backgroundColor: Colors.white,
                    onTap: () {
                      showCustomBottomSheet(context);
                    },
                    child: Icon(
                      Icons.money_off_csred_sharp,
                      color: primaryDarkColor,
                    ),
                    label: 'Commission rates',
                    labelBackgroundColor: Colors.white,
                    labelStyle: bodyText.copyWith(color: primaryDarkColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
