import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/r_products.dart';
import 'package:petropal/reseller/reseller_dashboard/r_home.dart';
import 'package:petropal/reseller/reseller_dashboard/r_orders.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';

class ResellerDasboard extends StatefulWidget {
  const ResellerDasboard({Key? key}) : super(key: key);

  @override
  State<ResellerDasboard> createState() => _ResellerDasboardState();
}

class _ResellerDasboardState extends State<ResellerDasboard> {
  int _currentIndex = 0;

  List<Widget> _buildScreens() {
    return [
      const ResellerHome(),
      const ResellerProducts(),
      const ResellerOrders(),
      const ResellerProfile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: ("Home"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Products"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.list_bullet),
        title: ("Orders"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: primaryDarkColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: bottomNavigationController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
