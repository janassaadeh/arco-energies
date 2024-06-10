import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/pump_response.dart';
import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Models/vehicle_response.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/transaction_cars.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';

import 'package:company_pages/Screens/Operator/Transactions/cars_list.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/manage%20transactions.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/Operator/pump_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:company_pages/Widgets/Common/select.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model

class AddReward extends StatefulWidget {


  @override
  State<AddReward> createState() => _AddRewardState();
}

class _AddRewardState extends State<AddReward> {
     TextEditingController _nameController=TextEditingController();
bool loading=false;
     TextEditingController _ptsController=TextEditingController();

     TextEditingController _descriptionController=TextEditingController();

     TextEditingController _categoryController=TextEditingController();

  // late TextEditingController _phoneController;

  // late TextEditingController _balanceController;

  // List<Vehicle> cars=[];

  int selectedCategory=0;

  @override
  void initState() {
    super.initState();
    // _fetchPumps();

 

  }

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with company data

    // _phoneController = TextEditingController(text: widget.operator.phone);
    return Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Add Reward',style: TextStyle(
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
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  // SizedBox(height: 80),
                  SizedBox(height: 10),
                  // Replace CustomInputFieldLarge with your desired input fields
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Category",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                   
                    ),
                                   ),
                    GestureDetector(
                    onTap: (){
                      
                                showModalBottomSheet(
                                  barrierColor: Colors.transparent,
                      
                                        context: context,
                                        builder: (BuildContext context) {
                            return Material(
                              child: SelectionList(
                                itemList:categories,
                                selectedIndex: selectedCategory,
                                onItemSelected: (index) {
                                  print(categories[selectedCategory]);
                                  setState(() {
                                    selectedCategory = index;
                                    
                                    _categoryController.text=categories[selectedCategory];
                                  });
                                  Navigator.pop(context); // Close the bottom sheet
                                },
                              ),
                            );
                                        },
                                      );
                    },
                    child: ManageFields(
                      controller: _categoryController,
                      imagePath: '',
                      hintText: "Cateory",
                      enabled: false,
                    ),
                  ),
           
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _nameController,
                    imagePath: '',
                    hintText: "Name",
                  ),
  
 const SizedBox(height: 20),
                       Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Points",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _ptsController,
                    imagePath: '',
                    hintText: "Points",
                  ),

                  const SizedBox(height: 20),
                       Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Description",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  
         Container(
  width: 328,
  height: 162,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: const Color.fromRGBO(196, 196, 196, 0.2),
  ),
  child: Padding(
    padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
    child: SingleChildScrollView( // Wrap with SingleChildScrollView
      child: TextFormField(
        controller: _descriptionController,
        enabled: true,
        maxLines: null, // Allow TextFormField to have unlimited lines
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Description',
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            fontFamily: 'Mulish',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
  ),
),

                  
                 
//  Padding(
//                     padding: const EdgeInsets.only(left:40.0,bottom: 10),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text("Phone Number",style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xffA9A7A7),
//                                     ),),
//                     ),
//                   ),
//                   ManageFields(
//                     controller: _phoneController,
//                     imagePath: 'assets/images/phone_blue.png',
//                     hintText: "Phone",
//                   ), 
//                   const SizedBox(height: 20),
//  Padding(
//                     padding: const EdgeInsets.only(left:40.0,bottom: 10),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text("Date Of Birth",style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xffA9A7A7),
//                                     ),),
//                     ),
//                   ),
//      ManageFields(
//                     controller: _nameController,
//                     imagePath: 'assets/images/buis_name.png',
//                     hintText: "Date Of Birth",
//                   ),
           
                  // const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  GestureDetector(
                    
                    onTap: () async{
   
 void _addOperator(BuildContext context) async {
 
  try {
     setState(() {
    loading=true;
  });
    RewardService rewardService=RewardService();
  
    

    // Register the new company
    var  response = await rewardService.assignRewards(
     _nameController.text,_descriptionController.text,_categoryController.text,int.parse(_ptsController.text)
      
    );

    // Extract the ID from the response
    String operatorId = response?? '';

    // Create a new company object with the provided data
    final newOperator = Reward(
      id: operatorId,
      name: _nameController.text,
      pts:int.parse(_ptsController.text),
      description: _descriptionController.text,
      category: _categoryController.text
    );

    // If registration is successful, navigate back with the new company object
    Navigator.pop(context, newOperator);
     setState(() {
    loading=true;
  });
  } catch (e) {
     setState(() {
    loading=false;
  });
    // Handle registration failure
    print("Failed to register operator: $e");
    // Show error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to register operator. Please try again.'),
      ),
    );
  }
}
                      _addOperator(context);
                    },
                    child: CustomButton(buttonText: "Add"),
                  )
                ],
              ),
            ),
          SizedBox(height: 50,)

          ],
        ),
      ),
    );
  }
List <String> categories= ['Services', 'Discounts', 'Gifts'];
}
