import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model

class EditOperator extends StatefulWidget {
  final Operator operator; // Pass the Company object to the screen
   dynamic imageData;

  EditOperator({required this.operator,this.imageData});

  @override
  State<EditOperator> createState() => _EditOperatorState();
}

class _EditOperatorState extends State<EditOperator> {
  late TextEditingController _nameController;

  late TextEditingController _dobController;

  late TextEditingController _addressController;

  late TextEditingController _emailController;

  late TextEditingController _phoneController;

  // late TextEditingController _balanceController;
   dynamic base64Image1;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with company data
    _nameController = TextEditingController(text: widget.operator.name);
    _dobController = TextEditingController(text: widget.operator.dob);
    _addressController = TextEditingController(text: widget.operator.address);
    _emailController = TextEditingController(text: widget.operator.email);
    _phoneController = TextEditingController(text: widget.operator.phone);

    return Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Edit Operator',style: TextStyle(
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
               child:(widget.imageData==null)? Image.asset("assets/images/buisness_profile.png"):
               ClipOval(
                 child: Image.memory(
                           widget.imageData!,
                           fit: BoxFit.cover, // Adjust the fit as needed
                           width: 134, // Set the width and height to ensure the image is circular
                           height: 134,
                         ),
               ),
             ),
                 Positioned(
               top: 5, 
               right: 0, 
               child: Container(
                     width: 30, // Adjust the width of the container as needed
                     height: 30, // Adjust the height of the container as needed
                     decoration: BoxDecoration(
             color: Colors.grey, // You can set your desired background color
             shape: BoxShape.circle, // This makes it a circle
             //           boxShadow: [
             // BoxShadow(
             //   color: Colors.black.withOpacity(0.3), // Shadow color
             //   spreadRadius: 2, // Spread radius
             //   blurRadius: 4, // Blur radius
             //   offset: const Offset(0, 2), // Offset
             // ),
                     // ],
                     ),
                     child: Padding(
             padding: const EdgeInsets.all(4),
             child: GestureDetector(
               onTap: (){
                   
                 final picker = ImagePicker();
                   
                   Future<void> _openImagePicker() async {
                     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                   
                     if (pickedFile != null) {
             final file = File(pickedFile.path);
             final bytes = await file.readAsBytes();
             final base64Image = base64Encode(bytes);
             final image = "data:image/png;base64,$base64Image";
                                     
             // Now you have the base64-encoded image
             // print("Base64 Image: $base64Image");
                   // print(base64Image);
                   
             setState(() {
               widget.imageData = bytes; // Set the picked image file
                // Update the profileAvatar URL
                base64Image1=base64Image;
             });
             // print(base64Image1);
       
                 
             // print(imgUrl);
                     } else {
             // Handle no image picked error
                     }
                   }
               _openImagePicker();
               },
               child: Center(
                 child: Icon(Icons.add)
               ),
             ),
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
                  // SizedBox(height: 80),
                  SizedBox(height: 10),
                  // Replace CustomInputFieldLarge with your desired input fields
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
                    imagePath: 'assets/images/buis_name.png',
                    hintText: "Operator Name",
                  ),
           
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Address",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _addressController,
                    imagePath: 'assets/images/blue pin.png',
                    hintText: "Address",
                  ),
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Email",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _emailController,
                    imagePath: 'assets/images/Letter.png',
                    hintText: "Email",
                  ),
                  const SizedBox(height: 20),
 Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Phone Number",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _phoneController,
                    imagePath: 'assets/images/phone_blue.png',
                    hintText: "Phone",
                  ), 
                  const SizedBox(height: 20),
 Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Date Of Birth",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
     ManageFields(
                    controller: _nameController,
                    imagePath: 'assets/images/buis_name.png',
                    hintText: "Date Of Birth",
                  ),
           
                  // const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  GestureDetector(
                    
                    onTap: () async{
                               ImageService imageService =ImageService();
                      // print(base64Image1);
               await  imageService.uploadImage(base64Image1, widget.operator.id);
                      _saveChanges(context);
                    },
                    child: CustomButton(buttonText: "Save"),
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

  void _saveChanges(BuildContext context) async {
    final editedOperator = Operator(
      id: widget.operator.id,
      name: _nameController.text,
      dob: _dobController.text,
      address: _addressController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      imageId: widget.operator.imageId
    );
    OperatorService operatorService =OperatorService();
    try {
      await operatorService.updateOperator(editedOperator.id, editedOperator);
      Navigator.pop(context, editedOperator); // Pass edited company object back to the previous screen
    } catch (e) {
      // Handle error
      print("Error updating operator: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update operator"),
      ));
    }
  }
}
