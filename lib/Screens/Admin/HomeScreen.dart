import 'dart:typed_data';

import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Provider/operator_provider.dart';
import 'package:company_pages/Provider/reward_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Companies.dart';
import 'package:company_pages/Screens/Admin/NFC_Car_Wrte.dart';
import 'package:company_pages/Screens/Admin/Rewards/rewards%20all.dart';
import 'package:company_pages/Screens/Operator/Home/Edit%20Fuel%20Prices/admin_edit_prices_pop_up.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Widgets/shimmer.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/shifts.dart';

import 'package:flutter/material.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Services/Auth/AuthenticationService.dart';
import '../../Widgets/Home/features.dart';
import '../Auth/Login.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart'
    as company;
import 'package:company_pages/Models/notification.dart' as not;

import '../../../Screens/Admin/ManageOperators/operator_model.dart' as op;
import 'ManageOperators/operators.dart';

class AdminHomeScreen extends StatefulWidget {
  List<op.Operator> operators;

  List<company.Company> companies;
  List<Reward> rewards;
  dynamic admin;
  dynamic imageData;
  final List<Pump> pumps;
  final List<Vehicle> cars;
  AdminHomeScreen(
      {required this.companies,
      required this.admin,
      required this.operators,
      required this.imageData,
      required this.pumps,
      required this.cars,
      required this.rewards});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  AuthenticationService authenticationService = AuthenticationService();

  late Future<List<Fuel>> fuelListFuture;

  final FuelService fuelService = FuelService();

  @override
  void initState() {
    super.initState();
    fuelListFuture = _fetchFuels();

  }

