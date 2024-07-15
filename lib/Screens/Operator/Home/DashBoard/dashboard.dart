import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Provider/shift_provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/SelectCompany.dart';
import 'package:company_pages/Screens/Admin/qr_code.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Home/Edit%20Fuel%20Prices/edit_prices_pop_up.dart';
import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
import 'package:company_pages/Screens/Operator/Transactions/new_transaction.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
// import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Services/Operator/shift_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:company_pages/Widgets/Home/features.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:company_pages/Services/Auth/user_service.dart' as User;
import 'package:company_pages/Models/notification.dart' as not;

import '../../../../Models/fuel_price.dart';
import '../../../../../../Widgets/Operator/sub_title.dart';

class DashBoard extends StatefulWidget {
  dynamic operator;
  dynamic imageData;
  DashBoard({Key? key, required this.imageData, required this.operator})
      : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Future<List<Fuel>> fuelListFuture;
  late Future<List<not.Notification>> notificationListFuture;

  final FuelService fuelService = FuelService();
  final FuelPricesService fuelPricesService = FuelPricesService();
  final NotificationService notificationService = NotificationService();
  final ShiftService shiftService = ShiftService();
  dynamic operator;

  late Future<List<Transaction>> transactions;
  late Future<List<DepositReceipt>> deposits;
  final TransactionService transactionService = TransactionService();
  final DepositService depositService = DepositService();
  List<dynamic> searchResults = [];

  bool isLoadingStartShift = false;
  bool isLoadingEndShift = false;

  @override
  void initState() {
    super.initState();
    fuelListFuture = _fetchFuels();
    _fetchUserData().then((_) => transactions = _fetchTransactions());
    _fetchUserData().then((_) => deposits = _fetchDeposits());
    _fetchUserData().then((_) => setupPushNotifications());
  }

  Future<void> _fetchUserData() async {
    try {
      User.UserService userService = User.UserService();
      dynamic userData = await userService.fetchUserData();
      setState(() {
        operator = userData;
      });
    } catch (e) {
      print('Error fetching operator data: $e');
    }
  }

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
    print("Operator ID: " + operator.id);

    final fuelPricesService = FuelPricesService();

    try {
      final allDeviceTokens = await fuelPricesService.getAllOpDeviceTokens();
      // Use the allDeviceTokens list
      print(allDeviceTokens);
    } catch (e) {
      print('Error: $e');
    }

