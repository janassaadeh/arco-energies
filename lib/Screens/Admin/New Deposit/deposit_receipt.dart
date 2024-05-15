import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Services/deposit_service.dart';
import 'package:intl/intl.dart';

class DepositReceiptPage extends StatefulWidget {
  final String id;

  const DepositReceiptPage({required this.id, Key? key}) : super(key: key);

  @override
  _DepositReceiptPageState createState() => _DepositReceiptPageState();
}

class _DepositReceiptPageState extends State<DepositReceiptPage> {
  late final DepositService depositService;
  late Future<DepositReceipt> receiptFuture;

  @override
  void initState() {
    super.initState();
    depositService = DepositService();

    receiptFuture =
        fetchDepositReceipt(); // Initialize the future inside initState
  }

  Future<DepositReceipt> fetchDepositReceipt() async {
    try {
      final fetchedReceipt = await depositService.getDepositReceipt(widget.id);
      printDepositReceipt(fetchedReceipt);
      return DepositReceipt.fromJson(fetchedReceipt);
    } catch (e) {
      print('Error fetching deposit receipt: $e');
      throw e;
    }
  }

  String formatDateTime(String inputDateTimeString) {
    DateTime dateTime = DateTime.parse(inputDateTimeString);

    String formattedDateTimeString =
        DateFormat('EEE, MMM d, yyyy • h:mm:ss a').format(dateTime);

    return formattedDateTimeString;
  }

  @override
  Widget build(BuildContext context) {
    // DepositProvider depositProvider= Provider.of<DepositProvider>(context);

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

    return WillPopScope(
      onWillPop: () async {
        // Prevent back button press
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
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
            onTap: () async {
              final receipt = await receiptFuture;
              print(receipt.adminDob);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context, receipt);
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        body: FutureBuilder<DepositReceipt>(
            future: receiptFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                final receipt = snapshot.data!;
                // depositProvider.addDeposit(receipt);

                return Column(
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
                              formatDateTime(receipt.timestamp),
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
                              0.26, "Contact Name", receipt.companyContactName),
                          receiptDetailPositioned(
                              0.289, "Company Name", receipt.companyName),
                          receiptDetailPositioned(
                              .318, "Company Address", receipt.companyLocation),
                          receiptDivider(.364),
                          receiptDetailPositioned(
                              0.4, "Admin Name", receipt.adminName),
                          receiptDetailPositioned(
                              0.435, "Admin ID", receipt.adminId),
                          receiptDetailPositioned(
                              .466, "Admin Contact", receipt.adminPhone),
                          receiptDivider(.5),
                          receiptDetailPositioned(0.539, "Deposit Amount",
                              receipt.cashAmount.toString()),
                          receiptDetailPositioned(0.575, "Company Balance",
                              receipt.companyBalance.toString()),
                          receiptDetailPositioned(
                              .615, "Payment Method", receipt.paymentMethod),
                          receiptDivider(.65),
                          Positioned(
                            top: receiptMaxHeight * .675,
                            left: 0,
                            right: 0,
                            child: Image.asset("assets/images/code.png"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                );
              }
            }),
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
