import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatelessWidget {
  final Transaction transaction;

  const ReceiptPage({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double receiptMaxWidth = screenSize.width;
    double receiptMaxHeight = screenSize.height - 100;

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

    String createdDate = transaction.date;
    DateTime dateTime = DateTime.parse(createdDate);

    final formattedDate = DateFormat.yMMMd().add_jms().format(dateTime);

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
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
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
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/logoBlue.png",
                                width: 30,
                              ),
                              Text(
                                'rco Energies',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
                    formattedDate,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        letterSpacing: -0.44999998807907104,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                receiptDetailPositioned(
                    0.26, "Fuel Type", transaction.pump.fuel.type),
                receiptDetailPositioned(
                    0.285, "Quantity", "${transaction.quantity} Liters"),
                receiptDetailPositioned(.31, "Price Per Unit",
                    "\$ / Liter ${transaction.pump.fuel.fuelPrice}"),
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
                    "${transaction.quantity * transaction.pump.fuel.fuelPrice!}"),
                // receiptDetailPositioned(.545, "Tax", "\$ 13.88"),
                receiptDetailPositioned(
                    .545, "Pump Currency", "${transaction.pump.currency}"),
                receiptDetailPositioned(.57, "Total",
                    "\$ ${transaction.quantity * transaction.pump.fuel.fuelPrice!}"),
                receiptDivider(.595),
                receiptDetailPositioned(
                    .62, "Operator", transaction.operator.name),
                Positioned(
                  top: receiptMaxHeight * .645,
                  left: 0,
                  right: 0,
                  child: Image.asset("assets/images/code.png"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 60.0),
          //     child: SizedBox(
          //       width: 200,
          //       height: 50,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12),
          //           gradient: const LinearGradient(
          //             begin: Alignment(1.5, 1),
          //             end: Alignment(-1.5, 1),
          //             colors: [
          //               Color.fromRGBO(237, 174, 73, 0.5),
          //               Color.fromRGBO(237, 174, 73, 1),
          //               Color.fromRGBO(237, 174, 73, 0.5)
          //             ],
          //           ),
          //         ),
          //         child: const Center(
          //           child: Text(
          //             "Print",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Color.fromRGBO(255, 255, 255, 1),
          //               fontFamily: 'Inter',
          //               fontSize: 21,
          //               letterSpacing: -0.44,
          //               fontWeight: FontWeight.normal,
          //               height: 1.0952380952380953,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
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
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
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
