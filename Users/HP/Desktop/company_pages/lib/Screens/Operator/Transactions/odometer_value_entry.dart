import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Screens/Operator/Transactions/liters_value_entry.dart';
import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';

class OdometerValueEntry extends StatelessWidget {
  const OdometerValueEntry({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController odometerController = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside of the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xff003D5B),
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPathPoint("  Car  ", false, true),
                    _buildPathPoint("Pump", false, true),
                    _buildPathPoint("Odometer", true, false),
                    _buildPathPoint("Liter", false, false),
                  ],
                ),
              ),
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
                      odometerController,
                    ),
                    const SizedBox(height: 20),
                    buildSecondText(
                        "Double-check the odometer reading to avoid errors."),
                    const SizedBox(height: 20),
                    nextButton(
                      "Next",
                      fn: () {
                        String odometerValue = odometerController.text;
                        if (odometerValue.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                text: "Please enter a value!",
                              );
                            },
                          );
                        } else {
                          try {
                            double.parse(odometerValue);
                            Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .setOdometerValue(odometerValue);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LitersValueEntry(),
                              ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ErrorPopUp(
                                  text: "Please enter a valid value!",
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}
