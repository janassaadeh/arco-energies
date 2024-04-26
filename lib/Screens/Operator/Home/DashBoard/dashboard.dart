import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Home/Edit%20Fuel%20Prices/edit_prices_pop_up.dart';
import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
// import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/fuel_price.dart';
import 'package:company_pages/Widgets/Operator/gradient_box.dart';
import '../../../../../../../../Widgets/Operator/horizontal_gradient_box.dart';
import '../../../../../../Widgets/Operator/sub_title.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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

  Future<void> _refreshfuelPrices() async {
    setState(() {
      fuelListFuture = fuelService.getAllFuels();
    });
  }

  @override
  Widget build(BuildContext context) {
    // AuthenticationService authenticationService = AuthenticationService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              horizontalGradientBox(context, "Welcome Back\n      Ashraf",
                  "assets/images/gas-pump.png"),
              const SizedBox(height: 15),
              subTitle('Features'),
              const SizedBox(height: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const EditPricesPopUp();
                        },
                      );
                    },
                    child: gradientBox(
                      'Daily Fuel Prices Editing',
                      'assets/images/edit-price.png',
                      const Color.fromRGBO(72, 177, 126, 1),
                      const Color.fromRGBO(73, 209, 111, 0.6),
                      context,
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () async {
                      push(CarAccess(), context);
                    },
                    child: gradientBox(
                      'Start A New Transaction',
                      'assets/images/cars.png',
                      const Color.fromRGBO(232, 169, 69, 1),
                      const Color.fromRGBO(237, 165, 49, .6),
                      context,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              subTitle('Fuel Prices'),
              const SizedBox(height: 10),
              Container(
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
                      return RefreshIndicator(
                        onRefresh: _refreshfuelPrices,
                        child: ListView.builder(
                          itemCount: fuels.length,
                          // physics: const NeverScrollableScrollPhysics(),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                        ),
                      );
                    }
                  },
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
