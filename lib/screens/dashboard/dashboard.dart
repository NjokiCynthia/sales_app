import 'package:flutter/material.dart';

import 'package:petropal/constants/color_contants.dart';

import 'package:petropal/screens/dashboard/all_orders.dart';
import 'package:petropal/screens/dashboard/products.dart';
import 'package:petropal/screens/dashboard/profile.dart';
import 'package:petropal/screens/dashboard/home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ProductsScreen(),
      const AllOrders(),
      const Profile(),
    ];
  }

  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.white,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Products',
      backgroundColor: Colors.white,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Orders',
      backgroundColor: Colors.white,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
      backgroundColor: Colors.white,
    ),
  ];
  void _onNavBarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Name 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Name 2'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Name 3'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildScreens()[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryDarkColor,
        onPressed: _openBottomSheet,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blueGrey,
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          items: _navBarItems,
          currentIndex: _currentIndex,
          onTap: _onNavBarItemTapped,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
