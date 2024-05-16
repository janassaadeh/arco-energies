import 'dart:typed_data';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/redemption_model.dart';
import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Screens/Admin/CarCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/AddCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/CarDetails.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/EditCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/edittransaction.dart';
import 'package:company_pages/Screens/Admin/Rewards/redmp_receipt.dart';
import 'package:company_pages/Screens/Admin/dis.dart';
import 'package:company_pages/Screens/Operator/operator_bottom_nav.dart';
import 'package:company_pages/Services/Manage%20Accounts/manage%20transactions.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Widgets/Home/recentTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../Models/vehicle.dart';



class Redemption extends StatefulWidget {
  final List<RedemptionEvent> transactions;
  final dynamic operator;


   Redemption({required this.transactions,required this.operator,Key? key}) : super(key: key);

  @override
  State<Redemption> createState() => _RedemptionState();
}
class _RedemptionState extends State<Redemption> with SingleTickerProviderStateMixin {
 late List<SlidableController> controllers;
 double ratio=0.3;
 String searchQuery = '';
   late List<TickerProvider> tickerProviders;
     late List <RedemptionEvent> filteredTransactions ;
    //  List<dynamic> imageDataList=[];

  @override
  void initState() {
    super.initState();
    setState(() {
      filteredTransactions=widget.transactions;
    });
filterTransaction();

  }
  
  // Method to filter companies based on search query
  List<RedemptionEvent> filterTransaction() {
    return widget.transactions.where((t) {
      final id = t.id.toLowerCase();
  //       final String id;
  // final double quantity;
  // final double odometer;
  // final String date;
  // final PumpResponse pump;
  // final VehicleResponse vehicle;
  // final OperatorResponse operator;

      final company = t.company.name.toLowerCase();
      final reward = t.reward.name.toLowerCase();
      
      final category = t.reward.name.toLowerCase();

      final query = searchQuery.toLowerCase();
      return id.contains(query) || company==query || reward.contains(query)|| category.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('${widget.operator.name}\'s Redemptions',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.add,size:37,color: Color(0xff003D58),),
        )],
      ),
      backgroundColor: Color(0xff003D58),
body: 
          SingleChildScrollView(
           
            child: Stack(clipBehavior: Clip.none,
              children: [
                
                
          
                Column(
                  children: [
                    Container(
                      height: 120,
                      color:Color(0xff003D58)),
                    Container(
                        color: Colors.white,
                        height: 652,
                      
                      child: Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 18,top:18),
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 50), // Adjust the padding as needed

                          itemCount:filteredTransactions.length,
                          itemBuilder: (context, index) {
                   
                                         filteredTransactions
                              .sort((a, b) => b.date.compareTo(a.date));
                          
                          return Column(
                            children: [
                          GestureDetector(
                            onTap: () async {
                            print('h');

                          //                      // Navigating to CarDetails
                          // final newCar = await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => EditTransaction(transaction: filteredTransactions[index],pumpsObjects: widget.pumps,cars: widget.cars,)),
                          // );
                      
                          // // Handling the returned car object from CarDetails
                          // if (newCar != null) {
                          //   setState(() {
                          //     filteredTransactions[index] = newCar; // Update the list with the edited car object
                          //   });
                          // }
                          
                      
                              },
                            child: Padding(
                              padding: EdgeInsets.only(bottom:0.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RedemptionReceipt(receipt: filteredTransactions[index] ,)),
            );
                                },
                                child: Transactions(
                                  
                                                        id: filteredTransactions[index].id,
                                                        price: 0,
                                                        type: "/",
                                                        company: filteredTransactions[index].company.name,
                                                        day: _calculateDaysAgo(filteredTransactions[index].date.toString())),
                              ),
                                                    ),
                            ),
                          
                            ],
                          );}
                        ),
                      ),
                    ),

                  ],
                ),
                    Padding(
                      padding: const EdgeInsets.only(top:100.0),
                      child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                            ),),
                    ),
                            Padding(
                padding: const EdgeInsets.only(top:15,left:15.0,right:15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                  
                  child: TextFormField(
                    // controller: searc,
                    onChanged: (value) {
                         setState(() {
      searchQuery = value;
      filteredTransactions = filterTransaction(); // Update filteredOperators when searchQuery changes
    });
    // fetchImageForFilteredCars();
  
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Redemptions ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Icon(Icons.search, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ],
          ),
        )
    );
  }
}
void doNothing(BuildContext context) {}


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
