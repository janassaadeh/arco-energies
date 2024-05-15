import 'dart:typed_data';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Screens/Admin/CarCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/AddCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/CarDetails.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/EditCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/edittransaction.dart';
import 'package:company_pages/Screens/Admin/dis.dart';
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



class CompanyTranscations extends StatefulWidget {
  final List<Transaction> transactions;
  final Company company;
  List <Pump> pumps;
  List <Vehicle>cars;

   CompanyTranscations({required this.transactions,required this.company,required this.cars,required this.pumps,Key? key}) : super(key: key);

  @override
  State<CompanyTranscations> createState() => _CompanyTranscationsState();
}
class _CompanyTranscationsState extends State<CompanyTranscations> with SingleTickerProviderStateMixin {
 late List<SlidableController> controllers;
 double ratio=0.3;
 String searchQuery = '';
   late List<TickerProvider> tickerProviders;
     late List <Transaction> filteredTransactions ;
    //  List<dynamic> imageDataList=[];

  @override
  void initState() {
    super.initState();
    tickerProviders = List.generate(
      widget.transactions.length,
      (index) => _TickerProvider(),
    );
    controllers = List.generate(
      widget.transactions.length,
      (index) => SlidableController(tickerProviders[index]),
    );
    filteredTransactions=filterTransaction();
    // fetchImageForFilteredCars();

  }
  
  // Future<void> fetchImageForFilteredCars() async {
  //   ImageService _apiService = ImageService();

  //   // Initialize imageDataList with null values
  //   imageDataList = List.generate(filteredCars.length, (_) => null);

  //   for (int index = 0; index < filteredCars.length; index++) {
  //     String? imageId = filteredCars[index].imageId;
  //     try {
  //        if (imageId != '') {
  //         // Fetch image data using the provided image ID
  //         Uint8List imageData = await _apiService.getImageFromId(imageId!);
  //         setState(() {
  //           // Update the imageDataList with fetched image data
  //           imageDataList[index] = imageData;

  //         });
          
          
  //   print("${index} done ");

  //       }
    
  //     } catch (e) {
  //       // Handle errors
  //       print('Failed to fetch image for company at index $index: $e');
  //     }
  //   }
  // }
  // Method to filter companies based on search query
  List<Transaction> filterTransaction() {
    return widget.transactions.where((t) {
      final id = t.id.toLowerCase();
  //       final String id;
  // final double quantity;
  // final double odometer;
  // final String date;
  // final PumpResponse pump;
  // final VehicleResponse vehicle;
  // final OperatorResponse operator;

      final quantity = t.quantity;
      final date = t.date.toLowerCase();
      final pump = t.pump.name.toLowerCase();

      final query = searchQuery.toLowerCase();
      return id.contains(query) || quantity==query || date.contains(query)|| pump.contains(query);
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
          child:  Text('${widget.company.name}\'s Transactions',style: TextStyle(
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
                            double quantity = filteredTransactions[index].quantity;
                      double fuelPrice = filteredTransactions[index].pump.fuel.fuelPrice ?? 0.0; // Default value is 0.0 if fuelPrice is null
                      double price = quantity * fuelPrice;
                      
                          
                          return Column(
                            children: [
                          Slidable(
                                     key: ValueKey(index),
                                    controller: controllers[index],
                                    endActionPane: ActionPane(
                                      extentRatio: ratio,
                                      motion: const ScrollMotion(),
                                         
                                      children: [
                                         GestureDetector(
                                          onTap: (){
                                           controllers[index].close();
                                             _showCupertinoLikeDialog(context,index,filteredTransactions);
                                             
                                          },
                                           child: Padding(
                                             padding: const EdgeInsets.only(top:0,left:22,bottom:12),
                                             child: Container(
                                              decoration: BoxDecoration(
                                              color:Colors.red,
                                              borderRadius: BorderRadius.circular(12)
                                              ),
                                              width: 88,
                                              // height: 10,
                                               child: Padding(
                                                                  padding: const EdgeInsets.only(top:12,bottom:0),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(Icons.delete, color: Colors.white,size: 20,),
                                                                      SizedBox(height: 1,),
                                                                      Text("Delete",style: TextStyle(color:Colors.white, fontSize: 14,fontWeight: FontWeight.bold),)
                                                                    ],
                                                                  ),
                                               ),
                                             ),
                                           ),
                                         ),
                                      ],
                                      
                                    ),
                                    
                                    child: GestureDetector(
                                      onTap: () async {
                                      print('h');

                                                         // Navigating to CarDetails
                                    final newCar = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditTransaction(transaction: filteredTransactions[index],pumpsObjects: widget.pumps,cars: widget.cars,)),
                                    );
                      
                                    // Handling the returned car object from CarDetails
                                    if (newCar != null) {
                                      setState(() {
                                        filteredTransactions[index] = newCar; // Update the list with the edited car object
                                      });
                                    }
                                    
                      
                                        },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom:0.0),
                                        child: Transactions(
                                          
                                                                id: filteredTransactions[index].id,
                                                                price: price,
                                                                type: "-",
                                                                day: _calculateDaysAgo(filteredTransactions[index].date),
                                                              ),
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
                      hintText: "Search Transactions ...",
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
 Future<void> _showCupertinoLikeDialog(BuildContext context, int index, List<Transaction> filteredTransactions) async {
  await showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this transaction?'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF0169AA), fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'Confirm',
              style: TextStyle(color: Color(0xFF0169AA)),
            ),
            onPressed: () async {
              try {
                ManageTransactionService transactionService = ManageTransactionService();
                // Call deleteTransaction function to delete the transaction
                await transactionService.deleteTransaction(filteredTransactions[index].id);

                // Remove the transaction from the original list
                final transactionId = filteredTransactions[index].id;
                final transactionIndex = widget.transactions.indexWhere((transaction) => transaction.id == transactionId);
                if (transactionIndex != -1) {
                  setState(() {
                    widget.transactions.removeAt(transactionIndex);
                  });
                }

                // Remove the transaction from the filtered list
                setState(() {
                  filteredTransactions.removeAt(index);
                });

                Navigator.pop(context);

                // Show a success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Transaction deleted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (error) {
                // Show an error Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete transaction: $error'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
}

class _TickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
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

String formatTransactionDate(String transactionDateString) {
  final transactionDate = DateTime.parse(transactionDateString);
  final currentDate = DateTime.now();
  final difference = currentDate.difference(transactionDate).inDays;

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

