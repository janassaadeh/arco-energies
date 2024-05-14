import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Fields.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
//
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import '../../../Widgets/Common/CustomInputFieldSmall.dart';
import '../../../Widgets/Home/recentTransaction.dart';
import '../../../Widgets/profile/link.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';


class ViewCar extends StatefulWidget {
  final Vehicle car;
  final dynamic company;
   dynamic imageData;

  ViewCar({required this.car, required this.company, required this.imageData});

  @override
  State<ViewCar> createState() => _ViewCarState();
}

class _ViewCarState extends State<ViewCar> {
  late TextEditingController _modelController;

  late TextEditingController _plateNumberController;

  late TextEditingController _yearController;

  late TextEditingController _colorController;

  late TextEditingController _driverNameController;

  late TextEditingController _modelNameController;

  late TextEditingController _carIdController;
   dynamic base64Image1;

  @override
  Widget build(BuildContext context) {
    _modelController = TextEditingController(text: widget.car.model);
    _plateNumberController = TextEditingController(text: widget.car.plateNumber);
    _yearController = TextEditingController(text: widget.car.year.toString());
    _colorController = TextEditingController(text: widget.car.color);
    _driverNameController = TextEditingController(text: widget.car.driverName);
    _modelNameController = TextEditingController(text: widget.car.model);
    _carIdController = TextEditingController(text: widget.car.id.toString());

    return Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Car Details',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [const Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.edit,size:37,color: const Color(0xff003D5B)),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(
          // clipBehavior: Clip.none,
          children: [
                        SizedBox(height: 40,),
     Padding(
       padding: const EdgeInsets.only(bottom:40),
       child: Center(
         child: Stack(
           children: [
             CircleAvatar(
               backgroundColor: Color(0xffC1BEBE),
               radius: 67,
               child:(widget.imageData==null)?Image.asset("assets/images/car_profile.png"):
               ClipOval(
                 child: Image.memory(
                           widget.imageData!,
                           fit: BoxFit.cover, // Adjust the fit as needed
                           width: 134, // Set the width and height to ensure the image is circular
                           height: 134,
                         ),
               ),
             ),
               
           ],
         ),
       ),
     ),
     
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                 
                  // Text(
                  //   widget.company.name,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: Color.fromRGBO(0, 0, 0, 1),
                  //       fontFamily: 'Inter',
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.w700,
                  //       height: 1),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Plate Number",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                                    
                    ),
                  ),
                  ManageFields(
                    controller: _plateNumberController,
                    imagePath: 'assets/images/Licence Plate.png',
                    hintText: "Plate Number",
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Year",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _yearController,
                    imagePath: 'assets/images/Calendar.png',
                    hintText: "Year",
                    enabled: false,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Color",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _colorController,
                    imagePath: 'assets/images/Fill Color.png',
                    hintText: "Color",
                    enabled: false,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Driver Name",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _driverNameController,
                    imagePath: 'assets/images/Driver License.png',
                    hintText: "Driver Name",
                    enabled: false,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Model Name",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _modelController,
                    imagePath: 'assets/images/car_w.png',
                    hintText: "Model Name",
                    enabled: false,

                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
              

                ],
              ),
            ),
         SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {}
}
