import 'package:flutter/material.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Transactions/pump_selection.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Widgets/Operator/car_option.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:provider/provider.dart';

class CarsList extends StatefulWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  late Future<List<Vehicle>> _vehiclesFuture;
  final VehicleService vehicleService = VehicleService();
  Vehicle? _selectedVehicle;
  final TextEditingController _searchController = TextEditingController();
  List<Vehicle> searchResults = [];

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _fetchVehicles();
  }

  Future<List<Vehicle>> _fetchVehicles() async {
    try {
      List<Vehicle> cachedVehicles =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedVehicles;

      if (cachedVehicles.isNotEmpty) {
        return cachedVehicles;
      } else {
        final List<Vehicle> vehicles = await vehicleService.getVehicles();
        // Cache fetched pumps
        Provider.of<TransactionProvider>(context, listen: false)
            .cachedVehicles = vehicles;
        return vehicles;
      }
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  Future<void> _refreshVehicles() async {
    setState(() {
      _vehiclesFuture = vehicleService.getVehicles();
    });
  }

  void _searchVehicles(String query) async {
    List<Vehicle> allVehicles = await _vehiclesFuture;

    setState(() {
      searchResults = allVehicles.where((vehicle) {
        return vehicle.color.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.plateNumber.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.driverName.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.model.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
        leading: Container(),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All Cars',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 40,
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
      backgroundColor: const Color(0xff003D58),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(height: 120, color: const Color(0xff003D58)),
                Container(
                  height: screenSize.height * .55,
                  color: Colors.white,
                  child: FutureBuilder<List<Vehicle>>(
                    future: _vehiclesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Vehicle>? vehicles = snapshot.data;
                        if (vehicles != null && vehicles.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await _refreshVehicles();
                            },
                            color: const Color(0xff003D58),
                            child: ListView.builder(
                              itemCount: searchResults.isNotEmpty
                                  ? searchResults.length
                                  : vehicles.length,
                              itemBuilder: (context, index) {
                                Vehicle vehicle = searchResults.isNotEmpty
                                    ? searchResults[index]
                                    : vehicles[index];
                                return CarOption(
                                  vehicle: vehicle,
                                  isSelected: vehicle == _selectedVehicle,
                                  onSelect: (selectedVehicle) {
                                    setState(() {
                                      _selectedVehicle = selectedVehicle;
                                    });
                                    if (vehicle == _selectedVehicle) {
                                      final String vehicleId = vehicle.id;
                                      Provider.of<TransactionProvider>(context,
                                              listen: false)
                                          .setSelectedVehicleId(vehicleId);
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('No vehicles found');
                        }
                      }
                    },
                  ),
                ),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                ),
                SizedBox(
                  height: screenSize.height * .03,
                ),
                GestureDetector(
                  onTap: () {
                    if (Provider.of<TransactionProvider>(context, listen: false)
                            .selectedVehicleId ==
                        "") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ErrorPopUp(
                            text: "Make sure you have selected a car!",
                          );
                        },
                      );
                    } else {
                      push(const PumpSelection(), context);
                    }
                  },
                  child: Container(
                    width: screenSize.width * .85,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment(1.5, 1),
                        end: Alignment(-1.5, 1),
                        colors: [
                          Color.fromRGBO(73, 237, 136, 0.498),
                          Color.fromRGBO(73, 237, 155, 1),
                          Color.fromRGBO(73, 237, 136, 0.498)
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 21,
                          letterSpacing: -0.44,
                          fontWeight: FontWeight.normal,
                          height: 1.0952380952380953,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchVehicles(value);
                    },
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Search Cars ...",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset('assets/images/green-search.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
