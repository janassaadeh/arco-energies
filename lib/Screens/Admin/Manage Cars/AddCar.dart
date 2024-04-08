
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
// 
import 'package:flutter/material.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import '../../../Widgets/Common/CustomInputFieldSmall.dart';
import '../../../Widgets/Home/recentTransaction.dart';
import '../../../Widgets/profile/link.dart';
import '../../Auth/Login.dart';
import '../Car_Model.dart';




class AddCar extends StatelessWidget {
  final Company company;
  AddCar({required this.company});
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  // final TextEditingController _modelNameController = TextEditingController();
  final TextEditingController _carIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
          Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Add Car',style: TextStyle(
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
                        padding: const EdgeInsets.only(top:120.0),
                        child: Container(
                                height: 700,
                                width:double.infinity,
                                decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                              ),
                                child: Column(children: [
                                        SizedBox(height: 90,),
                Text(company.name, textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),),
                SizedBox(height: 25,),
           
            CustomInputFieldLarge(controller: _plateNumberController, imagePath:  'assets/images/Licence Plate.png', hintText: "Plate Number",),
            const SizedBox(height: 20,),
            
            CustomInputFieldLarge(controller: _yearController, imagePath:  'assets/images/Calendar.png', hintText: "Year",),
                        
            const SizedBox(height: 20,),

            CustomInputFieldLarge(controller: _colorController, imagePath:  'assets/images/Fill Color.png', hintText: "Color",),
            const SizedBox(height: 20,),
            
            CustomInputFieldLarge(controller: _driverNameController, imagePath:  'assets/images/Driver License.png', hintText: "Driver Name",),
            const SizedBox(height: 20,),
            
            CustomInputFieldLarge(controller: _modelController, imagePath:  'assets/images/car_w.png', hintText: "Model Name",),
            const SizedBox(height: 30,),

GestureDetector(
  onTap: ()async{
     VehicleCompanyService vehicleCompanyService=VehicleCompanyService();
    final car=await vehicleCompanyService.addVehicleForCompany(company.id, 'car', int.parse(_yearController.text), _modelController.text, _plateNumberController.text, _driverNameController.text, _colorController.text);
        final newCar = Vehicle(
          id:car.id,
          type: 'Car',
      model: _modelController.text,
      plateNumber: _plateNumberController.text,
      year: int.tryParse(_yearController.text) ?? 0,
      color: _colorController.text,
      driverName: _driverNameController.text,
      transactions: [],

    );
    

    Navigator.pop(context, newCar);
    
  },
  child: CustomButton(buttonText: "Add"))

               
            

          
               
                                ],),
                              ),
                              
                      ),
                      Positioned(
                        top:50,
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
   void _addCar(BuildContext context) {
   

  }
}
