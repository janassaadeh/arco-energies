
import 'package:company_pages/Screens/Admin/New%20Deposit/deposit_receipt.dart';
import 'package:company_pages/Widgets/Common/CustomButton.dart';
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
   CashAmountValueEntryBody({required this.selectedCompany,required this.selectedPaymentMethod,super.key});

  @override
  State<CashAmountValueEntryBody> createState() => _CashAmountValueEntryBodyState();
}

class _CashAmountValueEntryBodyState extends State<CashAmountValueEntryBody> {
  TextEditingController cashController = TextEditingController();
   final DepositService depositService = DepositService(); // Instantiate DepositService

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Enter Cash Amount", "3"),
              const SizedBox(height: 10),
              buildText(
                  "Input the cash amount into the text field."),
              const SizedBox(height: 20),
              buildImageContainer("assets/images/cash_amount.png", true),
              const SizedBox(height: 30),
              buildInput(
                "Cash Amount",
                const Text(
                  "Dollars (\$)",
                  style: TextStyle(
                    color: Color.fromRGBO(114, 212, 171, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                true,
                cashController,
              ),
              const SizedBox(height: 20),
              buildSecondText(
                  "Double-check the cash amount to avoid errors."),
              const SizedBox(height: 40),

  GestureDetector(
                onTap:  () async {
  try {
    var id = await depositService.addCashRequest(
      double.parse(cashController.text),
      widget.selectedCompany,
      widget.selectedPaymentMethod,
    );
    print(id);

    // Ensure that the ID is valid before attempting to fetch the receipt
    if (id != null) {
      // Fetch the deposit receipt
     

      // After successfully fetching the deposit receipt, navigate to the DepositReceiptPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DepositReceiptPage(id: id)),
      );
    } else {
      // Handle the case where the ID is null (e.g., if adding the cash request failed)
      print('Failed to add cash request. Please try again.');
    }
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error occurred: $e');
    // Optionally, you can show an error message to the user
  }
},
                child: CustomButton(buttonText: 'Next')),
    
       


            ],
          ),
        ),
      ],
    );
    
  }
  
}
