
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/EditCar.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
// 
import 'package:flutter/material.dart';







class CarDetails extends StatefulWidget {
   Vehicle car;
  dynamic company;
  CarDetails({required this.car,required this.company});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return 
          Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
             Navigator.pop(context, widget.car); 
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Car Details',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [GestureDetector(
                   onTap:  () async {
            final newCar = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditCar(car:widget.car,company: widget.company,)),
            );
            if (newCar != widget.car) {
              setState(() {
              widget.car=newCar;
              });
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(right:8.0),
            child: Icon(Icons.edit,size:37,color: Colors.white,),
          ),
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
                Text('Company Name', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),),
                SizedBox(height: 15,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //         Container(
              //           width: 15,
              //           height: 15,
              //           decoration: BoxDecoration(
              //           color: Colors.black,
              //           shape: BoxShape.circle
              //         ),),
              //         SizedBox(width: 5,),
              //         Text('Black', textAlign: TextAlign.center, style: TextStyle(
              //         color: Color.fromRGBO(0, 0, 0, 1),
              //         fontFamily: 'Inter',
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         height: 1
              //       ),),
              //         SizedBox(width: 5,),

              //         Image.asset('assets/images/dot.png'),
              //         SizedBox(width: 5,),
                  
              //     Text('2020', textAlign: TextAlign.center, style: TextStyle(
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
                child: Text("Car Info",style: TextStyle(
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
                                               title: 'Car ID',
                                               content: '#${widget.car.id}',
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                             Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/Driver License.png',
                                               title: 'Driver Name',
                                               content: widget.car.driverName,
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                                Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/Fill Color.png',
                                               title: 'Color',
                                               content: widget.car.color,
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
                                             imagePath: 'assets/images/Licence Plate.png',
                                             title: 'Plate Number',
                                             content: widget.car.plateNumber,
                                           ),
                                           ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),
                                           Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/car_w.png',
                                             title: 'Model Name',
                                             content: widget.car.model,
                                           ),
                                           
                                           ), 
                                           
                                             Padding(
                                             padding: const EdgeInsets.only(left:12.0,right:12,top:20,bottom: 12),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/Calendar.png',
                                             title: 'Year',
                                             content: widget.car.year.toString(),
                                           ),
                                           ),
                                           

                            ],),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:95.0),
                        child: Divider(color: Color(0xffC1BEBE),),
                      )
                      ,             Padding(
                        padding: const EdgeInsets.only(top:205.0),
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
                          child: Image.asset("assets/images/car_profile.png"),
                        
                      ))
                ],
              ),
            
              ),
          );
  }
}
