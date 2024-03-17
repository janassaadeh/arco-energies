import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
import 'package:flutter/material.dart';

import '../../../Models/fuel_price.dart';
import 'package:company_pages/Models/transaction.dart';
import '../../../Widgets/Operator/next_button.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final fuelPrice = FuelPrice("Fuel 95", "Last modified: 2023-10-25", 2.50);

    final List<Transaction> transactions = [
      Transaction(
          id: "Hallab", quantity: 10, odometer: 20000, date: "2024-2-13"),
      Transaction(
          id: "Halab", date: "2024-2-13", quantity: 5.2, odometer: 20000),
      Transaction(
          id: "Hallab", date: "2024-2-13", quantity: 7.3, odometer: 20000),
      Transaction(
          id: "Bouche Sucree",
          date: "2024-2-12",
          quantity: 15.7,
          odometer: 20000),
      Transaction(
          id: "Bouche Sucree",
          date: "2024-2-12",
          quantity: 19.65,
          odometer: 20000),
      Transaction(
          id: "Cocadas", date: "2024-2-11", quantity: 8.65, odometer: 20000),
      Transaction(
          id: "Cocadas", date: "2024-2-11", quantity: 12.85, odometer: 20000),
      Transaction(
          id: "Cocadas", date: "2024-2-11", quantity: 18.5, odometer: 20000),
      Transaction(
          id: "Cocadas", date: "2024-2-11", quantity: 26.65, odometer: 20000),
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
                          "assets/images/Fullstop.png",
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
                child: nextButton(
              const CarAccess(),
              context,
              "New Transaction",
              fn: () {},
            )),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
