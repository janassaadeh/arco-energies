import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/Cars.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/transactions.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
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
  List<Vehicle> allcars;
  List<Pump> pumps;
  EditCompany(
      {required this.company,
      this.imageData,
      required this.allcars,
      required this.pumps});

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

  bool _viewCarsLoading = false;
  bool _viewTransactionsLoading = false;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with company data
    _nameController = TextEditingController(text: widget.company.name);
    _contactNameController =
        TextEditingController(text: widget.company.contactName);
    _locationController = TextEditingController(text: widget.company.location);
    _emailController = TextEditingController(text: widget.company.email);
    _phoneController = TextEditingController(text: widget.company.phone);
    _balanceController =
        TextEditingController(text: widget.company.balance.toString());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            'Edit Company',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            offset: Offset(-0, 52), // Adjusts the position closer to the bottom
            // shadowColor: Colors.transparent,
            padding: EdgeInsets.all(0.0),

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),

            surfaceTintColor: Colors.white,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        print('hi');
                        CompanyService companyService = CompanyService();
                        await companyService.activateCompany(widget.company.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Activate',
                        style: TextStyle(
                          color: Colors.black, // Changes text color to white
                          fontSize: 16, // Changes text size
                        ),
                      ),
                    ),
                  ),
                  value: 'Option 1',
                ),
              ];
            },
            onSelected: (value) {
              print('Selected: $value');
            },
            // color: Colors.white,
            iconSize: 27, // Changes menu background color
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 62,
                        child: (widget.imageData == null ||
                                widget.imageData == 'no image')
                            ? Image.asset("assets/images/buisness_profile.png")
                            : ClipOval(
                                child: Image.memory(
                                  widget.imageData!,
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                  width:
                                      134, // Set the width and height to ensure the image is circular
                                  height: 134,
                                ),
                              ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Container(
                          width:
                              30, // Adjust the width of the container as needed
                          height:
                              30, // Adjust the height of the container as needed
                          decoration: BoxDecoration(
                            color: Color(
                                0xffC1BEBE), // You can set your desired background color
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
                              onTap: () {
                                final picker = ImagePicker();

                                Future<void> _openImagePicker() async {
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    final file = File(pickedFile.path);
                                    final bytes = await file.readAsBytes();
                                    final base64Image = base64Encode(bytes);
                                    final image =
                                        "data:image/png;base64,$base64Image";

                                    // Now you have the base64-encoded image
                                    // print("Base64 Image: $base64Image");
                                    // print(base64Image);

                                    setState(() {
                                      widget.imageData =
                                          bytes; // Set the picked image file
                                      // Update the profileAvatar URL
                                      base64Image1 = base64Image;
                                    });
                                    // print(base64Image1);

                                    // print(imgUrl);
                                  } else {
                                    // Handle no image picked error
                                  }
                                }

                                _openImagePicker();
                              },
                              child: Center(child: Icon(Icons.add)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _viewCarsLoading =
                                true; // Set loading state to true
                          });
                          VehicleCompanyService vehicleCompanyService =
                              VehicleCompanyService();
                          final cars = await vehicleCompanyService
                              .getVehiclesForCompany(widget.company.id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cars(
                                        cars: cars,
                                        company: widget.company,
                                      )));
                          setState(() {
                            _viewCarsLoading =
                                false; // Set loading state to true
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 170,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment(1.5, 1),
                                  end: Alignment(-1.5, 1),
                                  colors: [
                                    Color.fromRGBO(0, 61, 91, 1),
                                    Color.fromRGBO(
                                        2, 91, 134, 0.8999999761581421)
                                  ]),
                            ),
                            //                 decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   color: const Color.fromRGBO(196, 196, 196, 0.2),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _viewCarsLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
                                          'View Cars',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      'assets/images/WhiteCar.png',
                                      color: Colors.white,
                                      width: 27,
                                      height: 27,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _viewTransactionsLoading = true;
                          });
                          TransactionService transactionService =
                              TransactionService();
                          List<Transaction> allTransactions =
                              await transactionService.getTransactions();

                          // Filter transactions for the specific company
                          List<Transaction> companyTransactions =
                              allTransactions
                                  .where((transaction) =>
                                      transaction.vehicle.company.id ==
                                      widget.company.id)
                                  .toList();
