
import 'package:company_pages/Screens/Auth/ForgotPassword.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
//
import 'package:company_pages/Screens/Auth/Login.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/profile/link.dart';

class AdminProfile extends StatelessWidget {
  AuthenticationService authenticationService = AuthenticationService();
  dynamic admin;
  dynamic imageData;
  // dynamic cars;
  // List<dynamic>? mergeAndSorted;

  AdminProfile({required this.admin,required this.imageData});

  @override
  Widget build(BuildContext context) {
    return (admin==null)?Container():SingleChildScrollView(
      child: Column(
        
        children: [
          SizedBox(height: 40,),

  admin.imageId==''?
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
                admin.name,
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
                '+961 ${admin.phone}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffA9A9AC),
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1),
              ),
              SizedBox(height: 20,),
               GestureDetector(
                    onTap: (){
                               Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>  ForgotPassword(),
                             ),
                           );
                          },
                 child: Container(
                     width: 150,
                     height: 45,
                    decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30),
                     gradient: const LinearGradient(
                  begin: Alignment(1.5, 1),
                  end: Alignment(-1.5, 1),
                       colors: [Color.fromRGBO(0, 61, 91, 1),Color.fromRGBO(2, 91, 134, 0.8999999761581421)]
                             
                     ),
                   ),
                   //                 decoration: BoxDecoration(
                   //   borderRadius: BorderRadius.circular(10),
                   //   color: const Color.fromRGBO(196, 196, 196, 0.2),
                   // ),
                     child: Padding(
                       padding: const EdgeInsets.only(left:20.0,right: 20,top: 10,bottom: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('Edit Profile',style: TextStyle(color: Colors.white,fontSize: 16),),
                           Padding(
                     padding: const EdgeInsets.only(left:8.0),
                             child: Icon(Icons.edit,color: Colors.white,size: 21,)
                           )
                         ],
                       ),
                     ),
                     ),
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
                       Text(admin.email,style: TextStyle(
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
                       Text(admin.dob,style: TextStyle(
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
                       Text(admin.id,style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w500,
                           height: 1),
                                       ),
                                       
                   ],
                 ),
               ),
          SizedBox(height: 20,),
//   Container(
//                 color: Color(0xffF2F2F7),
//                 width: double.infinity,
//                 height: 53,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top:18.0,left: 22),
//                   child: Text("Profile Details",style: TextStyle(
//                       color: Color.fromARGB(255, 117, 117, 122),
//                       fontFamily: 'Inter',
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       height: 1),
//                                   ),
//                 ),
//               ),
//  SizedBox(height:15),
//                Padding(
//                  padding: const EdgeInsets.only(left: 22,right: 22),
//                  child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                     GestureDetector(
//                       onTap:(){
//                         //  Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) =>  MyCars(cars:cars),
//                         //     ),
//                         //   );
//                       },
//                       child: Row(children: [
//                       Image.asset('assets/images/car_w.png',color: Colors.black,),
//                       SizedBox(width: 15,),
//                         Text('Cars',style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 18,
//                              fontWeight: FontWeight.w500,
//                              height: 1),
//                                          ),
//                       ],),
//                     ),
//                     Icon(Icons.arrow_forward_ios,size: 20,)
                    
//                    ],
//                  ),
//                ),
//               SizedBox(height:10),

//               Padding(
//                 padding: const EdgeInsets.only(left:14.0,right: 14),
//                 child: Divider(
//                         color: const Color(0xff8B8B91).withOpacity(0.1),
//                       ),
//               ),
//               SizedBox(height:5),
//      Padding(
//                  padding: const EdgeInsets.only(left: 22,right: 22),
//                  child: GestureDetector(
//                   onTap:(){
//         // Navigator.push(
//         //                     context,
//         //                     MaterialPageRoute(
//         //                       builder: (context) =>  AllTransactions(company: company,mergedAndSorted:mergeAndSorted,),
//         //                     ),
//         //                   );
//                   },
//                    child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                       Row(children: [
//                       Image.asset('assets/images/Dollar Coin blue.png',color: Colors.black,),
//                       SizedBox(width: 15,),
//                         Text('Transactions',style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 18,
//                              fontWeight: FontWeight.w500,
//                              height: 1),
//                                          ),
//                       ],),
//                       Icon(Icons.arrow_forward_ios,size: 20,)
                      
//                      ],
//                    ),
//                  ),
//                ),
           
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
