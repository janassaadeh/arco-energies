import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model

class EditCompany extends StatefulWidget {
  final Company company; // Pass the Company object to the screen
   dynamic imageData;
  EditCompany({required this.company,this.imageData});

  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  late TextEditingController _nameController;

  late TextEditingController _contactNameController;

  late TextEditingController _locationController;

  late TextEditingController _emailController;

  late TextEditingController _phoneController;

  late TextEditingController _balanceController;
    dynamic base64Image1;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with company data
    _nameController = TextEditingController(text: widget.company.name);
    _contactNameController = TextEditingController(text: widget.company.contactName);
    _locationController = TextEditingController(text: widget.company.location);
    _emailController = TextEditingController(text: widget.company.email);
    _phoneController = TextEditingController(text: widget.company.phone);
    _balanceController = TextEditingController(text: widget.company.balance.toString());
    return Scaffold(
  appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('Edit Company',style: TextStyle(
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
        child: Stack(
          clipBehavior: Clip.none,
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
              padding: const EdgeInsets.only(top: 120.0),
              child: Container(
                height: 790,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    SizedBox(height: 25),
                    // Replace CustomInputFieldLarge with your desired input fields
                    ManageFields(
                      controller: _nameController,
                      imagePath: 'assets/images/buis_name.png',
                      hintText: "Company Name",
                    ),
                    const SizedBox(height: 20),
                    ManageFields(
                      controller: _contactNameController,
                      imagePath: 'assets/images/id.png',
                      hintText: "Contact Name",
                    ),
                    const SizedBox(height: 20),
                    ManageFields(
                      controller: _locationController,
                      imagePath: 'assets/images/blue pin.png',
                      hintText: "Location",
                    ),
                    const SizedBox(height: 20),
                    ManageFields(
                      controller: _emailController,
                      imagePath: 'assets/images/Letter.png',
                      hintText: "Email",
                    ),
                    const SizedBox(height: 20),
                    ManageFields(
                      controller: _phoneController,
                      imagePath: 'assets/images/phone_blue.png',
                      hintText: "Phone",
                    ),

                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: ()async {
                        ImageService imageService =ImageService();
                        // print(base64Image1);
                 await  imageService.uploadImage(base64Image1, widget.company.id);
                        _saveChanges(context);
                      },
                      child: CustomButton(buttonText: "Save"),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 140,
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
                  color: Colors.white, // You can set your desired background color
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
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {
    
    final editedCompany = Company(
      id: widget.company.id,
      name: _nameController.text,
      contactName: _contactNameController.text,
      location: _locationController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      balance: double.tryParse(_balanceController.text) ?? 0.0,
      imageId: widget.company.imageId
    );
    CompanyService _companyService=CompanyService();
    try {
      await _companyService.updateCompany(editedCompany.id, editedCompany);
      Navigator.pop(context, editedCompany); // Pass edited company object back to the previous screen
    } catch (e) {
      // Handle error
      print("Error updating company: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update company"),
      ));
    }
  }
}
