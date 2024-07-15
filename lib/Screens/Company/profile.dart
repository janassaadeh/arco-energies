import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Provider/car_provider.dart';
import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Company/Cars.dart';
import 'package:company_pages/Screens/Company/Company%20Details.dart';
// import 'package:company_pages/Widgets/MyCars.dart';
import 'package:company_pages/Screens/Company/my_transactions.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
//
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/deposit_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/profile/link.dart';

class Profile extends StatefulWidget {
  dynamic company;
  dynamic imageData;
  dynamic cars;
  List<dynamic> mergeAndSorted;

  Profile(
      {required this.company,
      required this.imageData,
      required this.cars,
      required this.mergeAndSorted});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    @override
  void initState() {
    _refreshCombinedData();

  }
  AuthenticationService authenticationService = AuthenticationService();

 Future<void> _refreshCombinedData() async {
    print('Refreshing combined data...');
    try {
      // Fetch new data


      List<Transaction> transactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;
      List<DepositReceipt> deposits =
          Provider.of<DepositProvider>(context, listen: false).cachedDeposits;
      // Update cached transactions and deposits

      List<dynamic> combinedList = [...transactions, ...deposits];
      combinedList.sort((a, b) {
        DateTime aDate = a is Transaction
            ? DateTime.parse(a.date)
            : DateTime.parse(a.timestamp);
        DateTime bDate = b is Transaction
            ? DateTime.parse(b.date)
            : DateTime.parse(b.timestamp);
        return bDate.compareTo(aDate);
      });
      setState(() {
        widget.mergeAndSorted = combinedList;
      });
      _getCars();
      print('Data refreshed successfully');
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }
  Future<void> _getCars() async {
    VehicleCompanyService vehicleService = VehicleCompanyService();
    final dynamic carslist =
        await vehicleService.getVehiclesForCompany(widget.company.id);
    setState(() {
      widget.cars = carslist;
    });
      CarProvider carProvider =
          Provider.of<CarProvider>(context, listen: false);
carProvider.setCarList(carslist);
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
         backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.notifications,
              size: 37,
              color:Color(0xff003D5B),
            ),
          ),
        ],
      ),
      body:
    (widget.company == null)
        ? Container()
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                widget.company.imageId == ''
                    ? CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 62,
                        child:
                            Image.asset("assets/images/buisness_profile.png"))
                    : widget.imageData != null
                        ? ClipOval(
                            child: Image.memory(
                              widget.imageData!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : ClipOval(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 120,
                                height: 120,
                                color: Colors
                                    .white, // You can change this color to match your background
                              ),
                            ),
                          ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    // Figma Flutter Generator CompanynameWidget - TEXT

                    Text(
                      widget.company.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          height: 1),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      '+961 ${widget.company.phone}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffA9A9AC),
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      color: Color(0xffF2F2F7),
                      width: double.infinity,
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 22),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 122),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.company.email,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contact Name",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.company.contactName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.company.location,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Color(0xffF2F2F7),
                      width: double.infinity,
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 22),
                        child: Text(
                          "Profile Details",
                          style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 122),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyCars(company: widget.company, cars: widget.cars),
                                ),
                              );
                            },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22, right: 22),
                        child: Container(
                          color: Colors.transparent, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/car_w.png',
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Cars',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 5),
                  GestureDetector(
  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllTransactions(
                                    mergedAndSorted: widget.mergeAndSorted,
                                    company: widget.company,
                                  )));
                    },
  child: Padding(
    padding: const EdgeInsets.only(left: 22, right: 22),
    child: Container(
      color: Colors.transparent, // Ensure the entire area is tappable
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/Dollar Coin blue.png',
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ],
      ),
    ),
  ),
),


                    SizedBox(height: 15),
                    Container(
                      color: Color(0xffF2F2F7),
                      width: double.infinity,
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 22),
                        child: Text(
                          "Account",
                          style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 122),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
GestureDetector(
                        // onTap: (){
                        onTap: () async {
                          await authenticationService.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      child: Container(
                          color: Colors.transparent, 

                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logout.png',
                                    color: Colors.black,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1),
                                  ),
                                ],
                              ),
                              // Icon(Icons.arrow_forward_ios,size: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ));
  }
}
