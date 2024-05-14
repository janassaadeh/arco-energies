
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
//
import 'package:company_pages/Screens/Auth/Login.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class Profile extends StatelessWidget {
  AuthenticationService authenticationService = AuthenticationService();
  dynamic operator;
  dynamic imageData;
  // dynamic cars;
  // List<dynamic>? mergeAndSorted;

  Profile({required this.operator,required this.imageData});

  @override
  Widget build(BuildContext context) {
    return (operator==null)?Container():SingleChildScrollView(
      child: Column(
        
        children: [
          SizedBox(height: 40,),

  operator.imageId==''?
         CircleAvatar(
                 backgroundColor: Color(0xffC1BEBE),
                 radius: 62,
                 child: Image.asset("assets/images/buisness_profile.png")):
  imageData != null
      ? 
      
      
      ClipOval(
          child: 
          Image.memory(
            imageData!,
            fit: BoxFit.cover,
            width: 120,
            height: 120,
          ),
        )
      : ClipOval(
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 120,
              color: Colors.white, // You can change this color to match your background
            ),
          ),
      ),
          SizedBox(height: 20,),

          Column(
            children: [
              // Figma Flutter Generator CompanynameWidget - TEXT
           
               Text(
                operator.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    height: 1),
              ),
              const SizedBox(
                height: 15,
              ),

               Text(
                '+961 ${operator.phone}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffA9A9AC),
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1),
              ),
             
              const SizedBox(
                height: 40,
              ),
              Container(
                color: Color(0xffF2F2F7),
                width: double.infinity,
                height: 53,
                child: Padding(
                  padding: const EdgeInsets.only(top:18.0,left: 22),
                  child: Text("Overview",style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 122),
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1),
                                  ),
                ),
              ),
              SizedBox(height:20),
               Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Email",style: TextStyle(
                         color: Color(0xff8B8B91),
                         fontSize: 18,
                         fontWeight: FontWeight.w500,
                         height: 1),
                                     ),
                       Text(operator.email,style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                           height: 1),
                                       ),
                   ],
                 ),
               ),
              SizedBox(height:10),

              Padding(
                padding: const EdgeInsets.only(left:14.0,right: 14),
                child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
              ),
              SizedBox(height:15),

                 Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Date Of Birth",style: TextStyle(
                         color: Color(0xff8B8B91),
                         fontSize: 18,
                         fontWeight: FontWeight.w500,
                         height: 1),
                                     ),
                       Text(operator.dob,style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                           height: 1),
                                       ),
                   ],
                 ),
               ),
              SizedBox(height:10),

              Padding(
                padding: const EdgeInsets.only(left:14.0,right: 14),
                child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
              ),
              SizedBox(height:10),

                 Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("ID",style: TextStyle(
                         color: Color(0xff8B8B91),
                         fontSize: 18,
                         fontWeight: FontWeight.w500,
                         height: 1),
                                     ),
                       Text(operator.id,style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                           height: 1),
                                       ),
                                       
                   ],
                 ),
               ),
              SizedBox(height:15),

                Padding(
                padding: const EdgeInsets.only(left:14.0,right: 14),
                child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
              ),
              SizedBox(height:15),

                 Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Address",style: TextStyle(
                         color: Color(0xff8B8B91),
                         fontSize: 18,
                         fontWeight: FontWeight.w500,
                         height: 1),
                                     ),
                       Text(operator.address,style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                           height: 1),
                                       ),
                   ],
                 ),
               ),
              SizedBox(height:20),

  

           
              SizedBox(height:5),
                Container(
                color: Color(0xffF2F2F7),
                width: double.infinity,
                height: 53,
                child: Padding(
                  padding: const EdgeInsets.only(top:18.0,left: 22),
                  child: Text("Account",style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 122),
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1),
                                  ),
                ),
              ),
              SizedBox(height:15),

                  Padding(
                 padding: const EdgeInsets.only(left: 22,right: 22),
                 child: GestureDetector(
                  // onTap: (){
                                               onTap: () async {
                          await authenticationService.logout();
                                   Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>LoginScreen()));
                        
       
                  },
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Row(children: [
                  
                      Image.asset('assets/images/logout.png',color: Colors.black,width: 30,),
                      SizedBox(width: 15,),
                        Text('Logout',style: TextStyle(
                             color: Colors.black,
                             fontSize: 18,
                             fontWeight: FontWeight.w500,
                             height: 1),
                                         ),
                      ],),
                      // Icon(Icons.arrow_forward_ios,size: 20,)
                      
                     ],
                   ),
                 ),
               ),
           
              SizedBox(height:15),
                       ],
          ),
      
        ],
      ),
    );
  }
}
