import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/redemption_model.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/transactions.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Screens/Admin/Rewards/redemption.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:company_pages/Widgets/calendar_sheet.dart';
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
  // final Company company;
  List<Pump> pumps;
  List<Vehicle> cars;
  EditOperator(
      {required this.operator,
      this.imageData,
      required this.cars,
      required this.pumps});

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

  bool _viewRedemptionLoading = false;
  bool _viewTransactionsLoading = false;
  bool _saveOpChangesLoading = false;

  void _handleDateSelection(DateTime date) {
    // Format the selected date to your desired format
    String formattedDate = "${date.year}-${date.month}-${date.day}";
    // Set the formatted date to the _dobController
    _dobController.text = formattedDate;
  }

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
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            'Edit Operator',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.edit, size: 37, color: const Color(0xff003D5B)),
          )
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
                            _viewRedemptionLoading =
                                true; // Set loading state to true
                          });
                          //                       VehicleCompanyService vehicleCompanyService=VehicleCompanyService();
                          //                       final cars=await vehicleCompanyService.getVehiclesForCompany(widget.company.id);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Cars(cars:cars,company: widget.company,)));
                          RewardService transactionService = RewardService();
                          List<RedemptionEvent> allTransactions =
                              await transactionService.getRedemptions();

                          // Filter transactions for the specific company
                          List<RedemptionEvent> opTransactions = allTransactions
                              .where((transaction) =>
                                  transaction.operator.id == widget.operator.id)
                              .toList();
// Sort the companyTransactions list from newest to oldest
// opTransactions.sort((a, b) => b.date.compareTo(a.date));

// Now companyTransactions is sorted from newest to oldest

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Redemption(
                                        transactions: opTransactions,
                                        operator: widget.operator,
                                      )));
                          setState(() {
                            _viewRedemptionLoading =
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
                                  _viewRedemptionLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
                                          'View Redemptions',
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
                          List<Transaction> opTransactions = allTransactions
                              .where((transaction) =>
                                  transaction.operator.id == widget.operator.id)
                              .toList();
// Sort the companyTransactions list from newest to oldest
// opTransactions.sort((a, b) => b.date.compareTo(a.date));

// Now companyTransactions is sorted from newest to oldest

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyTranscations(
                                        transactions: opTransactions,
                                        cars: widget.cars,
                                        pumps: widget.pumps,
                                        company: widget.operator,
                                      )));
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
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
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
                        "Name",
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
                    hintText: "Operator Name",
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _addressController,
                    imagePath: 'assets/images/blue pin.png',
                    hintText: "Address",
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date Of Birth",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          // Parse the date from the text field or use the default date if parsing fails
// Parse the date from the text field or use the default date if parsing fails
                          DateTime selectedDate;
                          try {
                            // Split the date string into year, month, and day parts
                            List<String> parts =
                                _dobController.text!.split('-');
                            int year = int.parse(parts[0]);
                            int month = int.parse(parts[1]);
                            int day = int.parse(parts[2]);

                            // Create a DateTime object from the parsed parts
                            selectedDate = DateTime(year, month, day);
                          } catch (e) {
                            print('Error parsing date: $e');
                            // Use a default date if parsing fails
                            selectedDate = DateTime(2005, 1);
                          }

                          return CalendarBottomSheet(
                            selectedDate: selectedDate,
                            onDateSelected: _handleDateSelection,
                          );
                        },
                      );
                    },
                    child: ManageFields(
                      controller: _dobController,
                      imagePath: 'assets/images/Calendar.png',
                      hintText: "Date Of Birth",
                      enabled: false,
                    ),
                  ),

                  // const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _saveOpChangesLoading = true;
                      });
                      ImageService imageService = ImageService();
                      // print(base64Image1);
                      if (base64Image1 != null) {
                        await imageService.uploadImage(
                            base64Image1, widget.operator.id);
                      }
                      _saveChanges(context);
                      setState(() {
                        _saveOpChangesLoading = false;
                      });
                    },
                    child: _saveOpChangesLoading
                        ? CircularProgressIndicator()
                        : CustomButton(buttonText: "Save"),
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
    final editedOperator = Operator(
        id: widget.operator.id,
        name: _nameController.text,
        dob: _dobController.text,
        address: _addressController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        imageId: widget.operator.imageId);
    OperatorService operatorService = OperatorService();
    try {
      await operatorService.updateOperator(editedOperator.id, editedOperator);
      Navigator.pop(context,
          editedOperator); // Pass edited company object back to the previous screen
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
