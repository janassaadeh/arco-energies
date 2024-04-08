import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Services/Auth/RegisterService.dart';
import 'package:flutter/material.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart'; // Import your Company model

class AddOperator extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final TextEditingController _dobController =TextEditingController();
  final TextEditingController _addressController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Center(
          child: Text(
            'Add Operator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.edit, size: 37, color: const Color(0xff003D5B)),
          ),
        ],
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
                      // Add any other widgets you need
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
              
                    CustomInputFieldLarge(
                      controller: _nameController,
                      imagePath: 'assets/images/id.png',
                      hintText: "Name",
                    ),
                    const SizedBox(height: 20),
                    CustomInputFieldLarge(
                      controller: _addressController,
                      imagePath: 'assets/images/blue pin.png',
                      hintText: "Address",
                    ),
                    const SizedBox(height: 20),
                    CustomInputFieldLarge(
                      controller: _emailController,
                      imagePath: 'assets/images/Letter.png',
                      hintText: "Email",
                    ),
                    const SizedBox(height: 20),
                    CustomInputFieldLarge(
                      controller: _phoneController,
                      imagePath: 'assets/images/phone_blue.png',
                      hintText: "Phone",
                    ),
                    const SizedBox(height: 20),

                    CustomInputFieldLarge(
                      controller: _passController,
                      imagePath: 'assets/images/Eye.png',
                      hintText: "Password",
                    ),
               
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        _addOperator(context);
                      },
                      child: CustomButton(buttonText: "Add"),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 140,
              child: CircleAvatar(
                backgroundColor: Color(0xffC1BEBE),
                radius: 67,
                child: Image.asset("assets/images/buisness_profile.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

 void _addOperator(BuildContext context) async {
  
  try {
    RegistrationService registrationService = RegistrationService();
    
    // Register the new company
    RegistrationResponse response = await registrationService.registerOperator(
      name: _nameController.text,
      // balance: 0.0,
      email: _emailController.text,
      password: _passController.text,
      dob: _dobController.text,
      phone: _phoneController.text,
      address: _addressController.text,
    );

    // Extract the ID from the response
    String operatorId = response.message ?? '';

    // Create a new company object with the provided data
    final newOperator = Operator(
      id: operatorId,
      name: _nameController.text,
      dob: _dobController.text,
      address: _addressController.text,
      email: _emailController.text,
      phone: _phoneController.text,
    );

    // If registration is successful, navigate back with the new company object
    Navigator.pop(context, newOperator);
  } catch (e) {
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

}
