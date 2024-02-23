
import 'package:company_pages/Screens/Operator/Screens/Transactions/liters_value_entry.dart';
import 'package:company_pages/Screens/Operator/Widgets/next_button.dart';
import 'package:company_pages/Screens/Operator/Widgets/text.dart';
import 'package:company_pages/Screens/Operator/Widgets/title.dart';
import 'package:company_pages/Widgets/second_text.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/image_container.dart';
import '../../../../Widgets/input_field.dart';

class OdometerValueEntryBody extends StatefulWidget {
  const OdometerValueEntryBody({super.key});

  @override
  State<OdometerValueEntryBody> createState() => _OdometerValueEntryBodyState();
}

class _OdometerValueEntryBodyState extends State<OdometerValueEntryBody> {
  TextEditingController odometerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Enter Odometer Reading", "3"),
              const SizedBox(height: 10),
              buildText(
                  "Input the car's odometer reading into the text field."),
              const SizedBox(height: 20),
              buildImageContainer("assets/images/odometer.png", false),
              const SizedBox(height: 30),
              buildInput(
                  "Odometer Reading",
                  const Text(
                    "Kilometers (km)",
                    style: TextStyle(
                      color: Color.fromRGBO(114, 212, 171, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  true,
                  odometerController),
              const SizedBox(height: 20),
              buildSecondText(
                  "Double-check the odometer reading to avoid errors."),
              const SizedBox(height: 40),
              nextButton(const LitersValueEntry(), context, "Next")
            ],
          ),
        ),
      ],
    );
  }
}
