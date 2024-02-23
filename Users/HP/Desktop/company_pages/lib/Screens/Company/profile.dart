
import 'package:company_pages/Screens/Company/Company%20Details.dart';
import 'package:company_pages/Screens/Company/CarDetails.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
// 
import 'package:flutter/material.dart';

import '../../Widgets/profile/link.dart';
import '../Auth/Login.dart';
import 'MyCars.dart';


class Profile extends StatelessWidget {
AuthenticationService authenticationService=AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return 
      

          SingleChildScrollView(
            child: Stack(clipBehavior: Clip.none,
              children: [
                
                
          
                Column(
                  children: [
                   Image.asset("assets/images/wallpaper.png"),
                    Container(
                        color: Colors.white,
                        height: 600,
                      
                      child: Column(
                        children: [
 
                         
                        ],
                      ),
                    ),
                  ],
                ),
                    Padding(
                      padding: const EdgeInsets.only(top:130.0),
                      child: Container(
                              height: 700,
                              width:double.infinity,
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                            ),
                              child: Column(children: [
                                      // Figma Flutter Generator CompanynameWidget - TEXT
                                      SizedBox(height: 80,),
      Text('Company Name', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Inter',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1
      ),),
      SizedBox(height: 15,),
            Text('name@company.com', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1
      ),),
      SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.only(right:25.0,left: 25,top:5,bottom:5),
        child: Column(
          children: [
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),

          Link(
  imagePath: "assets/images/car.png",
  buttonText: 'View All Cars',
  onTap: () {
    push(CarDetails(), context);
  },
),

            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),
Link(imagePath:"assets/images/transa.png" ,buttonText: "View All Transactions",),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),
            GestureDetector(
              onTap: (){
              push(CarDetails(), context);
                        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompanyDetails(),
          ),
        );},
  child: Link(imagePath:"assets/images/profile.png" ,buttonText: "Contact Information",)),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),

Link(imagePath:"assets/images/slider.png" ,buttonText: "Preferences",),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),
Link(imagePath:"assets/images/stat.png" ,buttonText: "Statistics",),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),
Link(imagePath:"assets/images/help.png" ,buttonText: "Help & Support",),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),

Link(imagePath:"assets/images/settings.png" ,buttonText: "Account Settings",),
            Divider(color: Color(0xff9E9C9C).withOpacity(0.7),),
GestureDetector(
  onTap: () async{
    await authenticationService.logout();
  },
  child: Link(imagePath:"assets/images/logout.png" ,buttonText: "Logout",)),

          ],
        ),
      )

                              ],),
                            ),
                            
                    ),
                    Positioned(
                      top:60,
                      right:140,
                      child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 67,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: AssetImage("assets/images/company.png"),
                      ),
                    ))
              ],
            ),
          
    );
  }
}
