import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/car_provider.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:company_pages/Provider/reward_provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Company/Cars.dart';
import 'package:company_pages/Screens/Company/RewardScreen.dart';
// import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:company_pages/Screens/Company/my_transactions.dart';
// import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Screens/Company/transaction_receipt.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:company_pages/Widgets/Home/Cash.dart';
import 'package:company_pages/Widgets/image_slider.dart';
import 'package:company_pages/Widgets/images_carousel.dart';
import 'package:company_pages/Widgets/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Services/Manage Accounts/vehicle_company_service.dart';

import '../../Widgets/Home/features.dart';
import '../../Widgets/Home/recentTransaction.dart';
import '../Auth/Login.dart';

String getType(String input) {
  if (input.startsWith("TRANSACTION")) {
    return "Transaction";
  } else if (input.startsWith("CASH")) {
    return "Cash";
  } else {
    return "Unknown";
  }
}

class HomeScreen extends StatefulWidget {
  dynamic company;
  List<DepositReceipt>? depositList;
  List<Transaction>? transactionList;
  List<dynamic>? mergedAndSorted;
  dynamic rewards;

  HomeScreen(
      {super.key,
      this.company,
      this.depositList,
      this.transactionList,
      this.mergedAndSorted,
      this.rewards,
    
      
      });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationService authenticationService = AuthenticationService();

  late List<dynamic> _combinedFuture;

  final TransactionService transactionService = TransactionService();

  final DepositService depositService = DepositService();