// Sort the companyTransactions list from newest to oldest
                          companyTransactions
                              .sort((a, b) => b.date.compareTo(a.date));

// Now companyTransactions is sorted from newest to oldest

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyTranscations(
                                      transactions: companyTransactions,
                                      company: widget.company,
                                      cars: widget.allcars,
                                      pumps: widget.pumps)));
                          setState(() {
                            _viewTransactionsLoading = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Container(
                            width: 170,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment(1.5, 1),
                                  end: Alignment(-1.5, 1),
                                  colors: [
                                    Color.fromRGBO(0, 61, 91, 1),
                                    Color.fromRGBO(
                                        2, 91, 134, 0.8999999761581421)
                                  ]),
                            ),
                            //                 decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   color: const Color.fromRGBO(196, 196, 196, 0.2),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _viewTransactionsLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
                                          'View Transactions',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                  //       Padding(
                                  // padding: const EdgeInsets.only(left:8.0),
                                  //         child: Image.asset('assets/images/WhiteCar.png',color: Colors.white,width: 27,height: 27,),
                                  //       )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //            Padding(
                      //       padding: const EdgeInsets.only(right:40.0),
                      //       child: Container(
                      //           width: 190,
                      //           height: 50,
                      //  decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(30),
                      //   // gradient: const LinearGradient(
                      //   //   begin: Alignment(1.5, 1),
                      //   //   end: Alignment(-1.5, 1),
                      //   //           colors: [Color.fromRGBO(0, 61, 91, 1),Color.fromRGBO(2, 91, 134, 0.8999999761581421)]

                      //   // ),
                      //   color: Colors.red.shade400
                      // ),
                      // //                 decoration: BoxDecoration(
                      // //   borderRadius: BorderRadius.circular(10),
                      // //   color: const Color.fromRGBO(196, 196, 196, 0.2),
                      // // ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(left:20.0,right: 20,top: 10,bottom: 10),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Center(child: Text('Delete',style: TextStyle(color: Colors.white,fontSize: 18,),)),
                      //                 // Image.asset('assets/images/WhiteCar.png',color: Colors.white,)
                      //             Padding(
                      //               padding: const EdgeInsets.only(left:8.0),
                      //               child: Icon(Icons.delete,color: Colors.white,),
                      //             )

                      //               ],
                      //             ),
                      //           ),
                      //           ),
                      //     )
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  // SizedBox(height: 80),
                  SizedBox(height: 10),
                  // Replace CustomInputFieldLarge with your desired input fields
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Company Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _nameController,
                    imagePath: 'assets/images/buis_name.png',
                    hintText: "Company Name",
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contact Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _contactNameController,
                    imagePath: 'assets/images/id.png',
                    hintText: "Contact Name",
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _locationController,
                    imagePath: 'assets/images/blue pin.png',
                    hintText: "Location",
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _emailController,
                    imagePath: 'assets/images/Letter.png',
                    hintText: "Email",
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _phoneController,
                    imagePath: 'assets/images/phone_blue.png',
                    hintText: "Phone",
                  ),

                  const SizedBox(height: 40),
              GestureDetector(
  onTap: () async {
    // Check for empty fields
    if (_nameController.text.isEmpty ||
        _contactNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ErrorPopUp(text: "Please fill in all fields.");
        },
      );
      return;
    }

    // All validations passed, proceed with saving changes
    ImageService imageService = ImageService();
    if (base64Image1 != null) {
      await imageService.uploadImage(
          base64Image1, widget.company.id);
    }
    _saveChanges(context);
  },
  child: CustomButton(buttonText: "Save"),
)

                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
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
        imageId: widget.company.imageId,
        activated: widget.company.activated);
    CompanyService _companyService = CompanyService();
    try {
      await _companyService.updateCompany(editedCompany.id, editedCompany);
      Navigator.pop(context,
          editedCompany); // Pass edited company object back to the previous screen
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
