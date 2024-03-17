import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Widgets/cars/CustomCarSearch.dart';
import 'package:flutter/material.dart';

import 'package:company_pages/Widgets/cars/CarCard.dart';

class MyCars extends StatelessWidget {
  MyCars({super.key});

  final VehicleService vehicleService = VehicleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Center(
            child: Text(
              'All Cars',
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
                color: Colors.white,
              ),
            )
          ],
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
                    height: 500,
                    color: Colors.white,
                    // height: MediaQuery.of(context).size.height / 1.1,
                    child: FutureBuilder<List<Vehicle>>(
                      future: vehicleService.getVehicles(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Vehicle>? vehicles = snapshot.data;
                          if (vehicles != null && vehicles.isNotEmpty) {
                            return ListView.builder(
                              itemCount: vehicles.length,
                              itemBuilder: (context, index) {
                                Vehicle vehicle = vehicles[index];
                                return CarCard(
                                  vehicle: vehicle,
                                );
                              },
                            );
                          } else {
                            return const Text('No vehicles found');
                          }
                        }
                      },
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
                          topRight: Radius.circular(25))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 15.0, right: 15),
                child: CustomCarSearch(),
              ),
            ],
          ),
        ));
  }
}
