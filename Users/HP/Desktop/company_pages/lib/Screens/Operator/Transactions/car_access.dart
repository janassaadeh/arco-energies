import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Transactions/cars_list.dart';
import 'package:company_pages/Screens/Operator/Transactions/pump_selection.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarAccess extends StatelessWidget {
  const CarAccess({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchComtroller = TextEditingController();
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
              )),
          onTap: () {
            Provider.of<TransactionProvider>(context, listen: false)
                .resetTransactionValues();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff003D5B),
            padding: EdgeInsets.symmetric(vertical: screenSize.height * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPathPoint("  Car  ", true, () {}),
                // _buildPathLine(),
                _buildPathPoint("Pump", false, () {}),
                // _buildPathLine(),
                _buildPathPoint("Odometer", false, () {}),
                // _buildPathLine(),
                _buildPathPoint("Liter", false, () {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    buildTitleWidget("Tap NFC Card", "1"),
                    const SizedBox(height: 10),
                    buildText('Tap the NFC tag on the car with your device.'),
                    const SizedBox(height: 20),
                    _buildGifImage('assets/images/nfc gif.gif', context),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarsList(),
                          ),
                        );
                      },
                      child: buildInput(
                        '  Search...',
                        Image.asset(
                          "assets/images/Search.png",
                          width: 25,
                        ),
                        true,
                        searchComtroller,
                        isPressable: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildSecondText(
                        "Automatically fill this field upon NFC tag scan. Manually search for issues if encountered."),
                    const SizedBox(height: 20),
                    nextButton(
                      "Next",
                      fn: () {
                        if (Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .selectedVehicleId ==
                            "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                text: "Make sure you have selected a car!",
                              );
                            },
                          );
                        } else {
                          push(const PumpSelection(), context);
                        }
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

  Widget _buildGifImage(String imagePath, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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

  Widget _buildPathPoint(
      String name, bool isActive, void Function() dotDestination) {
    return Column(
      children: [
        GestureDetector(
          onTap: dotDestination,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: isActive ? Colors.white : Colors.transparent,
            ),
          ),
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
