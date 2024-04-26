import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import '../../../Widgets/Operator/next_button.dart';
import '../../../Widgets/Operator/second_text.dart';
import 'package:company_pages/Screens/Operator/Transactions/receipt.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LitersValueEntry extends StatefulWidget {
  const LitersValueEntry({Key? key}) : super(key: key);

  @override
  _LitersValueEntryState createState() => _LitersValueEntryState();
}

class _LitersValueEntryState extends State<LitersValueEntry> {
  TextEditingController litersController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
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
            ),
          ),
          onTap: () {
            Provider.of<TransactionProvider>(context, listen: false)
                .resetTransactionValues();
            if (Provider.of<TransactionProvider>(context, listen: false)
                    .isIdTriggeredByNFC >
                0) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: const Color(0xff003D5B),
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * .02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPathPoint("  Car  ", false, true),
                      _buildPathPoint("Pump", false, true),
                      _buildPathPoint("Odometer", false, true),
                      _buildPathPoint("Liter", true, false),
                    ],
                  ),
                ),
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
                      const SizedBox(height: 20),
                      _isLoading
                          ? Container(
                              width: 342,
                              height: 62,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  begin: Alignment(1.5, 1),
                                  end: Alignment(-1.5, 1),
                                  colors: [
                                    Color.fromRGBO(237, 174, 73, 0.5),
                                    Color.fromRGBO(237, 174, 73, 1),
                                    Color.fromRGBO(237, 174, 73, 0.5)
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff003D5B),
                                ),
                              ),
                            )
                          : nextButton(
                              _isLoading ? "Loading..." : "Next",
                              fn: () async {
                                if (_isLoading) return;

                                setState(() {
                                  _isLoading = true;
                                });

                                final startTime = DateTime.now();

                                await Future.delayed(
                                    const Duration(seconds: 3));

                                if (litersController.text.isEmpty) {
                                  _showErrorDialog("Please enter a value!");
                                  return;
                                }

                                final numericValue =
                                    double.tryParse(litersController.text);
                                if (numericValue == null) {
                                  _showErrorDialog(
                                      "Please enter a valid value!");
                                  return;
                                }

                                String pumpId =
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .selectedPumpId;
                                String vehicleId =
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .selectedVehicleId;
                                double liters =
                                    double.parse(litersController.text);
                                double odometer = double.parse(
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .enteredOdometerValue);
                                final String currentDate =
                                    DateTime.now().toIso8601String();
                                Provider.of<TransactionProvider>(context,
                                        listen: false)
                                    .resetTransactionValues();
                                Future<Transaction> generatedTransaction =
                                    TransactionService().addTransaction(
                                  pumpId,
                                  vehicleId,
                                  liters,
                                  odometer,
                                  currentDate,
                                );
                                Transaction transaction =
                                    await generatedTransaction;

                                final endTime = DateTime.now();
                                final elapsedTime = endTime
                                    .difference(startTime)
                                    .inMilliseconds;

                                // Calculate the remaining time to display the loading widget
                                final remainingTime = Duration(seconds: 3) -
                                    Duration(milliseconds: elapsedTime);

                                // Ensure the loading widget is displayed for at least 1 second
                                if (remainingTime > Duration(seconds: 1)) {
                                  await Future.delayed(
                                      Duration(milliseconds: elapsedTime));
                                }

                                _navigateToReceipt(transaction);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorPopUp(
          text: errorMessage,
        );
      },
    ).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _navigateToReceipt(Transaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(transaction: transaction),
      ),
    ).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
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
              : null,
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
}
