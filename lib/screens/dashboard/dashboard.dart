import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/dashboard/add_users/users.dart';

import 'package:petropal/screens/dashboard/all_orders.dart';
import 'package:petropal/screens/dashboard/products.dart';
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
      const ProductsScreen(),
      const AllOrders(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/home.png',
          color: primaryDarkColor,
        ),
        title: ("Home"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: primaryDarkColor.withOpacity(0.1),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/products.png',
          color: primaryDarkColor,
        ),
        title: ("Products"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: primaryDarkColor.withOpacity(0.1),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/orders.png',
          color: primaryDarkColor,
        ),
        title: ("Orders"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: primaryDarkColor.withOpacity(0.1),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/images/settings.png',
          color: primaryDarkColor,
        ),
        title: ("Settings"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: primaryDarkColor.withOpacity(0.1),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const UsersScreen())));
                    },
                    child: const Icon(
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
                    child: const Icon(
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
