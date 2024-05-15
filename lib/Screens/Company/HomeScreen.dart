import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Company/Cars.dart';
// import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:company_pages/Screens/Company/my_transactions.dart';
// import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Widgets/image_slider.dart';
import 'package:company_pages/Widgets/images_carousel.dart';
import 'package:company_pages/Widgets/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
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

class HomeScreen extends StatelessWidget {
  AuthenticationService authenticationService = AuthenticationService();
  dynamic company;
  List<DepositReceipt>? depositList;
  List<Transaction>? transactionList;
  List<dynamic>? mergedAndSorted;

  HomeScreen(
      {super.key,
      this.company,
      this.depositList,
      this.transactionList,
      this.mergedAndSorted});

  @override
  Widget build(BuildContext context) {
// List<dynamic> mergedAndSorted=mergeAndSortLists(depositList,transactionList);

    return
        // company==null?Container():
        SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18.0, top: 20),
            child: (company == null ||
                    depositList == null ||
                    transactionList == null)
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 403.64825439453125,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            12.0), // Adjust the radius as needed
                      ),
                      // You can change this color to match your background
                    ),
                  )
                : ImageCarouselWidget(),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            // padding: const EdgeInsets.all(18.0),
            padding: EdgeInsets.only(left: 18, right: 18.0),

            child: Align(
              alignment: Alignment.centerLeft,
              child: (company == null ||
                      depositList == null ||
                      transactionList == null)
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100.64825439453125,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              12.0), // Adjust the radius as needed
                        ),
                        // You can change this color to match your background
                      ),
                    )
                  : Text(
                      "Features",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffA9A7A7),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  var role = await authenticationService.getRole();
                  print(role);
                  // push(Profile(company: company,), context);
                },
                child: SizedBox(
                  height: 135,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      (company == null ||
                              depositList == null ||
                              transactionList == null)
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : Features(
                              color: Color.fromRGBO(209, 73, 91, 1),
                              imageAsset: "assets/images/Star.png",
                              text: "Earn and Redeem Points",
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          VehicleCompanyService vehicleService =
                              VehicleCompanyService();
                          final dynamic cars = await vehicleService
                              .getVehiclesForCompany(company.id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyCars(cars: cars, company: company)));
                        },
                        child: (company == null ||
                                depositList == null ||
                                transactionList == null)
                            ? RoundedContainerWithShimmer(
                                width: 152,
                                height: 135,
                              )
                            : Features(
                                color: Color.fromRGBO(237, 174, 73, 1),
                                imageAsset: "assets/images/Traffic Jam.png",
                                text: "Manage your cars.",
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      (company == null ||
                              depositList == null ||
                              transactionList == null)
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : Features(
                              color: Color.fromRGBO(0, 121, 140, 1),
                              imageAsset: "assets/images/Money Bag.png",
                              text: "Track your transactions.",
                            ),
                      const SizedBox(
                        width: 18,
                      ),
                    ],
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
            padding: EdgeInsets.only(left: 18, right: 18.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (company == null ||
                        depositList == null ||
                        transactionList == null)
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
                                    mergedAndSorted: mergedAndSorted,
                                    company: company,
                                  )));
                    },
                    child: (company == null ||
                            depositList == null ||
                            transactionList == null)
                        ? RoundedContainerWithShimmer(
                            width: 50,
                            height: 10,
                          )
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
              padding: EdgeInsets.only(left: 18, right: 18.0),
              child: (company == null ||
                      depositList == null ||
                      transactionList == null ||
                      mergedAndSorted == [])
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundedContainerWithShimmer(
                              width: 150,
                              height: 10,
                            ),
                            RoundedContainerWithShimmer(
                              width: 150,
                              height: 10,
                            ),
                          ],
                        ),
                        RoundedContainerWithShimmer(
                          width: 150,
                          height: 10,
                        ),
                      ],
                    )
                  : Container(
                      height: mergedAndSorted!.length *
                          100.0, // Adjust the height as needed
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom +
                                50), // Adjust the padding as needed

                        physics: NeverScrollableScrollPhysics(),
                        // itemCount: mergedAndSorted!.length,
                        itemCount: mergedAndSorted!.length > 3
                            ? 3
                            : mergedAndSorted!.length,

                        itemBuilder: (context, index) {
                          final item = mergedAndSorted![index];
                          if (getType(item.id) == 'Cash') {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transactions(
                                  id: item.id,
                                  price: item.cashAmount,
                                  type: "+",
                                  day: _calculateDaysAgo(item.timestamp),
                                ),
                              ],
                            );
                          } else if (getType(item.id) == 'Transaction') {
                            // Render transaction UI
                            final total =
                                item.quantity * item.pump.fuel.fuelPrice;
                            return Transactions(
                              id: item.id,
                              price: double.parse(total.toStringAsFixed(2)),
                              type: "-",
                              day: _calculateDaysAgo(item.date),
                            );
                          }
                          return Container(); // Default case
                        },
                      ),
                    )),
        ],
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