  Future<List<Fuel>> _fetchFuels() async {
    try {
      List<Fuel> cachedNotifications =
          Provider.of<FuelPricesProvider>(context, listen: false).cachedFuels;

      if (cachedNotifications.isNotEmpty) {
        return cachedNotifications;
      } else {
        final List<Fuel> fuels = await fuelService.getAllFuels();
        // Cache fetched pumps
        Provider.of<FuelPricesProvider>(context, listen: false).cachedFuels =
            fuels;
        return fuels;
      }
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }
  Future<void> updateNotificationCount() async {
    // Get the initial notification count when the widget initializes
    List<not.Notification> notifications =
        await Provider.of<FuelPricesProvider>(context, listen: false)
            .getNotifications();
    // setState(() {
    //   _notificationCount = notifications.length;
    // });
  }
  Future<void> _refreshfuelPrices() async {
    setState(() {
      fuelListFuture = fuelService.getAllFuels();
    });

    // Update cached fuels in FuelPricesProvider
    List<Fuel> updatedFuels = await fuelService.getAllFuels();
    Provider.of<FuelPricesProvider>(context, listen: false).cachedFuels =
        updatedFuels;
        updateNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    FuelPricesProvider fuelPricesProvider= Provider.of<FuelPricesProvider>(context, listen: false);

    return SingleChildScrollView(
      child:  RefreshIndicator(
            onRefresh: _refreshfuelPrices,
        child: Column(
          children: [
           
           
      //                   Padding(
      //                       padding:
      //                           const EdgeInsets.only(left: 18, right: 18.0, top: 18),
      //                       child: 
      //                                          widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
      //         ? Shimmer.fromColors(
      //                     baseColor: Colors.grey[300]!,
      //                     highlightColor: Colors.grey[100]!,
      //                     child: Container(
      //                       width: 403.64825439453125,
      //                       height: 130,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(
      //                             20.0), // Adjust the radius as needed
      //                       ),
      //                       // You can change this color to match your background
      //                     ),
      //                   )
          
      //         : 
      //                       Container(
      //                         height: 130,
      //                         width: MediaQuery.of(context).size.width,
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(20),
      //                           gradient: const LinearGradient(
      //                             begin: Alignment.topLeft,
      //                             end: Alignment.bottomRight,
      //                             colors: [
      //                               Color.fromRGBO(2, 91, 135, 1),
      //                               Color.fromRGBO(0, 61, 91, .6),
      //                             ], // Gradient colors
      //                           ),
      //                         ),
      //                         child: Stack(
      //                           children: [
                      
           
      //                             Positioned(
      //                               top: 20,
      //                               left: 20,
      //                               child: Text(
      //   widget.admin == null
      //     ? ''
      //     : 'Hello, ${widget.admin.name.length > 10 ? widget.admin.name.substring(0, 10) + '...' : widget.admin.name}',
      //   style: const TextStyle(
      //     color: Colors.white,
      //     fontSize: 24,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      
      //                             ),
      
      //                             Positioned(
      //                               bottom: 20,
      //                               right: 20,
      //                               child: widget.admin.imageId == ''
      //                                   ? Image.asset("assets/images/User Shield.png")
      //                                   : widget.imageData != null
      //                                       ? ClipOval(
      //                                           child: Image.memory(
      //                                             widget.imageData!,
      //                                             fit: BoxFit.cover,
      //                                             width: 90,
      //                                             height: 90,
      //                                           ),
      //                                         )
      //                                       : ClipOval(
      //                                           child: Shimmer.fromColors(
      //                                             baseColor: Colors.grey[300]!,
      //                                             highlightColor: Colors.grey[100]!,
      //                                             child: Container(
      //                                               width: 90,
      //                                               height: 90,
      //                                               color: Colors
      //                                                   .white, // You can change this color to match your background
      //                                             ),
      //                                           ),
      //                                         ),
      //                             ),
      //                           ],
      //                         ),
      //                       )
      //                       // horizontalGradientBox(context, widget.admin==null?'':'Hello, ${widget.admin.name}', "assets/images/User Shield.png"),
      //                       ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   // padding: const EdgeInsets.all(18.0),
            //   padding: const EdgeInsets.only(left: 18, right: 18.0),
      
            //   child:  Align(
            //     alignment: Alignment.centerLeft,
            //     child:
                
            //      widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
      
            // ? Shimmer.fromColors(
            //     baseColor: Colors.grey[300]!,
            //     highlightColor: Colors.grey[100]!,
            //     child: Container(
            //       width: 100.64825439453125,
            //       height: 20,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(
            //             12.0), // Adjust the radius as needed
            //       ),
            //       // You can change this color to match your background
            //     ),
            //   )
            // : 
            //      Text(
            //       "Features",
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Color(0xffA9A7A7),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Column(
              children: [
               Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20,top: 20),
              child: Container(
                        height: MediaQuery.sizeOf(context).height*0.7,
                        width: MediaQuery.sizeOf(context).width*0.9,
                        child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 35.0, // Spacing between columns
                        mainAxisSpacing: 35.0, // Spacing between rows
                      ),  
                                children: [
                        // SizedBox(
                        //   width: 18,
                        // ),
                                widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
                      ? RoundedContainerWithShimmer(
                          width: 152,
                          height: 135,
                        ):
                       GestureDetector(
                    onTap: () async {
                      var role = await authenticationService.getRole();
                      print(role);
                        OperatorProvider operatorProvider =
                          Provider.of<OperatorProvider>(context, listen: false);
                      // operatorProvider.setOperatorList(operators);
                              final companies = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   Operators(
                            operators: operatorProvider.operatorList,
                            cars: widget.cars,
                            pumps: widget.pumps,
                          ),),
                                    );
                                    if (companies != null) {
                  setState(() {
                    widget.operators=companies;
                     // Add a new TickerProvider
                  });
                                    }
                    },
                          child: Features(
                            color:  Color.fromRGBO(72, 177, 126, 1),
                            imageAsset: "assets/images/Online Support.png",
                            text: "Manage Operator",
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                 widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty                          ? RoundedContainerWithShimmer(
                          width: 152,
                          height: 135,
                        ):
                        GestureDetector(
                          onTap: ()async {
                            // push(
                            //     Companies(
                            //       companies: widget.companies,
                            //       allcars: widget.cars,
                            //       pumps: widget.pumps,
                            //     ),
                            //     context);
                            CompanyProvider companyProvider =
                          Provider.of<CompanyProvider>(context, listen: false);
                                final companies = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Companies(companies:companyProvider.companyList,
                                  allcars: widget.cars,
                                  pumps: widget.pumps,)),
                                    );
                                    if (companies != null) {
                  setState(() {
                  widget.companies=companies;
                   // Add a new TickerProvider
                  });
                                    }
                          },
                          child: Features(
                            color: const Color.fromRGBO(237, 174, 73, 1),
                            imageAsset: "assets/images/Budget.png",
                            text: "Manage Companies",
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                 widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty                          ? RoundedContainerWithShimmer(
                          width: 152,
                          height: 135,
                        ):
                        GestureDetector(
                          onTap: () {
                            push(WriteCarId(), context);
                          },
                          child: Features(
                            color: const Color.fromRGBO(0, 121, 140, 1),
                            imageAsset: "assets/images/cars.png",
                            text: "Write Car ID To NFC",
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        
                 widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty                          ? RoundedContainerWithShimmer(
                          width: 152,
                          height: 135,
                        ):
                        GestureDetector(
                          onTap: ()async {
                               RewardProvider rewardProvider =
                          Provider.of<RewardProvider>(context, listen: false);
                      // rewardProvider.setRewardList(rewards);
                                     final companies = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllRewards(rewards:rewardProvider.rewardList)),
                                    );
                                    if (companies != null) {
                  setState(() {
                  widget.rewards=companies;
                   // Add a new TickerProvider
                  });
                                    }
                                
                          },
                          child: 
                          
                          Features(
                            color: Color.fromRGBO(209, 73, 91, 1),
                            imageAsset: "assets/images/Gift.png",
                            text: "Manage Rewards",
                          ),
                        ),
                        // const SizedBox(
                        //   width: 18,
                        // ),
                            widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty                          ? RoundedContainerWithShimmer(
                          width: 152,
                          height: 135,
                        ):
                       GestureDetector(
                onTap: () {
                  push(ShiftsList(), context);
                },
                          child: 
                          
                          Features(
                            color: Color.fromRGBO(73, 73, 209, 1),
                            imageAsset: "assets/images/edit-price.png",
                            text: "View Shifts",
                          ),
                        ),
                  
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              // padding: const EdgeInsets.all(18.0),
              padding: const EdgeInsets.only(left: 20, right: 20.0),
      
              child:  Align(
                alignment: Alignment.centerLeft,
                child: 
                                                widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
      
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100.64825439453125,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                  ),
                  // You can change this color to match your background
                ),
              )
            : 
                Text(
                  "Fuel Prices",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffA9A7A7),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20),
              child:
                                                widget.admin == null && fuelPricesProvider.cachedFuelPrices.isEmpty
          ? Column(
            children: [
          // SizedBox(height: 10,),
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 403.64825439453125,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                  ),
                  // You can change this color to match your background
                ),
              ),
          )
          ,SizedBox(height: 10,),
           Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 403.64825439453125,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                  ),
                  // You can change this color to match your background
                ),
        )),
        SizedBox(height: 10,),
         Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 403.64825439453125,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                  ),
                  // You can change this color to match your background
                ),
              ),)
      
            ],
          )
          
          : 
               Container(
                height: 300,
                child: FutureBuilder<List<Fuel>>(
                  future: fuelListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
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
      
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AdminEditPricesPopUp();
                                },
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0),
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
                                            color: Colors.grey
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(8.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            color: Color.fromARGB(
                                                255, 1, 14, 72),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
