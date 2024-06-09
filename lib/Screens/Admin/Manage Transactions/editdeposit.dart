import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/pump_response.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Models/vehicle_response.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Transactions/transaction_cars.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/companies_deposit.dart';
import 'package:company_pages/Screens/Operator/Transactions/cars_list.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/Manage%20Accounts/manage%20transactions.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/Operator/pump_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/manage%20deposit.dart';
import 'package:company_pages/Widgets/Common/select.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:your_app_path_here/company_model.dart';

import '../../../Widgets/Common/CustomButton.dart';
import '../../../Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Manage Fields.dart';
 // Import your Company model
List<String> paymentMethods = ['Check', 'Cash', 'Credit Card'];
class EditDeposit extends StatefulWidget {
  final DepositReceipt deposit; // Pass the Company object to the screen
  
  EditDeposit({required this.deposit});

  @override
  State<EditDeposit> createState() => _EditDepositState();
}

class _EditDepositState extends State<EditDeposit> {
  late TextEditingController _companyController;
  bool _saveOpChangesLoading = false;

  late TextEditingController _cashAmountController;

  late TextEditingController _paymentMethodController;
  List<Company> companyList = [];


  // late TextEditingController _phoneController;

  // late TextEditingController _balanceController;
   dynamic base64Image1;
  // List<Pump> pumpsObjects=[];
  // List<Vehicle> cars=[];

  int selectedPaymentMethod=0;
  late String selectedCompanyId;
  
  @override
  void initState() {
    super.initState();
    // _fetchPumps();
    selectedCompanyId=widget.deposit.companyId;
        _cashAmountController = TextEditingController(text: widget.deposit.cashAmount.toString());
    _paymentMethodController = TextEditingController(text: widget.deposit.paymentMethod.toString());
    _companyController = TextEditingController(text: selectedCompanyId);

    _fetchCompanies();
  }

  Future<void> _fetchCompanies() async {
    try {
      CompanyService companyService = CompanyService();
      List<Company> companies = await companyService.getAllCompanies();

      setState(() {
        companyList = companies;
      });

      CompanyProvider companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
      companyProvider.setCompanyList(companyList);
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
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
          child:  Text('Edit Deposit',style: TextStyle(
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
                      child: Text("Payment Method",style: TextStyle(
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
                                itemList:paymentMethods ,
                                selectedIndex: selectedPaymentMethod,
                                onItemSelected: (index) {
                                  setState(() {

                                    selectedPaymentMethod = index;
                                    _paymentMethodController.text=paymentMethods[index];

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
                      controller: _paymentMethodController,
                      imagePath: '',
                      hintText: "Payment Method",
                      enabled: false,
                    ),
                  ),
           
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Cash Amount",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  ManageFields(
                    controller: _cashAmountController,
                    imagePath: '',
                    hintText: "Cash Amount",
                    
                  ),
                  const SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.only(left:40.0,bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Company ID",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA9A7A7),
                                    ),),
                    ),
                  ),
                  GestureDetector(
                    
                    onTap: () async {
  final vehicle = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SelectCompanies(companies: companyList)),
  );
    if(vehicle!=selectedCompanyId){
        setState(() {
      _companyController.text = vehicle;
        selectedCompanyId=vehicle;

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
                      controller: _companyController,
                      imagePath: '',
                      hintText: "Company ID",
                      enabled:false
                    ),
                  ),

                 

                  const SizedBox(height: 40),
                  GestureDetector(
                    
                    onTap: () async{
                      
  void _saveChanges(BuildContext context) async {
                     setState(() {
      _saveOpChangesLoading = true;
    });
    final editedTransaction = DepositReceipt(
      id: widget.deposit.id,
      companyId:_companyController.text,
  companyEmail:widget.deposit.companyEmail,
   companyPhone:widget.deposit.companyPhone,
 companyName:widget.deposit.companyName,
  companyBalance:widget.deposit.companyBalance,
 companyContactName:widget.deposit.companyContactName,
 companyLocation:widget.deposit.companyLocation,
 adminId:widget.deposit.adminId,
 adminEmail:widget.deposit.adminEmail,
 adminPhone:widget.deposit.adminPhone,
 adminName:widget.deposit.adminName,
 adminDob:widget.deposit.adminDob,
 paymentMethod:_paymentMethodController.text,
 cashAmount:double.parse(_cashAmountController.text),
 timestamp:widget.deposit.timestamp
    );
    ManageDepositService manageDepositService=ManageDepositService();
    try {
      await manageDepositService.updateDeposit(editedTransaction.id,editedTransaction.companyId,editedTransaction.cashAmount,editedTransaction.paymentMethod);
      Navigator.pop(context, editedTransaction); // Pass edited company object back to the previous screen
  
                    setState(() {
      _saveOpChangesLoading = false;
    });
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
                    child: CustomButton(buttonText:  _saveOpChangesLoading?'':"Save"),
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
