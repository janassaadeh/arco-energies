import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/pump_response.dart';
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
import 'package:company_pages/Widgets/Common/select.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model

class EditTransaction extends StatefulWidget {
  final Transaction transaction; // Pass the Company object to the screen
  //  dynamic imageData;
  List<Pump> pumpsObjects;
  // List<String> pumps=[];
  List<String> pumps=['Pump 1','Pump 2','Pump 3','Pump 4'];
  
  List<Vehicle> cars;
  EditTransaction({required this.transaction,required this.cars,required this.pumpsObjects});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  late TextEditingController _pumpController;

  late TextEditingController _quantityController;

  late TextEditingController _odometerController;

  late TextEditingController _vehicleController;

  // late TextEditingController _phoneController;

  // late TextEditingController _balanceController;
   dynamic base64Image1;
  // List<Pump> pumpsObjects=[];
  // List<Vehicle> cars=[];

  int selectedPump=0;
  late VehicleResponse selectedVehicle;
  @override
  void initState() {
    super.initState();
    // _fetchPumps();
    selectedVehicle=widget.transaction.vehicle;
        _pumpController = TextEditingController(text: widget.transaction.pump.name);
    _quantityController = TextEditingController(text: widget.transaction.quantity.toString());
    _odometerController = TextEditingController(text: widget.transaction.odometer.toString());
    _vehicleController = TextEditingController(text: selectedVehicle.id);

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
          child:  Text('Edit Transaction',style: TextStyle(
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
    //  Padding(
    //    padding: const EdgeInsets.only(bottom:40),
    //    child: Center(
    //      child: Stack(
    //        children: [
    //          CircleAvatar(
    //            backgroundColor: Color(0xffC1BEBE),
    //            radius: 67,
    //            child:(widget.imageData==null)? Image.asset("assets/images/buisness_profile.png"):
    //            ClipOval(
    //              child: Image.memory(
    //                        widget.imageData!,
    //                        fit: BoxFit.cover, // Adjust the fit as needed
    //                        width: 134, // Set the width and height to ensure the image is circular
    //                        height: 134,
    //                      ),
    //            ),
    //          ),
    //              Positioned(
    //            top: 5, 
    //            right: 0, 
    //            child: Container(
    //                  width: 30, // Adjust the width of the container as needed
    //                  height: 30, // Adjust the height of the container as needed
    //                  decoration: BoxDecoration(
    //          color: Colors.grey, // You can set your desired background color
    //          shape: BoxShape.circle, // This makes it a circle
    //          //           boxShadow: [
    //          // BoxShadow(
    //          //   color: Colors.black.withOpacity(0.3), // Shadow color
    //          //   spreadRadius: 2, // Spread radius
    //          //   blurRadius: 4, // Blur radius
    //          //   offset: const Offset(0, 2), // Offset
    //          // ),
    //                  // ],
    //                  ),
    //                  child: Padding(
    //          padding: const EdgeInsets.all(4),
    //          child: GestureDetector(
    //            onTap: (){
                   
    //              final picker = ImagePicker();
                   
    //                Future<void> _openImagePicker() async {
    //                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                   
    //                  if (pickedFile != null) {
    //          final file = File(pickedFile.path);
    //          final bytes = await file.readAsBytes();
    //          final base64Image = base64Encode(bytes);
    //          final image = "data:image/png;base64,$base64Image";
                                     
    //          // Now you have the base64-encoded image
    //          // print("Base64 Image: $base64Image");
    //                // print(base64Image);
                   
    //          setState(() {
    //            widget.imageData = bytes; // Set the picked image file
    //             // Update the profileAvatar URL
    //             base64Image1=base64Image;
    //          });
    //          // print(base64Image1);
       
                 
    //          // print(imgUrl);
    //                  } else {
    //          // Handle no image picked error
    //                  }
    //                }
    //            _openImagePicker();
    //            },
    //            child: Center(
    //              child: Icon(Icons.add)
    //            ),
    //          ),
    //                  ),
    //            ),
    //          ),
    //        ],
    //      ),
    //    ),
    //  ),
     
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
                      child: Text("Pump Name",style: TextStyle(
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
                                itemList: widget.pumpsObjects.map((pump) => '${pump.name} ( ${pump.fuel.description}) , ${pump.currency} ${pump.fuel.fuelPrice}').toList(),
                                selectedIndex: selectedPump,
                                onItemSelected: (index) {
                                  setState(() {

                                    selectedPump = index;
                                    _pumpController.text=widget.pumps[index];

                                    print(index);
                                  });
                                  Navigator.pop(context); // Close the bottom sheet
                                },
                              ),
                            );
                                        },
                                      );
                    },
                    child: ManageFields(
                      controller: _pumpController,
                      imagePath: '',
                      hintText: "Pump Name",
                      enabled: false,
                    ),
                  ),
           
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Quantity",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _quantityController,
                    imagePath: '',
                    hintText: "Quantity",
                  ),
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Vehicle ID",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  GestureDetector(
                    
                    onTap: () async {
  final vehicle = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SelectVehicle(cars: widget.cars)),
  );
    if(vehicle!=selectedVehicle){
        setState(() {
      _vehicleController.text = vehicle.id;
        selectedVehicle=vehicle;

    });
    }

  print('Returned Vehicle ID: ${vehicle.id}');
  
  // if (vehicleid != widget.transaction.vehicle.id) {
  //   setState(() {
  //     _vehicleController.text = vehicleid;
  //   });
  // } else {
  //   print('Vehicle ID unchanged');
  // }
},

                    child: ManageFields(
                      controller: _vehicleController,
                      imagePath: '',
                      hintText: "Vehicle ID",
                      enabled:false
                    ),
                  ),

                  const SizedBox(height: 20),
                       Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Odometer",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _odometerController,
                    imagePath: '',
                    hintText: "Odometer",
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
                      
  void _saveChanges(BuildContext context) async {
    Pump selectedpump=widget.pumpsObjects[selectedPump];
    PumpResponse pumpResponse=PumpResponse(id: selectedpump.id, name: selectedpump.name, currency: selectedpump.currency, status: selectedpump.status, fuel: selectedpump.fuel);
    final editedTransaction = Transaction(
      id: widget.transaction.id,
      quantity:double.parse(_quantityController.text),
      odometer:double.parse(_odometerController.text),
      date:widget.transaction.date,
      pump:pumpResponse,
      operator:widget.transaction.operator,
      vehicle:selectedVehicle

    );
    ManageTransactionService manageTransactionService=ManageTransactionService();
    try {
      await manageTransactionService.updateTransaction(editedTransaction.id,editedTransaction.pump.id,editedTransaction.vehicle.id,editedTransaction.quantity,editedTransaction.odometer);
      Navigator.pop(context, editedTransaction); // Pass edited company object back to the previous screen
    } catch (e) {
      // Handle error
      print("Error updating transaction: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update transaction"),
      ));
    }
  }
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

}
