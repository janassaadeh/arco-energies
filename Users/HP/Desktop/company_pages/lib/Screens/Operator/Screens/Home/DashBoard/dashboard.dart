
import 'package:flutter/material.dart';

import '../../../../../Models/Operator/fuel_price.dart';
import '../../../../../Widgets/gradient_box.dart';
import '../../../../../Widgets/horizontal_gradient_box.dart';
import '../../../Widgets/sub_title.dart';
import '../Edit Fuel Prices/edit_prices_pop_up.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FuelPrice> fuelPrices = [
      FuelPrice("Fuel 95", "Last modified: 2023-10-25", 2.50),
      FuelPrice("Fuel 98", "Last modified: 2023-10-25", 2.70),
      FuelPrice("Diesel", "Last modified: 2023-10-25", 2.20),
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          horizontalGradientBox(context, "Welcome Back\n      Ashraf",
              "assets/images/gas-pump.png"),
          const SizedBox(height: 15),
          subTitle('Features'),
          const SizedBox(height: 15),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterPopup();
                    },
                  );
                },
                child: gradientBox(
                    'Daily Fuel Prices Editing',
                    'assets/images/edit-price.png',
                    const Color.fromRGBO(72, 177, 126, 1),
                    const Color.fromRGBO(73, 209, 111, 0.6)),
              ),
              const SizedBox(width: 25),
              gradientBox(
                  'Start A New Transaction',
                  'assets/images/cars.png',
                  const Color.fromRGBO(232, 169, 69, 1),
                  const Color.fromRGBO(237, 165, 49, .6)),
            ],
          ),
          const SizedBox(height: 15),
          subTitle('Edit Prices'),
          // const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: fuelPrices.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.water_drop,
                              size: 24,
                              color: fuelPrices[index].type.contains("Fuel")
                                  ? const Color.fromARGB(255, 74, 136, 76)
                                  : const Color.fromARGB(255, 204, 113, 79),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fuelPrices[index].type,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              fuelPrices[index].lastModified,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              '${fuelPrices[index].price.toStringAsFixed(2)} \$/liter',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 1, 14, 72),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
