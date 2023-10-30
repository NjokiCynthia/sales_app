import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';

class MakeOrder extends StatefulWidget {
  const MakeOrder({Key? key}) : super(key: key);

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stepper(
          currentStep: currentStep,
          // connectorColor: MaterialStateProperty.resolveWith<Color>(
          //     (Set<MaterialState> states) => primaryDarkColor.withOpacity(0.7)),
          onStepTapped: (index) {
            setState(() => currentStep = index);
          },
          steps: [
            Step(
              isActive: currentStep >= 0,
              title: Text(
                'first one',
                style: bodyGrey,
              ),
              content: Text(
                'first one',
                style: bodyGrey,
              ),
            ),
            Step(
              isActive: currentStep >= 1,
              title: Text(
                'second one',
                style: bodyGrey,
              ),
              content: Text(
                'first one',
                style: bodyGrey,
              ),
            ),
            Step(
              isActive: currentStep >= 2,
              title: Text(
                'thrid one',
                style: bodyGrey,
              ),
              content: Text(
                'first one',
                style: bodyGrey,
              ),
            ),
          ]),
    ));
  }
}
