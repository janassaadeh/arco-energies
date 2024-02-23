
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
// 
import 'package:flutter/material.dart';

import '../../../Widgets/Home/recentTransaction.dart';
import '../../../Widgets/profile/link.dart';



class CompanyDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
          Scaffold(
  appBar: AppBar(
                leading: Icon(Icons.arrow_back_ios,color: Colors.white,),

        title: Center(
          child:  Text('Company Details',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [const Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color: Colors.white),
        )],
      ),
            body: SingleChildScrollView(
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
                        padding: const EdgeInsets.only(top:170.0),
                        child: Container(
                                height: 700,
                                width:double.infinity,
                                decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                              ),
                                child: Column(children: [
                                        SizedBox(height: 90,),
                Text('Apple', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),),
                SizedBox(height: 15,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
                     
              //         Text('+961 79 123 456', textAlign: TextAlign.center, style: TextStyle(
              //         color: Color.fromRGBO(0, 0, 0, 1),
              //         fontFamily: 'Inter',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         height: 1
              //       ),),
              //         SizedBox(width: 5,),

              //         Image.asset('assets/images/dot.png'),
              //         SizedBox(width: 5,),
                  
              //     Text('jana@gmail.com', textAlign: TextAlign.center, style: TextStyle(
              //         color: Color.fromRGBO(0, 0, 0, 1),
              //         fontFamily: 'Inter',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         height: 1
              //       ),),
              //   ],
              // ),
                SizedBox(height: 10,),
                        Padding(
              padding: const EdgeInsets.only(left:18,right:18.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Company Info",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 25,),

                Container(
                  width: 378,
                  height: 312,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffC1BEBE)),
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                             Padding(
                                               padding: const EdgeInsets.all(12.0),
                                               child: Info(
                                               imagePath: 'assets/images/Hashtaglarge.png',
                                               title: 'Company ID',
                                               content: '123456789',
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                             Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/id.png',
                                               title: 'Contact Name',
                                               content: 'John Smith',
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                                                           Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/phone_blue.png',
                                               title: 'Phone Number',
                                               content: '89 123 456',
                                             ),
                                             ),
                          
                              ],),
                          ),
                            VerticalDivider(color: Color(0xffC1BEBE),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                           Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Info(
                                             imagePath: 'assets/images/Dollar Coin blue.png',
                                             title: 'Balance',
                                             content: '\$ 1000',
                                           ),
                                           ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),
                                           Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/blue pin.png',
                                             title: 'Location',
                                             content: 'Apple',
                                           ),
                                           ),
Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/Letter.png',
                                             title: 'Email',
                                             content: 'a@gmail.com',
                                           ),
                                           ),

                            ],),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:95.0),
                        child: Divider(color: Color(0xffC1BEBE),),
                      ),
                                           Padding(
                        padding: const EdgeInsets.only(top:200.0),
                        child: Divider(color: Color(0xffC1BEBE),),
                      )
                    ],
                  )
                ),
                          const SizedBox(height: 30,),
            // Padding(
            //   padding: const EdgeInsets.only(left:18,right:18.0),

            //   child: const Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text("Recent Transactions",style: TextStyle(
            //       fontSize: 18,
            //       color: Color(0xffA9A7A7),
            //     ),),
            //   ),
            // ),
            // const SizedBox(height: 20,),
            
            // Padding(
            //   padding: const EdgeInsets.only(left:18,right:18.0),
            //   child: Column(
            //     children: [
            //       Transactions(id: "ODR20230117-5832", price: 20.00,type: "-",day:1),
            //   Transactions(id: "ODR20230117-5832", price: 20.00,type: "-",day:3),
            //     ],
            //   ),
            // ),
                                ],),
                              ),
                              
                      ),
                      Positioned(
                        top:100,
                        right:140,
                        child: CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 67,
                          child: Image.asset("assets/images/buisness_profile.png"),
                        
                      ))
                ],
              ),
            
              ),
          );
  }
}
