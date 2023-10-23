import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/reseller/reseller_dashboard/r_home.dart';
import 'package:petropal/screens/superadmin_dashboard/home.dart';
import 'package:petropal/screens/superadmin_dashboard/orders.dart';
import 'package:petropal/screens/superadmin_dashboard/products.dart';
import 'package:petropal/screens/superadmin_dashboard/profile.dart';
import 'package:petropal/screens/superadmin_dashboard/view_users/users.dart';

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
      const ProductsScreen(),
      const UsersScreen(),
      const AllOrders(),
      const Profile(),
    ];
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: [
          _buildNavBarItem(0, CupertinoIcons.home, 'Home'),
          _buildNavBarItem(1, CupertinoIcons.shopping_cart, 'Products'),
          _buildNavBarItem(2, Icons.people, 'Users'),
          _buildNavBarItem(3, CupertinoIcons.list_bullet, 'Orders'),
          _buildNavBarItem(4, CupertinoIcons.settings, 'Settings'),
        ],
        currentIndex: _currentIndex,
        onTap: _onNavBarItemTapped,
        activeColor:
            primaryDarkColor, // Icon and label color for the selected item
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _buildScreens()[index],
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      int index, IconData iconData, String label) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: label,
    );
  }
}
