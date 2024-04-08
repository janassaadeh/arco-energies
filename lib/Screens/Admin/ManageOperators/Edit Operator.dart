import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:flutter/material.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model

class EditOperator extends StatelessWidget {
  final Operator operator; // Pass the Company object to the screen

  EditOperator({required this.operator});

  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  // late TextEditingController _balanceController;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with company data
    _nameController = TextEditingController(text: operator.name);
    _dobController = TextEditingController(text: operator.dob);
    _addressController = TextEditingController(text: operator.address);
    _emailController = TextEditingController(text: operator.email);
    _phoneController = TextEditingController(text: operator.phone);

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
                      hintText: "Operator Name",
                    ),
           
                    const SizedBox(height: 20),
                    ManageFields(
                      controller: _addressController,
                      imagePath: 'assets/images/blue pin.png',
                      hintText: "Address",
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
                    const SizedBox(height: 20),

     ManageFields(
                      controller: _nameController,
                      imagePath: 'assets/images/buis_name.png',
                      hintText: "Date Of Birth",
                    ),
           
                    // const SizedBox(height: 20),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
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

  void _saveChanges(BuildContext context) async {
    final editedOperator = Operator(
      id: operator.id,
      name: _nameController.text,
      dob: _dobController.text,
      address: _addressController.text,
      email: _emailController.text,
      phone: _phoneController.text,
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
