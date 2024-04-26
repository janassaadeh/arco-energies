
import 'dart:typed_data';

import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Companies.dart';
import 'package:company_pages/Screens/Admin/NFC_Car_Wrte.dart';
import 'package:company_pages/Screens/Company/MyCars.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Screens/Admin/qr_code.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/horizontal_gradient_box.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:shimmer/shimmer.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Services/Auth/user_service.dart'as User;
import '../../Widgets/Home/Cash.dart';
import '../../Widgets/Home/features.dart';
import '../../Widgets/Home/recentTransaction.dart';
import '../Auth/Login.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart' as company;

import '../../../Screens/Admin/ManageOperators/operator_model.dart'as op;
import 'ManageOperators/operators.dart';

class AdminHomeScreen extends StatefulWidget {
  List<op.Operator> operators;
    
    List <company.Company> companies;
    dynamic admin;
    dynamic imageData;
    AdminHomeScreen({required this.companies,required this.admin,required this.operators,required this.imageData});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
    AuthenticationService authenticationService=AuthenticationService();

    late Future<List<Fuel>> fuelListFuture;

  final FuelService fuelService = FuelService();


  @override
  void initState() {
    super.initState();
    fuelListFuture = _fetchFuels();

  }

  Future<List<Fuel>> _fetchFuels() async {
    try {
      return await fuelService.getAllFuels();
    } catch (e) {
      print('Error fetching fuels: $e');
      return []; // Return empty list on error
    }
  }
 
  @override
  Widget build(BuildContext context) {
    
    return 
    widget.admin==null?Container():
    SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:18,right:18.0,top: 18),


              child: 
              
                Container(
    height: 130,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(2, 91, 135, 1),
          Color.fromRGBO(0, 61, 91, .6),
        ], // Gradient colors
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Text(
            widget.admin==null?'':'Hello, ${widget.admin.name}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
  bottom: 20,
  right: 20,
  child: 
  
  widget.admin.imageId==''?
      Image.asset("assets/images/User Shield.png"):
  widget.imageData != null
      ? 
      
      
      ClipOval(
          child: 
          Image.memory(
            widget.imageData!,
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
        )
      : ClipOval(
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 90,
              height: 90,
              color: Colors.white, // You can change this color to match your background
            ),
          ),
      ),
),

      ],
    ),
  )
              // horizontalGradientBox(context, widget.admin==null?'':'Hello, ${widget.admin.name}', "assets/images/User Shield.png"),
            ),
            const SizedBox(height: 30,),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.only(left:18,right:18.0),

              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Features",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 20,),
      
            Column(
              children: [
                GestureDetector(
                  onTap: ()async{
                    var role=await authenticationService.getRole();
                    print(role);
                    push(Operators(operators: widget.operators), context);
                  },
                  child: Container(
                    height: 135,width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,          
                      children: [
                        SizedBox(width: 18,),
                    Features(
                    color: const Color.fromRGBO(209, 73, 91, 1),
                    imageAsset: "assets/images/Online Support.png",
                    text: "Manage Operator",
                  ),
                  const SizedBox(width: 10,),
                    GestureDetector(
                      onTap:(){
                          push(Companies(companies: widget.companies), context);
                      },
                      child: Features(
                      color: const Color.fromRGBO(237, 174, 73, 1),
                      imageAsset: "assets/images/Budget.png",
                      text: "Manage Companies",
                                  ),
                    ),
                  const SizedBox(width: 10,),
                        
                    GestureDetector(
                      onTap:()async{
//  push(QRViewExample(),context);
       final qrText = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRViewExample()),
            );
            if(qrText!=null){
              print("qrText $qrText");
              List<String> parts = qrText.split(" ");
              RewardService rewardService=RewardService();
              rewardService.redeemReward(parts[1], parts[0]);
            }
                      },
                      child: Features(
                      color: const Color.fromRGBO(0, 121, 140, 1),
                      imageAsset: "assets/images/Qr Code.png",
                      text: "Scan QR for company rewards.",
                                      ),
                    ),
                    
                        SizedBox(width: 18,),
                        GestureDetector(
                      onTap:(){
                          push(WriteCarId(), context);
                      },
                      child: Features(
                      color: const Color.fromRGBO(237, 174, 73, 1),
                      imageAsset: "assets/images/Budget.png",
                      text: "Write Car ID To NFC",
                                  ),
                    ),
                  const SizedBox(width: 10,),
                      ],
                    ),
                      
                  ),
                ),
              ],
            ),
                        const SizedBox(height: 30,),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.only(left:18,right:18.0),

              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Daily Fuel Prices",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
            ),
            const SizedBox(height: 10,),
         
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 350,
                child: FutureBuilder<List<Fuel>>(
                  future: fuelListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(
                          child: Text('Failed to load fuel data'));
                    } else {
                      List<Fuel> fuels = snapshot.data!;
                      return ListView.builder(
                        itemCount: fuels.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Fuel fuel = fuels[index];
                          double? recentPrice =
                              _getMostRecentFuelPrice(fuel.prices);
            
                          return Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.water_drop,
                                        size: 24,
                                        color: fuel.description
                                                .toLowerCase()
                                                .contains("fuel")
                                            ? const Color.fromARGB(
                                                153, 3, 110, 42)
                                            : const Color.fromARGB(
                                                255, 204, 113, 79),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fuel.type,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        fuel.description,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        recentPrice != null
                                            ? '${recentPrice.toStringAsFixed(2)} \$/liter'
                                            : 'No price available',
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 1, 14, 72),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
      
      
          ],
        ),
      );
    
  }
  
  double? _getMostRecentFuelPrice(List<FuelPrice> prices) {
    if (prices.isNotEmpty) {
      return prices.last.price;
    }
    return null;
  }
}
