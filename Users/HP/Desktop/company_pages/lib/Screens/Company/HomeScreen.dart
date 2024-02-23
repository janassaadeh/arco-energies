
import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:flutter/material.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Widgets/Home/Cash.dart';
import '../../Widgets/Home/features.dart';
import '../../Widgets/Home/recentTransaction.dart';
import '../Auth/Login.dart';

class HomeScreen extends StatelessWidget {
    AuthenticationService authenticationService=AuthenticationService();
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:18,right:18.0,top: 18),


              child: Cash(),
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
                    push(Profile(), context);
                  },
                  child: Container(
                    height: 135,width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,          
                      children: [
                        SizedBox(width: 18,),
                    Features(
                    color: const Color.fromRGBO(209, 73, 91, 1),
                    imageAsset: "assets/images/Star.png",
                    text: "Earn and Redeem Points",
                  ),
                  const SizedBox(width: 10,),
                    GestureDetector(
                      onTap:(){
                          push(MyCars(), context);
                      },
                      child: Features(
                      color: const Color.fromRGBO(237, 174, 73, 1),
                      imageAsset: "assets/images/Traffic Jam.png",
                      text: "Manage your cars.",
                                  ),
                    ),
                  const SizedBox(width: 10,),
                        
                    Features(
                    color: const Color.fromRGBO(0, 121, 140, 1),
                    imageAsset: "assets/images/Money Bag.png",
                    text: "Track your transactions.",
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
                child: Text("Recent Transactions",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 20,),
            
            Padding(
              padding: const EdgeInsets.only(left:18,right:18.0),
              child: Column(
                children: [
                  Transactions(id: "ODR20230117-5832", price: 20.00,type: "-",day:1),
                   Transactions(id: "ODR20230117-5832", price: 20.00,type: "+",day:2),
              Transactions(id: "ODR20230117-5832", price: 20.00,type: "-",day:3),
              Transactions(id: "ODR20230117-5832", price: 20.00,type: "+",day:2),
                ],
              ),
            ),
           
      
      
          ],
        ),
      );
    
  }
}
