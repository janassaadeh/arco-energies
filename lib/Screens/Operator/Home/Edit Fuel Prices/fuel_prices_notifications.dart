import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:provider/provider.dart'; // Import your fuel price service

class FuelPricesScreen extends StatefulWidget {
  const FuelPricesScreen({Key? key}) : super(key: key);

  @override
  _FuelPricesScreenState createState() => _FuelPricesScreenState();
}

class _FuelPricesScreenState extends State<FuelPricesScreen> {
  late Future<List<FuelPrice>> fuelPricesFuture;

  final FuelPricesService fuelPricesService = FuelPricesService();

  @override
  void initState() {
    super.initState();
    fuelPricesFuture = _fetchVehicles();
  }

  Future<List<FuelPrice>> _fetchVehicles() async {
    try {
      List cachedVehicles =
          Provider.of<FuelPricesProvider>(context, listen: false)
              .cachedFuelPrices;

      if (cachedVehicles.isNotEmpty) {
        return cachedVehicles;
      } else {
        final List vehicles =
            await fuelPricesService.getFuelPrices();
        // Cache fetched pumps
        Provider.of<FuelPricesProvider>(context, listen: false)
            .cachedFuelPrices = vehicles;
        return vehicles;
      }
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  Future<void> _refreshFuelPrices() async {
    setState(() {
      fuelPricesFuture = fuelPricesService.getFuelPrices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Prices'),
      ),
      body: _buildFuelPricesList(),
    );
  }

  Widget _buildFuelPricesList() {
    return FutureBuilder<List<dynamic>>(
      future: fuelPricesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to fetch fuel prices: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          List<dynamic> fuelPrices = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              await _refreshFuelPrices();
            },
            color: const Color(0xff003D58),
            child: ListView.builder(
              itemCount: fuelPrices.length,
              itemBuilder: (context, index) {
                final fuelPrice = fuelPrices[index];
                return ListTile(
                  title: Text(fuelPrice.id),
                  subtitle:
                      Text('Price: ${fuelPrice.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle Approve button press
                          _handleApprove(fuelPrice);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text('Approve'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Decline button press
                          _handleDecline(fuelPrice);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text('Decline'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('No fuel prices available'),
          );
        }
      },
    );
  }

  void _handleApprove(FuelPrice fuelPrice) {
    // Implement logic for approving the fuel price
    // For example, you can update the status of the fuel price
    // and update the UI accordingly
  }

  void _handleDecline(FuelPrice fuelPrice) {
    // Implement logic for declining the fuel price
    // For example, you can remove the fuel price from the list
    // and update the UI accordingly
  }
}
