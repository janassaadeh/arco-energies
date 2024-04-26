
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:company_pages/Screens/Admin/Manage%20Cars/Cars.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
// 
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Widgets/Home/recentTransaction.dart';
import '../../../../Widgets/profile/link.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../../../Services/Manage Accounts/vehicle_company_service.dart';
import 'Edit Company.dart';

import 'package:image_picker/image_picker.dart';

class CompanyDetails extends StatefulWidget {
     Company company;
     dynamic imageData;

  CompanyDetails({required this.company,required this.imageData});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  ImageService imageService = ImageService();
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    // _fetchImage();
      _imageData=widget.imageData;
  }

  Future<void> _fetchImage() async {
    try {
      // Fetch image data using the image ID
      Uint8List imageData = await imageService.getImageFromId(widget.company.imageId);

      // Update the state to trigger a rebuild with the fetched image data
      setState(() {
        _imageData = imageData;
      });
    } catch (e) {
      // Handle errors
      print('Failed to fetch image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
  print(widget.company.email);

    return 
          Scaffold(
  appBar: AppBar(
                leading: GestureDetector(
                  onTap: (){
             Navigator.pop(context, widget.company); 

                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,)),

        title: Center(
          child:  Text('Company Details',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [GestureDetector(
        onTap:  () async {
            final newCompany = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditCompany(company:widget.company,imageData:widget.imageData)),
            );
            if (newCompany != widget.company) {
              setState(() {
              widget.company=newCompany;
              });
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(right:8.0),
            child: Icon(Icons.edit,size:37,color: Colors.white),
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
                Text(widget.company.name, textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),),
                SizedBox(height: 15,),

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
                                               content: widget.company.id,
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                             Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/id.png',
                                               title: 'Contact Name',
                                               content: widget.company.contactName,
                                             ),
                                             ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),

                                                                           Padding(
                                               padding: const EdgeInsets.only(left:12.0,right:12.0,top:10,),
                                               child: Info(
                                               imagePath: 'assets/images/phone_blue.png',
                                               title: 'Phone Number',
                                               content: widget.company.phone,
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
                                             content: '\$ ${widget.company.balance}',
                                           ),
                                           ),
SizedBox(width:180,child: Divider(color: Color(0xffffffff),)),
                                           Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/blue pin.png',
                                             title: 'Location',
                                             content: widget.company.location,
                                           ),
                                           ),
Padding(
                                             padding: const EdgeInsets.only(top:12,left:5.0,right:5),
                                             child: Info(
                                              
                                             imagePath: 'assets/images/Letter.png',
                                             title: 'Email',
                                             content: widget.company.email,
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
                          const SizedBox(height: 40,),
                          GestureDetector(
                            onTap: ()async{
                              VehicleCompanyService vehicleCompanyService=VehicleCompanyService();
                              final cars=await vehicleCompanyService.getVehiclesForCompany(widget.company.id);
                              
        Navigator.push(context, MaterialPageRoute(builder: (context) => Cars(cars:cars,company: widget.company,)));
                              
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 62,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      begin: Alignment(1.5, 1),
                                      end: Alignment(-1.5, 1),
                                      colors: [
                                        Color.fromRGBO(237, 174, 73, 0.5),
                                        Color.fromRGBO(237, 174, 73, 1),
                                        Color.fromRGBO(237, 174, 73, 0.5)
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: 70,),
                                        Text(
                                          'View All Cars',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                            fontFamily: 'Inter',
                                            fontSize: 21,
                                            letterSpacing: -0.44,
                                            fontWeight: FontWeight.normal,
                                            height: 1.0952380952380953,
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                          
                                        Image.asset('assets/images/Next page.png')
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                          )
                                ],),
                              ),
                              
                      ),
                      Positioned(
                        top:100,
                        right:140,
                        child: 
                        
                        _imageData=='' || _imageData==null?
                        CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 67,
                        
                          child: Image.asset("assets/images/buisness_profile.png"),

                        )
                        
                        
                        :
                        CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 67,
                          child:  ClipOval(
          child: 
          
          _imageData != null
      ?
          Image.memory(
            _imageData!,
            fit: BoxFit.cover, // Adjust the fit as needed
            width: 134, // Set the width and height to ensure the image is circular
            height: 134,
          ):
          Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ) 
        )
      // : CircularProgressIndicator()
                        
                      )),
                      
              
                ],
              ),
            
              ),
          );
  }
}
