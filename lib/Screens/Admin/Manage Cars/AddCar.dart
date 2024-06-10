import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Widgets/Common/Info.dart';
import 'package:company_pages/Widgets/Common/select.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import '../../../Widgets/Common/CustomInputFieldSmall.dart';
import '../../../Widgets/Home/recentTransaction.dart';
import '../../../Widgets/profile/link.dart';
import '../../Auth/Login.dart';
import '../Car_Model.dart';

class AddCar extends StatefulWidget {
  final Company company;
  AddCar({required this.company});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _plateNumberPrefixController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _carIdController = TextEditingController();
  List<String> list = ['A', 'B', 'O', 'T'];
  int selectedIndex = 0;
  bool loading=false;
  // Regular expression patterns
  final RegExp _plateNumberRegExp = RegExp(r'^[A-Z0-9]+$');
  final RegExp _yearRegExp = RegExp(r'^\d{4}$');

  @override
  Widget build(BuildContext context) {
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
            'Add Car',
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(color: Color(0xff003D5B), width: double.infinity, height: 200,),
                Container(
                  color: Colors.white,
                  height: 600,
                  child: Column(
                    children: [],
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
                ),
                child: Column(
                  children: [
                    SizedBox(height: 90,),
                    Text(
                      widget.company.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1),
                    ),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return Material(
                                  child: SelectionList(
                                    itemList: list,
                                    selectedIndex: selectedIndex,
                                    onItemSelected: (index) {
                                      setState(() {
                                        selectedIndex = index;
                                        _plateNumberPrefixController.text = list[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(196, 196, 196, 0.2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8, bottom: 25, top: 11),
                              child: TextFormField(
                                controller: _plateNumberPrefixController,
                                enabled: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontFamily: 'Mulish',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 250,
                          height: 62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(196, 196, 196, 0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
                            child: TextFormField(
                              controller: _plateNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Plate Number",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    CustomInputFieldLarge(
                      controller: _yearController,
                      imagePath: 'assets/images/Calendar.png',
                      hintText: "Year",
                    ),
                    const SizedBox(height: 20,),
                    CustomInputFieldLarge(
                      controller: _colorController,
                      imagePath: 'assets/images/Fill Color.png',
                      hintText: "Color",
                    ),
                    const SizedBox(height: 20,),
                    CustomInputFieldLarge(
                      controller: _driverNameController,
                      imagePath: 'assets/images/Driver License.png',
                      hintText: "Driver Name",
                    ),
                    const SizedBox(height: 20,),
                    CustomInputFieldLarge(
                      controller: _modelController,
                      imagePath: 'assets/images/car_w.png',
                      hintText: "Model Name",
                    ),
                    const SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () async {
                        if (_yearController.text.isEmpty ||
                            _colorController.text.isEmpty ||
                            _driverNameController.text.isEmpty ||
                            _modelController.text.isEmpty ||
                            _plateNumberPrefixController.text.isEmpty ||
                            _plateNumberController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                  text: "All fields must be filled out!");
                            },
                          );
                          return;
                        }

                        if (!_plateNumberRegExp.hasMatch(_plateNumberPrefixController.text + _plateNumberController.text)) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                  text: "Plate number is invalid. Only uppercase letters and digits are allowed.");
                            },
                          );
                          return;
                        }

                        if (!_yearRegExp.hasMatch(_yearController.text)) {
                          print(_yearController.text);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                  text: "Year is invalid. It must be a four-digit number.");
                            },
                          );
                          return;
                        }

                        try {
                            setState(() {
                            loading=true;
                          });
                          VehicleCompanyService vehicleCompanyService =
                              VehicleCompanyService();
                          final car = await vehicleCompanyService.addVehicleForCompany(
                              widget.company.id,
                              'car',
                              int.parse(_yearController.text),
                              _modelController.text,
                              _plateNumberPrefixController.text + _plateNumberController.text,
                              _driverNameController.text,
                              _colorController.text);
                          final newCar = Vehicle(
                            id: car.id,
                            type: 'Car',
                            model: _modelController.text,
                            plateNumber: _plateNumberPrefixController.text + _plateNumberController.text,
                            year: int.tryParse(_yearController.text) ?? 0,
                            color: _colorController.text,
                            driverName: _driverNameController.text,
                          );

                          Navigator.pop(context, newCar);
                          setState(() {
                            loading=false;
                          });
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ErrorPopUp(
                                  text: "Failed to add car. Please try again.");
                            },
                          );
                        }
                      },
                      child: CustomButton(buttonText: loading?'':"Add")
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xffC1BEBE),
                  radius: 67,
                  child: Image.asset("assets/images/car_profile.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
