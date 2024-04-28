import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Services/Auth/RegisterService.dart';
import 'package:flutter/material.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart'; // Import your Company model

class AddCompany extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  

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
            'Add Company',
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
                // Image.asset("assets/images/wallpaper.png"),
                Container(color: Color(0xff003D5B),width: double.infinity,height: 200,),
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
              padding: const EdgeInsets.only(top: 90.0),
              child: Container(
                height: 790,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(25),
                  //   topRight: Radius.circular(25),
                  // ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    
                    SizedBox(height: 25),
                    // Replace CustomInputFieldLarge with your desired input fields
                    CustomInputFieldLarge(
                      controller: _nameController,
                      imagePath: 'assets/images/buis_name.png',
                      hintText: "Company Name",
                    ),
                    const SizedBox(height: 20),
                    CustomInputFieldLarge(
                      controller: _contactNameController,
                      imagePath: 'assets/images/id.png',
                      hintText: "Contact Name",
                    ),
                    const SizedBox(height: 20),
                    CustomInputFieldLarge(
                      controller: _locationController,
                      imagePath: 'assets/images/blue pin.png',
                      hintText: "Location",
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
                        _addCompany(context);
                      },
                      child: CustomButton(buttonText: "Add"),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 140,
              child: CircleAvatar(
                backgroundColor: Color(0xffC1BEBE),
                radius: 62,
                child: Image.asset("assets/images/buisness_profile.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

 void _addCompany(BuildContext context) async {
  
  try {
    RegistrationService registrationService = RegistrationService();
    
    // Register the new company
    RegistrationResponse response = await registrationService.registerCompanyByAdmin(
      name: _nameController.text,
      balance: 0.0,
      email: _emailController.text,
      password: _passController.text,
      contactName: _contactNameController.text,
      phone: _phoneController.text,
      location: _locationController.text,
    );

    // Extract the ID from the response
    String companyId = response.message ?? '';

    // Create a new company object with the provided data
    final newCompany = Company(
      id: companyId,
      name: _nameController.text,
      contactName: _contactNameController.text,
      location: _locationController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      balance: 0.0,
      imageId: '' ,
      activated: true
    );

    // If registration is successful, navigate back with the new company object
    Navigator.pop(context, newCompany);
  } catch (e) {
    // Handle registration failure
    print("Failed to register company: $e");
    // Show error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to register company. Please try again.'),
      ),
    );
  }
}

}
