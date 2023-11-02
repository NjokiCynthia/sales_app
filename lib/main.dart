import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/reseller/authentication/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/providers/user_provider.dart';
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
      title: 'Petropal',
      theme: MyTheme.darkTheme,
      home: isFirstInstall
          ? SplashScreen()
          : Signup(), // Show SignUp if not the first install
      debugShowCheckedModeBanner: false,
    );
  }
}
