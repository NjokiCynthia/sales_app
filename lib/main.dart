import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/reseller/authentication/login.dart';
import 'package:petropal/reseller/reseller_dashboard/r_dashboard.dart';
import 'package:petropal/screens/onboarding/intro_screens.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/providers/driver.dart';
import 'package:petropal/providers/omc_product.dart';
import 'package:petropal/providers/order.dart';
import 'package:petropal/providers/products.dart';
import 'package:petropal/providers/truck.dart';
import 'package:petropal/screens/onboarding/splash.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey[50]));

  // Check if it's the first install
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstInstall = prefs.getBool('firstInstall') ?? true;

  if (isFirstInstall) {
    // Set 'firstInstall' to false so it won't show splash screen again
    await prefs.setBool('firstInstall', false);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
        ChangeNotifierProvider<DriverProvider>.value(value: DriverProvider()),
        ChangeNotifierProvider<OmcProductProvider>.value(
            value: OmcProductProvider()),
        ChangeNotifierProvider<OrderProvider>.value(value: OrderProvider()),
        ChangeNotifierProvider<ProductProvider>.value(value: ProductProvider()),
        ChangeNotifierProvider<TruckProvider>.value(value: TruckProvider()),
      ],
      child: MyApp(isFirstInstall: isFirstInstall),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstInstall;

  const MyApp({Key? key, required this.isFirstInstall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetroPal',
      theme: MyTheme.darkTheme,
      home: isFirstInstall ? const HomePage() : _getInitialScreen(context),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _getInitialScreen(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    print('Is first install: $isFirstInstall');
    print('Is logged in: ${userProvider.isLoggedIn}');
    print('Is activated: ${userProvider.isActivated}');

    if (isFirstInstall) {
      return const SplashScreen();
    } else {
      if (userProvider.isLoggedIn && userProvider.isActivated) {
        // User is logged in and activated, navigate to the dashboard
        print('Navigating to ResellerDashboard');
        return const ResellerDashboard();
      } else {
        // User is not logged in or not activated, navigate to login
        print('Navigating to Login');
        return const Login();
      }
    }
  }
}
