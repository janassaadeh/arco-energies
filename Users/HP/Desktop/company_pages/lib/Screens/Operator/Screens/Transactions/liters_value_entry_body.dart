
import 'package:company_pages/Screens/Operator/Screens/Transactions/receipt.dart';
import 'package:company_pages/Screens/Operator/Widgets/image_container.dart';
import 'package:company_pages/Screens/Operator/Widgets/input_field.dart';
import 'package:company_pages/Screens/Operator/Widgets/text.dart';
import 'package:company_pages/Screens/Operator/Widgets/title.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/next_button.dart';
import '../../../../Widgets/second_text.dart';


class LitersValueEntryBody extends StatefulWidget {
  const LitersValueEntryBody({super.key});

  @override
  State<LitersValueEntryBody> createState() => _LitersValueEntryBodyState();
}

class _LitersValueEntryBodyState extends State<LitersValueEntryBody> {
  TextEditingController litersController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Enter Fuel Quantity", "4"),
              const SizedBox(height: 10),
              buildText(
                  "Input the fuel's quantity in liters into the text field."),
              const SizedBox(height: 20),
              buildImageContainer("assets/images/drop.png", true),
              const SizedBox(height: 30),
              buildInput(
                "Fuel Quantity",
                const Text(
                  "Liters (L)",
                  style: TextStyle(
                    color: Color.fromRGBO(114, 212, 171, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                true,
                litersController,
              ),
              const SizedBox(height: 20),
              buildSecondText(
                  "Double-check the fuel quantity to ensure it is in liters to avoid errors."),
              const SizedBox(height: 40),
              nextButton(ReceiptPage(), context, "Next")
            ],
          ),
        ),
      ],
    );
  }
}
