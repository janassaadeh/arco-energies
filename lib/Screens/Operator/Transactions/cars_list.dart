import 'package:flutter/material.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Operator/Transactions/pump_selection.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Widgets/Operator/car_option.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
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

    List<Vehicle> updatedVehicles = await vehicleService.getVehicles();
    Provider.of<TransactionProvider>(context, listen: false).cachedVehicles =
        updatedVehicles;
  }

  void _searchVehicles(String query) async {
    List<Vehicle> allVehicles = await _vehiclesFuture;

    setState(() {
      searchResults = allVehicles.where((vehicle) {
        return vehicle.color.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.plateNumber.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.driverName.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.model.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.company!.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
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
                size: 60,
              )
            ],
          ),
        ),
        leading: GestureDetector(
          child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 17),
              child: Image.asset(
                "assets/images/cancel.png",
                width: 15,
              )),
          onTap: () {
            Provider.of<TransactionProvider>(context, listen: false)
                .resetTransactionValues();

            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: buildInput(
              "Search Cars ...",
              Image.asset('assets/images/green-search.png'),
              true,
              _searchController,
              fn: (value) {
                _searchVehicles(value);
              },
            ),
          ),
          Expanded(
            child: Container(
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
                      return const Center(child: Text('No vehicles found'));
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
