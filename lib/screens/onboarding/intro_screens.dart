// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/authentication/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Petropal",
          body:
              "Welcome to Petropal Oil Management System. Streamline your oil operations with our user-friendly platform. Let's get started!",
          image: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/images/icons/petropal_logo.png',
                  width: 40,
                ),
              ),
              Text(
                'Petropal',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              )
            ],
          ),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Efficient Oil Inventory and Pricing Control",
          body:
              "Effortlessly manage your oil inventory, pricing, and deliveries from anywhere. Discover the power of efficient oil management.",
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/illustrations/organize.png'),
          ),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Join Us for Streamlined Oil Management",
          body:
              "Join thousands of satisfied users who trust Petropal for their oil management needs. Sign in or create an account to experience it for yourself.",
          image: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Image.asset('assets/illustrations/invoice.png'),
          ),
          decoration: pageDecoration(),
        ),
      ],
      onDone: () {
        // Handle the done action
      },
      showSkipButton: true,
      dotsFlex: 0,
      nextFlex: 0,
// skipOrBackFlex: 0,
      skip: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.transparent,
          child: Text('Skip', style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),

      next: Padding(
        padding: EdgeInsets.only(left: 120),
        child: Icon(
          Icons.arrow_forward,
          color: primaryDarkColor,
        ),
      ),
      done: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(left: 60),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDarkColor,
            ),
            child: Text(
              'Get Started',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: primaryDarkColor,
        color: primaryDarkColor.withOpacity(0.5), // Color of inactive dots
        spacing: const EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  PageDecoration pageDecoration() {
    return PageDecoration(
      titleTextStyle: displayTitle,
      // Theme.of(context)
      //     .textTheme
      //     .headlineSmall!
      //     .copyWith(color: Colors.black),
      //Theme.of(context).textTheme.displayLarge!,
      bodyTextStyle: bodyText,
      //  Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      imagePadding: EdgeInsets.fromLTRB(0, 60, 0, 60),
      contentMargin: EdgeInsets.symmetric(horizontal: 16.0),
      safeArea: 80,
      bodyFlex: 6,
      imageFlex: 6,
    );
  }
}
