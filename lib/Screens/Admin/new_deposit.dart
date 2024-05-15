
import 'package:company_pages/Screens/Admin/New%20Deposit/SelectCompany.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/cash_value_entry.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/payment_method_select.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/payment_method_select_body.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Models/transaction.dart';

import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:provider/provider.dart';

import '../../Provider/deposit_provider.dart';
import '../../Services/deposit_service.dart';
import '../../Widgets/Common/CustomButton.dart';
import 'package:intl/intl.dart';




class NewDeposit extends StatefulWidget {

     final List<DepositReceipt> deposits;
NewDeposit({required this.deposits});
  @override
  State<NewDeposit> createState() => _NewDepositState();
}


class _NewDepositState extends State<NewDeposit> {
  @override
  Widget build(BuildContext context) {
  // DepositProvider depositProvider= Provider.of<DepositProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: widget.deposits.length,
                itemBuilder: (context, index) {
                  widget.deposits.sort((a, b) => b.timestamp.compareTo(a.timestamp));
                  final deposit = widget.deposits[index];
                  // final total = fuelPrice.price * transaction.quantity;
                  return GestureDetector(
                                                               onTap: () {
                      print("hi");
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>(DepositDetails(receipt: deposit)),
        ));
      },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/FullStop.png",
                            width: 20,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deposit.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                formatDate(convertToLebanonTime(deposit.timestamp)).toString()
                                ,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${deposit.cashAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromRGBO(182, 34, 34, 1),
                                ),
                              ),
                    
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child:
                    GestureDetector(
                      onTap: () async {
                         final newDeposit = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectCompany()),
            );
            if (newDeposit != null) {
              setState(() {
                widget.deposits.add(newDeposit);
              });
            }
                      },
                      child:CustomButton(buttonText: 'New Deposit'),
                    )
                    
                    ),
              const SizedBox(
                height: 30,
              ),
          ],
        ),
      ),
    );
  }
}
void nthng(){
  
}

String formatDate(String dateTimeString) {
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the DateTime object to the desired format "yyyy-MM-dd"
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}