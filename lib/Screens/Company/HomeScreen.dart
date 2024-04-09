import 'package:company_pages/Screens/Company/Cars.dart';
// import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:flutter/material.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Services/Manage Accounts/vehicle_company_service.dart';
import '../../Widgets/Home/Cash.dart';
import '../../Widgets/Home/features.dart';
import '../../Widgets/Home/recentTransaction.dart';
import '../Auth/Login.dart';

class HomeScreen extends StatelessWidget {
  AuthenticationService authenticationService = AuthenticationService();
    dynamic company;
    List <DepositReceipt> ?depositList;

  HomeScreen({super.key, this.company,  this.depositList});

  @override
  Widget build(BuildContext context) {
    return
    company==null?Container():
     SingleChildScrollView(
      child: Column(
        children: [
           Padding(
            padding: EdgeInsets.only(left: 18, right: 18.0, top: 18),
            child: Cash(cashBalance:company.balance.toString()),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            // padding: const EdgeInsets.all(18.0),
            padding: EdgeInsets.only(left: 18, right: 18.0),

            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
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
                  push(Profile(), context);
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
                      const Features(
                        color: Color.fromRGBO(209, 73, 91, 1),
                        imageAsset: "assets/images/Star.png",
                        text: "Earn and Redeem Points",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                            onTap: ()async{
                              VehicleCompanyService vehicleCompanyService=VehicleCompanyService();
                              final cars=await vehicleCompanyService.getVehiclesForCompany(company.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Cars(cars:cars,company: company,)));
                              
                            },
                        child: const Features(
                          color: Color.fromRGBO(237, 174, 73, 1),
                          imageAsset: "assets/images/Traffic Jam.png",
                          text: "Manage your cars.",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Features(
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
          const Padding(
            // padding: const EdgeInsets.all(18.0),
            padding: EdgeInsets.only(left: 18, right: 18.0),

            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
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
           Padding(
            
            padding: EdgeInsets.only(left: 18, right: 18.0),
            child: 
             Container(
  height:depositList!.length*80.0 ,
  child: depositList != null && depositList!.isNotEmpty
      ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),

          itemCount: depositList!.length,
          itemBuilder: (context, index) {
            final deposit = depositList![index];
            return Transactions(
              id: deposit.id,
              price: deposit.cashAmount,
              type: "+",
              day: _calculateDaysAgo(deposit.timestamp),
            );
          },
        )
      : Center(
          child: Container()
        ),
),

            ),
          
        ],
      ),
    );
  }
}
int _calculateDaysAgo(String transactionDateString) {
  final transactionDate = DateTime.parse(transactionDateString);
  final currentDate = DateTime.now();
  final difference = currentDate.difference(transactionDate);
  return difference.inDays;
}
