
import 'package:company_pages/Screens/Admin/New%20Deposit/cash_value_entry_body.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/image_container.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Screens/Operator/Transactions/liters_value_entry.dart';
import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Widgets/Operator/second_text.dart';
class CashAmountValueEntry extends StatelessWidget {
  String selectedPaymentMethod;
  String selectedCompany;
   CashAmountValueEntry({required this.selectedCompany,required this.selectedPaymentMethod,super.key});

  @override
  Widget build(BuildContext context) {
    return     WillPopScope(
        onWillPop: () async {
          // Prevent back button press
          return false;
        },
            child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New Deposit',
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
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xff003D5B),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPathPoint("  Company  ", true, true),
                        // _buildPathLine(),
                        _buildPathPoint("Payment Method", true, true),
                        // _buildPathLine(),
                        _buildPathPoint("Cash Amount", true, false),
                        // _buildPathLine(),
                      ],
                      
                    ),
                                        Positioned(
                          left:85,
                          top:10,
                          child: _buildPathLine(103,true)),
                          Positioned(
                          left:210,
                          top:10,
                          child: _buildPathLine(110,true)),
            
                  ],
                ),
              ),
              const SizedBox(height: 20),
               CashAmountValueEntryBody(selectedCompany:selectedCompany,selectedPaymentMethod: selectedPaymentMethod,),
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
              color:!isActive?Color(0xff939393): Colors.white,
              width: 2,
            ),
            color: isCompleted
                ? Colors.white
                : 
                     Colors.transparent,
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

  Widget _buildPathLine(double width,bool isActive) {
    return Container(
      height: 2,
      width: width,
      color: !isActive?Color(0xff939393):Colors.white,
    );
  }
}
