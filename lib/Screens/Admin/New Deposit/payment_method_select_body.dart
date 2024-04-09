
import 'package:company_pages/Screens/Admin/New%20Deposit/cash_value_entry.dart';
// import 'package:company_pages/Screens/Admin/New%20Deposit/input_field.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';

import '../../../Widgets/Common/CustomButton.dart';
// import '../../../Widgets/Common/j_next_button.dart';
import '../../../Widgets/Common/select.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';



class PaymentMethodEntryBody extends StatefulWidget {
  String selectedCompany;
   PaymentMethodEntryBody({required this.selectedCompany,super.key});

  @override
  State<PaymentMethodEntryBody> createState() => _PaymentMethodEntryBodyState();
}

class _PaymentMethodEntryBodyState extends State<PaymentMethodEntryBody> {
  TextEditingController _PaymentMethodController = TextEditingController();
  int selectedMethod=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              buildTitleWidget("Select Payment Method", "2"),
              const SizedBox(height: 10),
              buildText(
                  "Choose your preferred payment method from the dropdown menu."),
              const SizedBox(height: 20),
              buildImageContainer("assets/images/payment_method.png", true),
              const SizedBox(height: 30),
              GestureDetector(
                              onTap: ()async{

                                showModalBottomSheet(
                                  barrierColor: Colors.transparent,
                      
                                        context: context,
                                        builder: (BuildContext context) {
                            return Material(
                              child: SelectionList(
                                itemList: paymentMethods,
                                selectedIndex: selectedMethod,
                                onItemSelected: (index) {
                                  setState(() {
                                    selectedMethod = index;
                                    _PaymentMethodController.text=paymentMethods[selectedMethod];
                                  });
                                  Navigator.pop(context); // Close the bottom sheet
                                },
                              ),
                            );
                                        },
                                      );
                              },
                              child:buildInput(
                  "Select Payment Method",
                 Image.asset('assets/images/down.png'),
              
                  
                  true,
                  _PaymentMethodController,
                ),
              ),
              const SizedBox(height: 20),
              buildSecondText(
                  "Verify your selected payment method to ensure accuracy."),
              const SizedBox(height: 40),


               GestureDetector(
                onTap: (){
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>CashAmountValueEntry(selectedCompany: widget.selectedCompany ,selectedPaymentMethod:_PaymentMethodController.text )),
            );
                },
                child: CustomButton(buttonText: 'Next')),
            ],
          ),
        ),
      ],
    );
  }
}
List<String> paymentMethods=['Check','Cash','Credit Card'];
