
import 'package:company_pages/Screens/Operator/Screens/Transactions/pump_selection.dart';
import 'package:company_pages/Screens/Operator/Widgets/title.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/input_field.dart';
import '../../../../Widgets/next_button.dart';
import '../../../../Widgets/second_text.dart';
import '../../../../Widgets/text.dart';


class CarAccessBody extends StatefulWidget {
  const CarAccessBody({super.key});

  @override
  State<CarAccessBody> createState() => _CarAccessBodyState();
}

class _CarAccessBodyState extends State<CarAccessBody> {
  TextEditingController searchComtroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Tap NFC Card", "1"),
              const SizedBox(height: 10),
              buildText('Tap the NFC tag on the car with your device.'),
              const SizedBox(height: 20),
              _buildGifImage('assets/images/nfc gif.gif'),
              const SizedBox(height: 20),
              buildInput(
                '  Search...',
                Image.asset(
                  "assets/images/Search.png",
                  width: 25,
                ),
                true,
                searchComtroller,
              ),
              const SizedBox(height: 20),
              buildSecondText(
                  "Automatically fill this field upon NFC tag scan. Manually search for issues if encountered."),
              const SizedBox(height: 30),
              nextButton(const PumpSelection(), context, "Next")
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGifImage(String imagePath) {
    return Container(
      width: 339,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        image:
            DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fitWidth),
      ),
    );
  }
}
