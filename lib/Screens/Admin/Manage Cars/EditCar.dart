
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
// 
import 'package:flutter/material.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import '../../../Widgets/Common/CustomInputFieldSmall.dart';
import '../../../Widgets/Home/recentTransaction.dart';
import '../../../Widgets/profile/link.dart';
import '../../Auth/Login.dart';
import '../Car_Model.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';




class EditCar extends StatelessWidget {
    final Vehicle car;
    final Company company;

  EditCar({ required this.car,required this.company});
 late TextEditingController _modelController;
  late TextEditingController _plateNumberController;
  late TextEditingController _yearController;
  late TextEditingController _colorController;
  late TextEditingController _driverNameController;
  late TextEditingController _modelNameController;
  late TextEditingController _carIdController;


  @override
  Widget build(BuildContext context) {
        _modelController = TextEditingController(text: car.model);
    _plateNumberController = TextEditingController(text: car.plateNumber);
    _yearController = TextEditingController(text: car.year.toString());
    _colorController = TextEditingController(text: car.color);
    _driverNameController = TextEditingController(text: car.driverName);
    _modelNameController = TextEditingController(text: car.model);
    _carIdController = TextEditingController(text:car.id.toString());
    return 
          Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Edit Car',style: TextStyle(
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
                Text('Company Name', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),),
                SizedBox(height: 25,),
           
            ManageFields(controller: _plateNumberController, imagePath:  'assets/images/Licence Plate.png', hintText: "Plate Number",),
            const SizedBox(height: 20,),
            
            ManageFields(controller: _yearController, imagePath:  'assets/images/Calendar.png', hintText: "Year",),
                        
            const SizedBox(height: 20,),

            ManageFields(controller: _colorController, imagePath:  'assets/images/Fill Color.png', hintText: "Color",),
            const SizedBox(height: 20,),
            
            ManageFields(controller: _driverNameController, imagePath:  'assets/images/Driver License.png', hintText: "Driver Name",),
            const SizedBox(height: 20,),
            
            ManageFields(controller: _modelController, imagePath:  'assets/images/car_w.png', hintText: "Model Name",),
            const SizedBox(height: 30,),

GestureDetector(
  onTap: ()async{
      final editedCar = Vehicle(
    model: _modelController.text,
    plateNumber: _plateNumberController.text,
    year: int.tryParse(_yearController.text) ?? 0,
    color: _colorController.text,
    driverName: _driverNameController.text,
    type: 'car',
    transactions: [],
    // modelName: _modelNameController.text,
    id: car.id
  );

  VehicleCompanyService vehicleCompanyService=VehicleCompanyService();
    try {
      await vehicleCompanyService.updateVehicleForCompany(company.id,car.id,editedCar.type,editedCar.year,editedCar.model,editedCar.plateNumber,editedCar.driverName,editedCar.color);
      Navigator.pop(context, editedCar); // Pass edited company object back to the previous screen
    } catch (e) {
      // Handle error
      print("Error updating company: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update company"),
      ));
    }
  
  },
  child: CustomButton(buttonText: "Save"))

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
void _saveChanges(BuildContext context) async{
}

}
