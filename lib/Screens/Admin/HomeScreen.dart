
import 'package:company_pages/Screens/Admin/Manage%20Companies/Companies.dart';
import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Screens/Admin/qr_code.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/horizontal_gradient_box.dart';
import 'package:company_pages/Models/fuel_price.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Services/Auth/user_service.dart'as User;
import '../../Widgets/Home/Cash.dart';
import '../../Widgets/Home/features.dart';
import '../../Widgets/Home/recentTransaction.dart';
import '../Auth/Login.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart' as company;

import '../../../Screens/Admin/ManageOperators/operator_model.dart'as op;
import 'ManageOperators/operators.dart';

class AdminHomeScreen extends StatelessWidget {
  List<op.Operator> operators;
    
    List <company.Company> companies;
    dynamic admin;

    AdminHomeScreen({required this.companies,required this.admin,required this.operators});
    AuthenticationService authenticationService=AuthenticationService();
    
  @override
  Widget build(BuildContext context) {
   
        final List<FuelPrice> fuelPrices = [
      FuelPrice("Fuel 95", "Last modified: 2023-10-25", 2.50),
      FuelPrice("Fuel 98", "Last modified: 2023-10-25", 2.70),
      FuelPrice("Diesel", "Last modified: 2023-10-25", 2.20),
    ];
    
    return 
    admin==null?Container():
    SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:18,right:18.0,top: 18),


              child: horizontalGradientBox(context, admin==null?'':'Hello, ${admin.name}', "assets/images/User Shield.png"),
            ),
            const SizedBox(height: 30,),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.only(left:18,right:18.0),

              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Features",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 20,),
      
            Column(
              children: [
                GestureDetector(
                  onTap: ()async{
                    var role=await authenticationService.getRole();
                    print(role);
                    push(Operators(operators: operators), context);
                  },
                  child: Container(
                    height: 135,width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,          
                      children: [
                        SizedBox(width: 18,),
                    Features(
                    color: const Color.fromRGBO(209, 73, 91, 1),
                    imageAsset: "assets/images/Online Support.png",
                    text: "Manage Operator",
                  ),
                  const SizedBox(width: 10,),
                    GestureDetector(
                      onTap:(){
                          push(Companies(companies: companies), context);
                      },
                      child: Features(
                      color: const Color.fromRGBO(237, 174, 73, 1),
                      imageAsset: "assets/images/Budget.png",
                      text: "Manage Companies",
                                  ),
                    ),
                  const SizedBox(width: 10,),
                        
                    GestureDetector(
                      onTap:()async{
//  push(QRViewExample(),context);
       final qrText = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRViewExample()),
            );
            if(qrText!=null){
              print("qrText $qrText");
              List<String> parts = qrText.split(" ");
              RewardService rewardService=RewardService();
              rewardService.redeemReward(parts[1], parts[0]);
            }
                      },
                      child: Features(
                      color: const Color.fromRGBO(0, 121, 140, 1),
                      imageAsset: "assets/images/Qr Code.png",
                      text: "Scan QR for company rewards.",
                                      ),
                    ),
                        SizedBox(width: 18,),

                      ],
                    ),
                      
                  ),
                ),
              ],
            ),
                        const SizedBox(height: 30,),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.only(left:18,right:18.0),

              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Daily Fuel Prices",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:18.0,right:18),
              child: Container(
                height: 300,
                child: ListView.builder(
                  itemCount: fuelPrices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.water_drop,
                                  size: 24,
                                  color: fuelPrices[index].type.contains("Fuel")
                                      ? const Color.fromARGB(255, 74, 136, 76)
                                      : const Color.fromARGB(255, 204, 113, 79),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fuelPrices[index].type,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  fuelPrices[index].lastModified,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  '${fuelPrices[index].price.toStringAsFixed(2)} \$/liter',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 1, 14, 72),
                                    fontWeight: FontWeight.bold,
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
            ),
      
      
          ],
        ),
      );
    
  }
}
