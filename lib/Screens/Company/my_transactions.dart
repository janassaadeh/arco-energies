import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Screens/Company/HomeScreen.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:company_pages/Screens/Company/transaction_receipt.dart';
import 'package:company_pages/Widgets/Home/Cash.dart';
import 'package:company_pages/Widgets/Home/recentTransaction.dart';
import 'package:flutter/material.dart';

import '../../Services/deposit_service.dart';
String getType(String input) {
  if (input.startsWith("TRANSACTION")) {
    return "Transaction";
  } else if (input.startsWith("CASH")) {
    return "Cash";
  } else {
    return "Unknown";
  }
}
class AllTransactions extends StatefulWidget {
  List<dynamic>? mergedAndSorted;
  dynamic company;

  AllTransactions({Key? key, this.mergedAndSorted, required this.company})
      : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  TextEditingController searchController = TextEditingController();
  List<dynamic>? filteredTransactions;

  @override
  void initState() {
    super.initState();
    filteredTransactions = widget.mergedAndSorted;
    print(widget.mergedAndSorted!.length);
  }
List<dynamic> searchItems(String query, List<dynamic> list) {
  List<dynamic> searchResults = [];

  // Convert query to lowercase for case-insensitive search
  var queryLowerCase = query.toLowerCase();

  // Search in DepositReceipts
  for (var receipt in list) {
    if (getType(receipt.id) == 'Cash') {
      // Convert fields to lowercase for case-insensitive search
      var idLowerCase = receipt.id.toLowerCase();
      var paymentMethodLowerCase = receipt.paymentMethod.toLowerCase();
      
      if (idLowerCase.contains(queryLowerCase) ||
          paymentMethodLowerCase.contains(queryLowerCase) ||
          receipt.cashAmount.toString().contains(queryLowerCase)) {
        searchResults.add(receipt);
      }
    } else {
      var idLowerCase = receipt.id.toLowerCase();
      if (idLowerCase.contains(queryLowerCase)) {
        searchResults.add(receipt);
      }
    }
  }

  return searchResults;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: const Center(
          child: Text(
            'All Transactions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.notifications,
              size: 37,
              color:Color(0xff003D5B),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 314,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18, right: 18.0, top: 18),
child: Cash(cashBalance: widget.company.balance.toStringAsFixed(2)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recent Transactions",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 2)),
                    height: 50,
                    // padding: EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search ....',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search,
                            size: 27, color: Colors.black),

                        // suffixIcon: Icon(Icons.pr)
                      ),
                      onChanged: (value) {
          
                        setState(() {
                        // filteredTransactions = filterItems(value!);
                            filteredTransactions=searchItems(value,widget.mergedAndSorted??[]);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Expanded(
            // height: filteredTransactions!.length * 122.0,
            child: Padding(
              padding: const EdgeInsets.only(left:30,right: 30),
              child: ListView.builder(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 50), // Adjust the padding as needed

                // physics: NeverScrollableScrollPhysics(),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: filteredTransactions!.length,
                itemBuilder: (context, index) {
                  final item = filteredTransactions![index];
                  // if (getType(item.id) == 'Cash') {
      
                    return GestureDetector(

                                           onTap: () {
                      print("hi");
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>(getType(item.id) == 'Cash')? DepositDetails(receipt: item):TransactionReceipt(transaction:item)),
        );
      },
                      child: Transactions(
                        id: item.id,
                        price: (getType(item.id) == 'Cash')?item.cashAmount:item.quantity * item.pump.fuel.fuelPrice,
                        type: (getType(item.id) == 'Cash')?"+":"-",
                        day: (getType(item.id) == 'Cash')?_calculateDaysAgo(item.timestamp):_calculateDaysAgo(item.date),
                      ),
                    );
                  // } else if (getType(item.id) == 'Transaction') {
                  //   final total = item.quantity * item.pump.fuel.fuelPrice;
                  //   return GestureDetector(
                  //     onDoubleTap: (){
                  //     },
                  //     child: Transactions(
                  //       id: item.id,
                  //       price: double.parse(total.toStringAsFixed(2)),
                  //       type: "-",
                  //       day: _calculateDaysAgo2(item.date),
                  //     ),
                  //   );
                  // }
                  // return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDaysAgo(String transactionDateString) {
    final transactionDate = DateTime.parse(transactionDateString);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(transactionDate);
      if (difference == 0) {
    return "Today";
  } else if (difference == 1) {
    return "Yesterday";
  } else if (difference == 2) {
    return "The day before yesterday";
  } else {
    return "${transactionDate.day.toString().padLeft(2, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.year}";
  }
  }

  String _calculateDaysAgo2(String transactionDateString) {
    final List<String> dateParts = transactionDateString.split('-');
    final int year = int.parse(dateParts[0]);
    final int month = int.parse(dateParts[1]);
    final int day = int.parse(dateParts[2]);

    final DateTime transactionDate = DateTime(year, month, day);
    final DateTime currentDate = DateTime.now();
    final Duration difference = currentDate.difference(transactionDate);

      if (difference == 0) {
    return "Today";
  } else if (difference == 1) {
    return "Yesterday";
  } else if (difference == 2) {
    return "The day before yesterday";
  } else {
    return "${transactionDate.day.toString().padLeft(2, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.year}";
  }
  }
}
  bool _checkContains(dynamic item, String value) {
    if (item is DepositReceipt) {
      // Check if any field of DepositReceipt contains the search query
      return item.id.toLowerCase().contains(value.toLowerCase()) ||
             item.companyId.toLowerCase().contains(value.toLowerCase()) ||
             item.companyEmail.toLowerCase().contains(value.toLowerCase()) ||
             // Add more fields here as needed...
             item.timestamp.toLowerCase().contains(value.toLowerCase());
    } else if (item is Transaction) {
      // Check if any field of Transaction contains the search query
      return item.id.toLowerCase().contains(value.toLowerCase()) ||
             item.date.toLowerCase().contains(value.toLowerCase()) ||
             // Add more fields here as needed...
             item.vehicle.toString().toLowerCase().contains(value.toLowerCase());
    }
    return false;
  }