  Future<void> _refreshCombinedData() async {
    print('Refreshing combined data...');
    try {
      // Fetch new data
      await _updateCachedDeposits();
      await _updateCachedTransactions();

      List<Transaction> transactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;
      List<DepositReceipt> deposits =
          Provider.of<DepositProvider>(context, listen: false).cachedDeposits;
      // Update cached transactions and deposits

      List<dynamic> combinedList = [...transactions, ...deposits];
      combinedList.sort((a, b) {
        DateTime aDate = a is Transaction
            ? DateTime.parse(a.date)
            : DateTime.parse(a.timestamp);
        DateTime bDate = b is Transaction
            ? DateTime.parse(b.date)
            : DateTime.parse(b.timestamp);
        return bDate.compareTo(aDate);
      });
      setState(() {
        widget.mergedAndSorted = combinedList;
      });
      print('Data refreshed successfully');
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }

  Future<void> _updateCachedTransactions() async {
    try {
      final List<Transaction> transactions =
          await transactionService.getTransactions();

      // Filter the transactions by operatorId
      final filteredTransactions = transactions
        .where((transaction) => transaction.vehicle.company.id == widget.company.id)
          .toList();
      Provider.of<TransactionProvider>(context, listen: false)
          .cachedTransactions = transactions;
    } catch (e) {
      print('Error updating cached transactions: $e');
    }
  }

  Future<void> _updateCachedDeposits() async {
    try {
      // List<DepositReceipt> deposits = newData.whereType<DepositReceipt>().toList();
      final List<DepositReceipt> deposits = await depositService
              .getCashAdditionEventsByCompanyId(widget.company.id);

      Provider.of<DepositProvider>(context, listen: false).cachedDeposits =
          deposits;
    } catch (e) {
      print('Error updating cached deposits: $e');
    }
  }

Future<void> _refreshData(BuildContext context) async {
  final companyProvider = Provider.of<CompanyProvider>(context, listen: false);
  final carProvider = Provider.of<CarProvider>(context, listen: false);
  final rewardProvider = Provider.of<RewardProvider>(context, listen: false);

  CompanyService companyService = CompanyService();
  Company newCompany = await companyService.getCompanyById(widget.company.id);
  companyProvider.setCompany(newCompany);

  VehicleCompanyService vehicleService = VehicleCompanyService();
  final dynamic carsList = await vehicleService.getVehiclesForCompany(widget.company.id);
  carProvider.setCarList(carsList);

  RewardService rewardService = RewardService();
  List<Reward> rewardsList = await rewardService.getAllRewards();
  rewardProvider.setRewardList(rewardsList);
  _refreshCombinedData();
}

  @override
  Widget build(BuildContext context) {
// List<dynamic> mergedAndSorted=mergeAndSortLists(depositList,transactionList);
 CompanyProvider companyProvider =
          Provider.of<CompanyProvider>(context);
 CarProvider carProvider =
          Provider.of<CarProvider>(context);
   RewardProvider rewardProvider =
          Provider.of<RewardProvider>(context);
    return
        // company==null?Container():
        SingleChildScrollView(
      child:       RefreshIndicator(
                          onRefresh: () async {
                            await _refreshData(context);
                          },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18.0, top: 20),
              child: (widget.company == null ||
                      widget.depositList == null ||
                      widget.transactionList == null
                         ||widget.mergedAndSorted!.isEmpty
                      )
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 403.64825439453125,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              12.0), // Adjust the radius as needed
                        ),
                        // You can change this color to match your background
                      ),
                    )
                  : 
                  Cash(cashBalance: companyProvider.company!.balance)
                  // ImageCarouselWidget(),
            ),
            const SizedBox(
              height: 30,
            ),
            // Padding(
            //   // padding: const EdgeInsets.all(18.0),
            //   padding: EdgeInsets.only(left: 18, right: 18.0),
      
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: (company == null ||
            //             depositList == null ||
            //             transactionList == null
            //                ||mergedAndSorted!.isEmpty
            //             )
            //         ? Shimmer.fromColors(
            //             baseColor: Colors.grey[300]!,
            //             highlightColor: Colors.grey[100]!,
            //             child: Container(
            //               width: 100.64825439453125,
            //               height: 20,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(
            //                     12.0), // Adjust the radius as needed
            //               ),
            //               // You can change this color to match your background
            //             ),
            //           )
            //         : Text(
            //             "Features",
            //             style: TextStyle(
            //               fontSize: 18,
            //               color: Color(0xffA9A7A7),
            //             ),
            //           ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    var role = await authenticationService.getRole();
                    print(role);
                    // push(Profile(company: company,), context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20),
                    child: Container(
                              height: MediaQuery.sizeOf(context).height*0.2,
                              width: MediaQuery.sizeOf(context).width*0.9,
                              child: GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns in the grid
                              crossAxisSpacing: 35.0, // Spacing between columns
                              mainAxisSpacing: 35.0, // Spacing between rows
                            ),  
                        children: [
                          // const SizedBox(
                          //   width: 18,
                          // ),
                         
                          GestureDetector(
                            onTap: () async {
                              VehicleCompanyService vehicleService =
                                  VehicleCompanyService();
                              final dynamic cars = await vehicleService
                                  .getVehiclesForCompany(widget.company.id);
                  
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyCars(cars: carProvider.carList, company: companyProvider.company)));
                            },
                            child: (widget.company == null ||
                                    widget.depositList == null ||
                                    widget.transactionList == null
                                       ||widget.mergedAndSorted!.isEmpty
                                    )
                                ? RoundedContainerWithShimmer(
                                    width: 152,
                                    height: 135,
                                  )
                                : Features(
                                    color: Color.fromRGBO(237, 174, 73, 1),
                                    imageAsset: "assets/images/Traffic Jam.png",
                                    text: "View your cars",
                                  ),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          
                          // (company == null ||
                          //         depositList == null ||
                          //         transactionList == null
                          //            ||mergedAndSorted!.isEmpty
                          //         )
                          //     ? RoundedContainerWithShimmer(
                          //         width: 152,
                          //         height: 135,
                          //       )
                          //     : GestureDetector(
                          //         onTap: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => AllTransactions(
                          //                         mergedAndSorted: mergedAndSorted,
                          //                         company: company,
                          //                       )));
                          //         },
                          //         child: Features(
                          //           color: Color.fromRGBO(0, 121, 140, 1),
                          //           imageAsset: "assets/images/Money Bag.png",
                          //           text: "Track your transactions",
                          //         ),
                          //       ),
                          //         const SizedBox(
                          //   width: 10,
                          // ),
                                 (widget.company == null ||
                                  widget.depositList == null ||
                                  widget.transactionList == null
                                     ||widget.mergedAndSorted!.isEmpty
                                  )
                              ? RoundedContainerWithShimmer(
                                  width: 152,
                                  height: 135,
                                )
                              : GestureDetector(
                                onTap: (){
                              
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RewardScreen(
                                        rewards:rewardProvider.rewardList,
                                        company: companyProvider.company,
                                      )));         
                                },
                                child: Features(
                                    color: Color.fromRGBO(209, 73, 91, 1),
                                    imageAsset: "assets/images/Star.png",
                                    text: "Earn and Redeem Points",
                                  ),
                              ),
                        
                          // const SizedBox(
                          //   width: 18,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: EdgeInsets.only(left: 28, right: 28.0),
      
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.company == null ||
                  
                          widget.depositList == null ||
                          widget.transactionList == null
                             ||widget.mergedAndSorted!.isEmpty)
                      ? RoundedContainerWithShimmer(
                          width: 100,
                          height: 20,
                        )
                      : Text(
                          "Recent Transactions",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffA9A7A7),
                          ),
                        ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllTransactions(
                                      mergedAndSorted: widget.mergedAndSorted,
                                      company: widget.company,
                                    )));
                      },
                      child: (widget.company == null ||
                              widget.depositList == null ||
                              widget.transactionList == null
                                 ||widget.mergedAndSorted!.isEmpty
                              )
                          ? Container()
                          : Text(
                              "View all",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff003D58),
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20.0),
                child: (widget.company == null ||
                              widget.depositList == null ||
                              widget.transactionList == null
                              ||widget.mergedAndSorted!.isEmpty
                              )
                                                        // widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
          ? Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 403.64825439453125,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          // You can change this color to match your background
                        ),
                      ),
              )
              ,SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 403.64825439453125,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          // You can change this color to match your background
                        ),
                )),
                SizedBox(height: 10,),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 403.64825439453125,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          // You can change this color to match your background
                        ),
                      ),),
                        SizedBox(height: 10,),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 403.64825439453125,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          // You can change this color to match your background
                        ),
                      ),)
      
            ],
          )
                  
          
                          : Padding(
                            padding: const EdgeInsets.only(left:10.0,right: 10),
                            child: Container(
                                                height: 300.0, // Adjust the height as needed
                                                child: ListView.builder(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).padding.bottom +
                                    50), // Adjust the padding as needed
                          
                            physics: NeverScrollableScrollPhysics(),
                            // itemCount: mergedAndSorted!.length,
                            itemCount: widget.mergedAndSorted!.length > 5
                                ? 5
                                : widget.mergedAndSorted!.length,
                          
                            itemBuilder: (context, index) {
                              final item = widget.mergedAndSorted![index];
                              if (getType(item.id) == 'Cash') {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>(getType(item.id) == 'Cash')? DepositDetails(receipt: item):TransactionReceipt(transaction:item)),
                                  );
                                
                                      },
                                      child: Transactions(
                                        id: item.id,
                                        price: item.cashAmount,
                                        type: "+",
                                        day: _calculateDaysAgo(
                                            convertToLebanonTime(item.timestamp)),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (getType(item.id) == 'Transaction') {
                                // Render transaction UI
                                final total =
                                    item.quantity * item.pump.fuel.fuelPrice;
                                return GestureDetector(
                                  onTap: (){
                                      Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>(getType(item.id) == 'Cash')? DepositDetails(receipt: item):TransactionReceipt(transaction:item)),
                                  );
                                
                                  },
                                  child: Transactions(
                                    id: item.id,
                                    price: double.parse(total.toStringAsFixed(2)),
                                    type: "-",
                                    day: _calculateDaysAgo(item.date),
                                  ),
                                );
                              }
                              return Container(); // Default case
                            },
                                                ),
                                              ),
                          )),
          ],
        ),
      ),
    );
  }
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
