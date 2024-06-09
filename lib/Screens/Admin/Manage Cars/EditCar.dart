import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
//
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

class EditCar extends StatefulWidget {
  final Vehicle car;
  final dynamic company;
  dynamic imageData;

  EditCar({required this.car, required this.company, required this.imageData});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  late TextEditingController _modelController;

  late TextEditingController _plateNumberController;

  late TextEditingController _yearController;

  late TextEditingController _colorController;

  late TextEditingController _driverNameController;

  late TextEditingController _modelNameController;

  late TextEditingController _carIdController;
  dynamic base64Image1;
   final RegExp _plateNumberRegExp = RegExp(r'^[A-Za-z0-9]+$');
  final RegExp _yearRegExp = RegExp(r'^\d{4}$');

  @override
  Widget build(BuildContext context) {
    _modelController = TextEditingController(text: widget.car.model);
    _plateNumberController =
        TextEditingController(text: widget.car.plateNumber);
    _yearController = TextEditingController(text: widget.car.year.toString());
    _colorController = TextEditingController(text: widget.car.color);
    _driverNameController = TextEditingController(text: widget.car.driverName);
    _modelNameController = TextEditingController(text: widget.car.model);
    _carIdController = TextEditingController(text: widget.car.id.toString());

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
            'Edit Car',
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
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xffC1BEBE),
                      radius: 67,
                      child: (widget.imageData == null ||
                              widget.imageData == 'no image')
                          ? Image.asset("assets/images/car_profile.png")
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
                          color: Colors
                              .grey, // You can set your desired background color
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  // Text(
                  //   widget.company.name,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: Color.fromRGBO(0, 0, 0, 1),
                  //       fontFamily: 'Inter',
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.w700,
                  //       height: 1),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Plate Number",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _plateNumberController,
                    imagePath: 'assets/images/Licence Plate.png',
                    hintText: "Plate Number",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Year",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _yearController,
                    imagePath: 'assets/images/Calendar.png',
                    hintText: "Year",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Color",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _colorController,
                    imagePath: 'assets/images/Fill Color.png',
                    hintText: "Color",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Driver Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _driverNameController,
                    imagePath: 'assets/images/Driver License.png',
                    hintText: "Driver Name",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Model Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA9A7A7),
                        ),
                      ),
                    ),
                  ),
                  ManageFields(
                    controller: _modelController,
                    imagePath: 'assets/images/car_w.png',
                    hintText: "Model Name",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Validate plate number
                      if (!_plateNumberRegExp.hasMatch(_plateNumberController.text)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ErrorPopUp(text: "Please enter a valid plate number.");
                          },
                        );
                        return;
                      }

                      // Validate year
                      if (!_yearRegExp.hasMatch(_yearController.text)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ErrorPopUp(text: "Please enter a valid year.");
                          },
                        );
                        return;
                      }

                      // All validations passed, proceed with saving changes
                      final editedCar = Vehicle(
                        model: _modelController.text,
                        plateNumber: _plateNumberController.text,
                        year: int.tryParse(_yearController.text) ?? 0,
                        color: _colorController.text,
                        driverName: _driverNameController.text,
                        type: 'car',
                        id: widget.car.id,
                      );

                      VehicleCompanyService vehicleCompanyService = VehicleCompanyService();
                      try {
                        await vehicleCompanyService.updateVehicleForCompany(
                          widget.company.id,
                          widget.car.id,
                          editedCar.type,
                          editedCar.year,
                          editedCar.model,
                          editedCar.plateNumber,
                          editedCar.driverName,
                          editedCar.color,
                        );

                        // Upload new image if it has changed
                        if (base64Image1 != null && base64Image1 != widget.imageData) {
                          ImageService imageService = ImageService();
                          await imageService.uploadImageForCar(base64Image1, widget.car.id);
                        }

                        Navigator.pop(context, editedCar); // Pass edited car object back to the previous screen
                      } catch (e) {
                        print("Error updating car: $e");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Failed to update car"),
                        ));
                      }
                    },
                      child: CustomButton(buttonText: "Save"))
                ],
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {}
}
