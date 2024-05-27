import 'package:company_pages/Screens/Admin/New%20Deposit/deposit_receipt.dart';
import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Screens/Operator/Transactions/liters_value_entry.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
import 'package:flutter/material.dart';

import '../../../Services/deposit_service.dart';
// import '../../../Widgets/Common/j_next_button.dart';

class CashAmountValueEntryBody extends StatefulWidget {
  String selectedPaymentMethod;
  String selectedCompany;
  CashAmountValueEntryBody(
      {required this.selectedCompany,
      required this.selectedPaymentMethod,
      super.key});

  @override
  State<CashAmountValueEntryBody> createState() =>
      _CashAmountValueEntryBodyState();
}

class _CashAmountValueEntryBodyState extends State<CashAmountValueEntryBody> {
  TextEditingController cashController = TextEditingController();
  final DepositService depositService =
      DepositService(); // Instantiate DepositService
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Enter Cash Amount", "3"),
              const SizedBox(height: 2),
              buildText("Input the cash amount into the text field."),
              const SizedBox(height: 12),
              buildImageContainer("assets/images/cash_amount.png", true),
              const SizedBox(height: 8),
              // buildInput(
              //   "Cash Amount",
              //   const Text(
              //     "Dollars (\$)",
              //     style: TextStyle(
              //       color: Color.fromRGBO(114, 212, 171, 1),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   true,
              //   cashController,
              // ),
               Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromRGBO(196, 196, 196, 0.2),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
                    controller: cashController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Cash Amount',
                      border: InputBorder.none,
                    ),
                  ),
          ),
        ),
        const Text(
                  "Dollars (\$)",
                  style: TextStyle(
                    color: Color.fromRGBO(114, 212, 171, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        const SizedBox(
          width: 15,
        )
      ],
    ),
  ),
              const SizedBox(height: 5),
              buildSecondText("Double-check the cash amount to avoid errors."),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (!isLoading && cashController.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      double cashAmount = double.parse(cashController.text);
                      var id = await depositService.addCashRequest(
                        cashAmount,
                        widget.selectedCompany,
                        widget.selectedPaymentMethod,
                      );
                      print(id);
                      if (id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepositReceiptPage(id: id)),
                        );
                      } else {
                        print('Failed to add cash request. Please try again.');
                      }
                    } catch (e) {
                      print('Error occurred: $e');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ErrorPopUp(
                              text: "Please enter a valid cash amount!");
                        },
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ErrorPopUp(
                            text: "Please enter the cash amount!");
                      },
                    );
                  }
                },
                child: isLoading
                    ? Container(
                        width: 342,
                        height: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment(1.5, 1),
                            end: Alignment(-1.5, 1),
                            colors: [
                              Color.fromRGBO(0, 61, 91, 1),
                              Color.fromRGBO(2, 91, 134, 0.8999999761581421)
                            ],
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : CustomButton(buttonText: 'Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
