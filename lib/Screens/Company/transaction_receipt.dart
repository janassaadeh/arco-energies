import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionReceipt extends StatelessWidget {
  dynamic transaction;
   TransactionReceipt({this.transaction,super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double receiptMaxWidth = screenSize.width;
    double receiptMaxHeight = screenSize.height - 140;

    Widget receiptDetailPositioned(
        double top, String leftTxt, String rightTxt) {
      return Positioned(
        top: receiptMaxHeight * top,
        left: 0,
        right: 0,
        child: receiptDetail(leftTxt, rightTxt),
      );
    }

    Widget receiptDivider(double top) {
      return Positioned(
        top: receiptMaxHeight * top,
        left: 0,
        right: 0,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Divider(),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  'Receipt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/receipt.png',
                  width: receiptMaxWidth,
                  height: receiptMaxHeight,
                ),
                Positioned(
                  top: receiptMaxHeight * 0.12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logoBlue.png",
                            width: 30,
                          ),
                          Text(
                            'rco Energies',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: receiptMaxHeight * 0.18,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Wed, May 27, 2020 • 9:27:53 AM',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoMono(
                      textStyle: const TextStyle(
                        fontFamily: 'Roboto Mono',
                        fontSize: 12,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                receiptDetailPositioned(
                    0.26, "Fuel Type", transaction!.pump.fuel.type),
                receiptDetailPositioned(
                    0.285, "Quantity", "${transaction.quantity} Liters"),
                receiptDetailPositioned(.31, "Price Per Unit",
                    "${transaction.pump.currency} ${transaction.pump.fuel.fuelPrice} Liter"),
                receiptDivider(.335),
                receiptDetailPositioned(
                    0.36, "Driver Name", transaction.vehicle.driverName),
                receiptDetailPositioned(
                    0.385, "Company Name", transaction.vehicle.company.name),
                receiptDetailPositioned(.41, "Company Address",
                    transaction.vehicle.company.location),
                receiptDivider(.445),
                receiptDetailPositioned(
                    .47, "Odometer Number", transaction.odometer.toString()),
                receiptDivider(.495),
                receiptDetailPositioned(.52, "Amount",
                    "${transaction.pump.currency} ${transaction.quantity * transaction.pump.fuel.fuelPrice}"),
                // receiptDetailPositioned(.545, "Tax", "\$ 13.88"),
                receiptDetailPositioned(.57, "Total",
                    "${transaction.pump.currency} ${transaction.quantity * transaction.pump.fuel.fuelPrice}"),
                receiptDivider(.595),
                receiptDetailPositioned(.62, "Operator", "Achraf Samir"),
                Positioned(
                  top: receiptMaxHeight * .645,
                  left: 0,
                  right: 0,
                  child: Image.asset("assets/images/code.png"),
                ),
              ],
            ),
          ),
          SizedBox(height:110)
        
        ],
      ),
    );
  }

  Widget receiptDetail(String leftTxt, String rightTxt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text(
            leftTxt,
            textAlign: TextAlign.left,
            style: GoogleFonts.robotoMono(
              textStyle: const TextStyle(
                color: Color.fromRGBO(109, 114, 120, 1),
                fontSize: 11,
                letterSpacing: 0.45,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            rightTxt,
            textAlign: TextAlign.right,
            style: GoogleFonts.robotoMono(
              textStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Roboto Mono',
                fontSize: 11,
                letterSpacing: 0.45,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
