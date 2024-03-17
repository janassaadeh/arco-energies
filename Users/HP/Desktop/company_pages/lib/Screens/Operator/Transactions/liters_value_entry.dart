import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import '../../../Widgets/Operator/next_button.dart';
import '../../../Widgets/Operator/second_text.dart';
import 'package:company_pages/Screens/Operator/Transactions/receipt.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LitersValueEntry extends StatelessWidget {
  const LitersValueEntry({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController litersController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 40,
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        leading: GestureDetector(
          child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 17),
              child: Image.asset(
                "assets/images/cancel.png",
                width: 15,
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff003D5B),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPathPoint("  Car  ", false, true),
                // _buildPathLine(),
                _buildPathPoint("Pump", false, true),
                // _buildPathLine(),
                _buildPathPoint("Odometer", false, true),
                // _buildPathLine(),
                _buildPathPoint("Liter", true, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              // const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    nextButton(
                      const ReceiptPage(),
                      context,
                      "Next",
                      fn: () {
                        // Provider.of<TransactionProvider>(context, listen: false)
                        //     .setLitersValue(litersController.text);
                        String pumpId = Provider.of<TransactionProvider>(
                                context,
                                listen: false)
                            .selectedPumpId;
                        String vehicleId = Provider.of<TransactionProvider>(
                                context,
                                listen: false)
                            .selectedVehicleId;

                        double liters = double.parse(litersController.text);
                        double odometer = double.parse(
                            Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .enteredOdometerValue);

                        TransactionService().addTransaction(
                          pumpId,
                          vehicleId,
                          liters,
                          odometer,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPathPoint(String name, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: isCompleted
                ? Colors.white
                : isActive
                    ? Colors.white
                    : Colors.transparent,
          ),
          child: isCompleted
              ? Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(114, 212, 171, 1),
                      border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(25, 25)),
                    ),
                    child: Image.asset(
                      'assets/images/Done.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : null, // If not completed, don't render anything inside the circle
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPathLine() {
    return Container(
      height: 2,
      width: 20,
      color: Colors.white,
    );
  }
}
