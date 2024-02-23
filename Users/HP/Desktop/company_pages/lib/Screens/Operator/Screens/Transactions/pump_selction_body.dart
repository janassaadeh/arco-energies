
import 'package:company_pages/Screens/Operator/Screens/Transactions/odometer_value_entry.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/next_button.dart';
import '../../../../Widgets/pump_option.dart';
import '../../../../Widgets/text.dart';
import '../../../../Widgets/title.dart';


class PumpSelectionBody extends StatelessWidget {
  const PumpSelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Select Pump", "2"),
              const SizedBox(height: 10),
              buildText("Select the pump you need to use for filling."),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PumpOption(onPressed: () {}, label: "Pump 1"),
                  PumpOption(onPressed: () {}, label: "Pump 2"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PumpOption(onPressed: () {}, label: "Pump 3"),
                  PumpOption(onPressed: () {}, label: "Pump 4"),
                ],
              ),
              const SizedBox(height: 30),
              nextButton(const OdometerValueEntry(), context, "Next")
            ],
          ),
        ),
      ],
    );
  }
}