    try {
      await notificationService.storeOperatorDeviceToken(operator.id, token!);
    } catch (e) {
      print('Failed to store device token: $e');
    }
  }

  Future<List<Transaction>> _fetchTransactions() async {
    try {
      List<Transaction> cachedTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;

      if (cachedTransactions.isNotEmpty) {
        return cachedTransactions
            .where(
                (transaction) => transaction.operator.id == widget.operator.id)
            .toList();
      } else {
        final List<Transaction> transactions =
            await transactionService.getTransactions();

        // Filter the transactions by operatorId
        final filteredTransactions = transactions
            .where(
                (transaction) => transaction.operator.id == widget.operator.id)
            .toList();

        Provider.of<TransactionProvider>(context, listen: false)
            .cachedTransactions = filteredTransactions;

        return filteredTransactions;
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<List<DepositReceipt>> _fetchDeposits() async {
    try {
      List<DepositReceipt> cachedDeposits =
          Provider.of<DepositProvider>(context, listen: false).cachedDeposits;

      if (cachedDeposits.isNotEmpty) {
        return cachedDeposits;
      } else {
        final List<DepositReceipt> deposits = await depositService
            .getCashAdditionEventsByAdminId(widget.operator.id);

        Provider.of<DepositProvider>(context, listen: false).cachedDeposits =
            deposits;
        return deposits;
      }
    } catch (e) {
      throw Exception('Failed to fetch deposits: $e');
    }
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

  Future<void> _refreshfuelPrices() async {
    setState(() {
      fuelListFuture = fuelService.getAllFuels();
    });

    List<Fuel> updatedFuels = await fuelService.getAllFuels();
    Provider.of<FuelPricesProvider>(context, listen: false).cachedFuels =
        updatedFuels;
  }

  void _startShift() async {
    setState(() {
      isLoadingStartShift = true;
    });
    try {
      DateTime startTime = DateTime.now();

      await shiftService.startShift(startTime);

      // Provider.of<ShiftProvider>(context, listen: false)
      //     .setStartShiftTime(DateTime.now().toIso8601String());
    } catch (e) {
      print('Error starting shift: $e');
    } finally {
      setState(() {
        isLoadingStartShift = false;
      });
    }
  }

  void _endShift() async {
    setState(() {
      isLoadingEndShift = true;
    });
    try {
      DateTime endTime = DateTime.now();
      print('End time DateTime: $endTime');

      String endTimeString = endTime.toIso8601String();
      print('End time string: $endTimeString');

      // Provider.of<ShiftProvider>(context, listen: false)
      //     .setEndShiftTime(endTimeString);

      // List<String> transactionsIds =
      //     Provider.of<ShiftProvider>(context, listen: false).transactionsIds;
      // List<String> depositsIds =
      //     Provider.of<ShiftProvider>(context, listen: false).depositsIds;

      // // Parse the start time from the provider
      // DateTime startTime = DateTime.parse(
      //     Provider.of<ShiftProvider>(context, listen: false).startShiftTime);

      // // Create Shift
      // await shiftService.createShift(
      //     startTime, endTime, transactionsIds, depositsIds);

      await shiftService.endShift(endTimeString);

      // Provider.of<ShiftProvider>(context, listen: false).resetShiftTimes();
    } catch (e) {
      print('Error parsing date: $e');
    } finally {
      setState(() {
        isLoadingEndShift = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FuelPricesProvider fuelPricesProvider =
        Provider.of<FuelPricesProvider>(context, listen: false);

    // print(Provider.of<ShiftProvider>(context, listen: false).isDuringShift);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshfuelPrices,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // horizontalGradientBox(context, "Welcome Back\n      Ashraf",
              //     "assets/images/gas-pump.png"),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18.0, top: 18),
                child: widget.operator == null &&
                        fuelPricesProvider.cachedFuelPrices.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 403.64825439453125,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                          ),
                          // You can change this color to match your background
                        ),
                      )
                    : Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(2, 91, 135, 1),
                              Color.fromRGBO(0, 61, 91, .6),
                            ], // Gradient colors
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 12.0),
                            //   child: Text(
                            //     widget.operator == null
                            //         ? ''
                            //         : '${widget.operator.name.split(' ')[0]}\'s Shift',
                            //     style: const TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: isLoadingStartShift
                                      ? null
                                      : () {
                                          _startShift();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(72, 177, 126, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoadingStartShift
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        )
                                      : Text(
                                          // Provider.of<ShiftProvider>(context,
                                          //             listen: false)
                                          //         .isDuringShift
                                          //     ? 'During Shift..'
                                              // :
                                               'Start Shift',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: isLoadingEndShift
                                      ? null
                                      : () {
                                          _endShift();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(255, 73, 73, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoadingEndShift
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'End Shift',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),

              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 18, right: 18.0),
              //   child: widget.operator == null &&
              //           fuelPricesProvider.cachedFuelPrices.isEmpty
              //       ? Shimmer.fromColors(
              //           baseColor: Colors.grey[300]!,
              //           highlightColor: Colors.grey[100]!,
              //           child: Container(
              //             width: 100.64825439453125,
              //             height: 20,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(
              //                   12.0), // Adjust the radius as needed
              //             ),
              //             // You can change this color to match your background
              //           ),
              //         )
              //       : subTitle('Features'),
              // ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20),
                child: Container(
                                height: MediaQuery.sizeOf(context).height*0.45,
                                width: MediaQuery.sizeOf(context).width*0.9,
                                child: GridView(
                                  physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns in the grid
                                crossAxisSpacing: 35.0, // Spacing between columns
                                mainAxisSpacing: 35.0, // Spacing between rows
                              ),  
                    children: [
                      // SizedBox(
                      //   width: 18,
                      // ),
                      widget.operator == null &&
                              fuelPricesProvider.cachedFuelPrices.isEmpty
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SelectCompany();
                                  },
                                );
                              },
                              child: Features(
                                color: Color.fromRGBO(72, 177, 126, 1),
                                imageAsset: "assets/images/edit-price.png",
                                text: "Start New Cash In",
                              ),
                              
                              //  gradientBox(
                              //   'Daily Fuel Prices Editing',
                              //   'assets/images/edit-price.png',
                              //   const Color.fromRGBO(72, 177, 126, 1),
                              //   const Color.fromRGBO(73, 209, 111, 0.6),
                              //   context,
                              // ),
                            ),
                      // const SizedBox(width: 10),
                          widget.operator == null &&
                              fuelPricesProvider.cachedFuelPrices.isEmpty
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : GestureDetector(
                              onTap: () async {
                                push(NewTransaction(operator: operator,), context);
                              },
                              child: Features(
                                color: Color.fromRGBO(209, 73, 91, 1),
                                imageAsset: "assets/images/cars.png",
                                text: "View All Transactions",
                              ),
                              // gradientBox(
                              //   'Start A New Transaction',
                              //   'assets/images/cars.png',
                              //   const Color.fromRGBO(232, 169, 69, 1),
                              //   const Color.fromRGBO(237, 165, 49, .6),
                              //   context,
                              // ),
                            ),
                      widget.operator == null &&
                              fuelPricesProvider.cachedFuelPrices.isEmpty
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : GestureDetector(
                              onTap: () async {
                                push(CarAccess(), context);
                              },
                              child: Features(
                                color: Color.fromRGBO(232, 169, 69, 1),
                                imageAsset: "assets/images/cars.png",
                                text: "Start A New Transaction",
                              ),
                              // gradientBox(
                              //   'Start A New Transaction',
                              //   'assets/images/cars.png',
                              //   const Color.fromRGBO(232, 169, 69, 1),
                              //   const Color.fromRGBO(237, 165, 49, .6),
                              //   context,
                              // ),
                            ),
                      // SizedBox(
                      //   width: 10,
                      // ),
              
              // GestureDetector part of the code
                      widget.operator == null &&
                              fuelPricesProvider.cachedFuelPrices.isEmpty
                          ? RoundedContainerWithShimmer(
                              width: 152,
                              height: 135,
                            )
                          : GestureDetector(
                              onTap: () async {
                                // Navigate to QRViewExample and wait for the result
                                final qrText = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRViewExample()),
                                );
              
                                void _showErrorDialog(String errorMessage) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ErrorPopUp(
                                        text: errorMessage,
                                      );
                                    },
                                  );
                                }
              
                                if (qrText != null) {
                                  print("qrText $qrText");
                                  List<String> parts = qrText.split(" ");
                                  RewardService rewardService = RewardService();
              
                                  try {
                                    // Attempt to redeem reward
                                    await rewardService.redeemReward(
                                        parts[1], parts[0]);
                                    if (mounted) {
                                      _showErrorDialog(
                                          'Reward has been redeemed successfully !');
                                    }
                                  } catch (e) {
                                    // Show error dialog on failure
                                    if (mounted) {
                                      _showErrorDialog(
                                          'Insufficient points balance to redeem the reward');
                                    }
                                  }
                                }
                              },
                              child: Features(
                                color: const Color.fromRGBO(0, 121, 140, 1),
                                imageAsset: "assets/images/Qr Code.png",
                                text: "Scan QR for company rewards",
                              ),
                            ),
                      // SizedBox(
                      //   width: 18,
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: widget.operator == null &&
                        fuelPricesProvider.cachedFuelPrices.isEmpty
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
                    : subTitle('Fuel Prices'),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20),
                child: widget.operator == null &&
                        fuelPricesProvider.cachedFuelPrices.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                          SizedBox(
                            height: 10,
                          ),
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
                        ],
                      )
                    : Container(
                        height: 350,
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
                                          return const EditPricesPopUp();
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
                                                      ? '\$/ltr  ${recentPrice.toStringAsFixed(2)} '
                                                      : 'No price available',
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 1, 14, 72),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
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
