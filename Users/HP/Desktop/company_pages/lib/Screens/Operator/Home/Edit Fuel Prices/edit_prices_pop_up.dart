//
import 'package:flutter/material.dart';

import '../../../../Models/fuel_price.dart';
import '../../../../Widgets/Operator/input_field.dart';

class EditPricesPopUp extends StatefulWidget {
  const EditPricesPopUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditPricesPopUpState();
  }
}

class _EditPricesPopUpState extends State<EditPricesPopUp> {
  TextEditingController fuel95Controller = TextEditingController();
  TextEditingController fuel98Controller = TextEditingController();
  TextEditingController dieselController = TextEditingController();

  final List<FuelPrice> fuelPrices = [
    FuelPrice("Fuel 95", "Last modified: 2023-10-25", 2.50),
    FuelPrice("Fuel 98", "Last modified: 2023-10-25", 2.70),
    FuelPrice("Diesel", "Last modified: 2023-10-25", 2.20),
  ];

  @override
  void dispose() {
    fuel95Controller.dispose();
    fuel98Controller.dispose();
    dieselController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fuel95Controller.text = fuelPrices[0].price.toString();
    fuel98Controller.text = fuelPrices[1].price.toString();
    dieselController.text = fuelPrices[2].price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSection(
              title: 'Fuel 95 Price',
              child: buildInput("Enter Fuel 95 Price", dollarText(), false,
                  fuel95Controller)),
          const SizedBox(height: 30),
          _buildSection(
              title: 'Fuel 98 Price',
              child: buildInput("Enter Fuel 98 Price", dollarText(), false,
                  fuel98Controller)),
          const SizedBox(height: 30),
          _buildSection(
              title: 'Fuel Diesel Price',
              child: buildInput(
                  "Enter Diesel Price", dollarText(), false, dieselController)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 14, 72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle saving fuel prices
                  // You can access the entered values using controllers:
                  // fuel95Controller.text, fuel98Controller.text, dieselController.text
                  // Then you can save them or perform any other action
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 14, 72),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                ),
                child:
                    const Text('Send', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 1, 14, 72),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget dollarText() {
    return const Text(
      '\$ / liter',
      style: TextStyle(
        color: Color.fromRGBO(114, 212, 171, 1),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
