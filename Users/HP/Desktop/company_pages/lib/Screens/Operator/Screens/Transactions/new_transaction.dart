
import 'package:company_pages/Screens/Operator/Screens/Transactions/car_access.dart';
import 'package:flutter/material.dart';

import '../../../../Models/Operator/fuel_price.dart';
import '../../../../Models/Operator/transaction.dart';
import '../../../../Widgets/next_button.dart';

class NewTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fuelPrice = FuelPrice("Fuel 95", "Last modified: 2023-10-25", 2.50);

    final List<Transaction> transactions = [
      Transaction("Hallab", "2024-2-13", 10, 20000),
      Transaction("Halab", "2024-2-13", 5.2, 20000),
      Transaction("Hallab", "2024-2-13", 7.3, 20000),
      Transaction("Bouche Sucree", "2024-2-12", 15.7, 20000),
      Transaction("Bouche Sucree", "2024-2-12", 19.65, 20000),
      Transaction("Cocadas", "2024-2-11", 8.65, 20000),
      Transaction("Cocadas", "2024-2-11", 12.85, 20000),
      Transaction("Cocadas", "2024-2-11", 18.5, 20000),
      Transaction("Cocadas", "2024-2-11", 26.65, 20000),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final total = fuelPrice.price * transaction.quantity;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/FullStop.png",
                          width: 20,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.id,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              transaction.date,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total: \$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromRGBO(182, 34, 34, 1),
                              ),
                            ),
                            Text(
                              'Liters: ${transaction.quantity}',
                              style: const TextStyle(
                                color: Color.fromRGBO(157, 194, 132, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child:
                    nextButton(const CarAccess(), context, "New Transaction")),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
