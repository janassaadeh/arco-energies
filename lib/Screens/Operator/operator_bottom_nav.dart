// import 'dart:html';
import 'dart:typed_data';

import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Screens/Operator/Home/DashBoard/dashboard.dart';
import 'package:company_pages/Screens/Operator/Profile/operator_profile.dart';
// import 'package:company_pages/Services/Auth/AuthenticationService.dart';
// import 'package:company_pages/Services/Auth/user_service.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'Transactions/new_transaction.dart';
// import '../../../Screens/Admin/Manage Companies/Company_Model.dart';
import 'package:company_pages/Services/Auth/user_service.dart' as User;

import '../../../Screens/Admin/Manage Companies/Company_Model.dart' as company;
import '../../../Screens/Admin/ManageOperators/operator_model.dart' as op;

class Operator extends StatefulWidget {
  const Operator({super.key});

  @override
  State<Operator> createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  dynamic operator;
  dynamic _imageData;
 List<company.Company> _companies =
      []; 
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
_fetchCompanies();
    _fetchUserData().then((_) {
      // Call _getDepositList() only after _fetchUserData() completes
      _fetchImage();
    });
  }

  Future<void> _fetchUserData() async {
    try {
      User.UserService userService = User.UserService();
      dynamic userData = await userService.fetchUserData();
      setState(() {
        operator = userData;
      });
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching operator: $e');
    }
  }

  Future<void> _fetchCompanies() async {
    try {
      // AuthenticationService authenticationService = AuthenticationService();
      CompanyService companyService = CompanyService();
      List<company.Company> companies = await companyService.getAllCompanies();

      setState(() {
        _companies = companies;
      });
      for (int i = 0; i < _companies.length; i++) {
        print(_companies[i]);
      }
      CompanyProvider companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
      companyProvider.setCompanyList(_companies);
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
  }

  Future<void> _fetchImage() async {
    try {
      ImageService imageService = ImageService();

      if (operator.imageId != null) {
        Uint8List imageData =
            await imageService.getImageFromId(operator.imageId);
        if (imageData != null) {
          setState(() {
            _imageData = imageData;
          });
        }
      } else {
        setState(() {
          _imageData = 'no image';
        });
        print('Image data is null.');
      }
    } catch (e) {
      // Handle errors
      print('Failed to fetch image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
          // leading: Container(),
          leading: 
          operator == null?
          Padding(
                                          padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 20),
                                          child: ClipOval(
                                              child:Container(
                                                color:Colors.grey[300],
                                                child: Icon(Icons.person,color:Colors.grey),
                                              )
                                            ),
                                        )
          :
          operator.imageId == ''
                                  ? GestureDetector(
                                    onTap: (){
                                                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>                                             Profile(
          operator: operator,
          imageData: _imageData,
          // operator: operatorProvider.operator,
        ))
                                          );
                                    },
                                    child:   Padding(
                                          padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 20),
                                          child: ClipOval(
                                              child:Container(
                                                color:Colors.grey[300],
                                                child: Icon(Icons.person,color:Colors.grey),
                                              )
                                            ),
                                    ))
                                  : _imageData != null
                                      ? GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>                                             Profile(
          operator: operator,
          imageData: _imageData,
          // operator: operatorProvider.operator,
        ))
                                          );

                                    },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 20),
                                          child: ClipOval(
                                              child: Container(
                                                width: 25,
                                                height: 20,
                                                child: Image.memory(_imageData,fit: BoxFit.cover,),
                                              )
                                            ),
                                        ),
                                      )
                                      : Padding(
                                        padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 20),
                                        child: ClipOval(
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: 25,
                                                height: 20,
                                                color: Colors
                                                    .white, // You can change this color to match your background
                                              ),
                                            ),
                                          ),
                                      ),
                       
        // toolbarHeight: 80,
        // leading: Container(),
        title: Center(
          child: Container(
          height: 70,
          width:170,
          child: Image.asset(fit:BoxFit.fill,"assets/images/arco_logo.png",color: Colors.white,)),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [
         
              Icon(
                  Icons.notifications,
                  size: 30,
                  color:Color(0xff003D5B),
                ),
              ]
      ),
      body: _getBody(),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: const Color(0xff003D58),
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: [
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         "assets/images/Gaspump.png",
      //         width: 28,
      //         color: _currentIndex == 1
      //             ? const Color(0xff003D58)
      //             : const Color.fromARGB(255, 114, 113, 113),
      //       ),
      //       label: 'Transactions',
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return DashBoard(
          operator: operator,
          imageData: _imageData,
        );
      // case 1:
      //   return  NewTransaction(operator:operator);
      // case 2:
      //   return Profile(
      //     operator: operator,
      //     imageData: _imageData,
      //     // operator: operatorProvider.operator,
      //   );
      default:
        return Container();
    }
  }
}
