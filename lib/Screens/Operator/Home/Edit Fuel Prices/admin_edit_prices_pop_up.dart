import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Models/fuel_response.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Widgets/Operator/useful_methods.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Models/notification.dart' as not;
import 'package:provider/provider.dart';
import 'package:company_pages/Widgets/Common/dialog_content.dart';

class AdminEditPricesPopUp extends StatefulWidget {
  const AdminEditPricesPopUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPricesPopUpState();
  }
}

class _EditPricesPopUpState extends State<AdminEditPricesPopUp> {
  TextEditingController fuel95Controller = TextEditingController();
  TextEditingController fuel98Controller = TextEditingController();
  TextEditingController dieselController = TextEditingController();

  late Future<List<Fuel>> fuelListFuture;

  final FuelService fuelService = FuelService();
  final NotificationService notificationService = NotificationService();
  final FuelPricesService fuelPricesService = FuelPricesService();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fuelListFuture = _fetchFuels();
    _initializeInputFields();
  }

  void _initializeInputFields() async {
    final fuels = await fuelListFuture;
    // Retrieve the most recent prices for each fuel type
    final double? fuel95Price = getMostRecentFuelPrice(fuels, '95');
    final double? fuel98Price = getMostRecentFuelPrice(fuels, '98');
    final double? dieselPrice = getMostRecentFuelPrice(fuels, 'Diesel');

    // Set initial values for input field controllers
    fuel95Controller.text = fuel95Price?.toString() ?? '';
    fuel98Controller.text = fuel98Price?.toString() ?? '';
    dieselController.text = dieselPrice?.toString() ?? '';
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

  Future<void> _sendPrices() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get entered fuel prices
      final fuel98Price = double.parse(fuel98Controller.text);
      final fuel95Price = double.parse(fuel95Controller.text);
      final dieselPrice = double.parse(dieselController.text);

      final String currentDate = DateTime.now().toIso8601String();

      await fuelPricesService.addFuelPrices([
        FuelPrice(price: fuel98Price, createdDate: currentDate, fuelResponse: FuelResponse(type: "98", description: "Fuel 98")),
        FuelPrice(price: fuel95Price, createdDate: currentDate, fuelResponse: FuelResponse(type: "95", description: "Fuel 95")),
        FuelPrice(price: dieselPrice, createdDate: currentDate, fuelResponse: FuelResponse(type: "Diesel", description: "Diesel")),
      ]);

      Navigator.pop(context);
    } catch (e) {
      print('Failed to send prices: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 60),
          content: Text('Failed to send prices: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: FutureBuilder<List<Fuel>>(
        future: fuelListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Failed to load fuel data'),
            );
          } else {
            return DialogContent(
              fuel95Controller: fuel95Controller,
              fuel98Controller: fuel98Controller,
              dieselController: dieselController,
              isLoading: _isLoading,
              onSend: _sendPrices,
            );
          }
        },
      ),
    );
  }
}
