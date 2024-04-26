import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Models/fuel_response.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:company_pages/Widgets/Operator/useful_methods.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Models/notification.dart' as not;
import 'package:provider/provider.dart';

class EditPricesPopUp extends StatefulWidget {
  const EditPricesPopUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPricesPopUpState();
  }
}

class _EditPricesPopUpState extends State<EditPricesPopUp> {
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
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Failed to load fuel data'), // Show error message
            );
          } else {
            // final fuels = snapshot.data!;
            // _initializeInputFields(fuels); // Initialize input fields
            return _buildDialogContent(context); // Build dialog content
          }
        },
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSection(
            title: 'Fuel 98 Price',
            child: buildInput(
              "Enter Fuel 98 Price",
              dollarText(),
              true,
              fuel98Controller,
            ),
          ),
          const SizedBox(height: 30),
          _buildSection(
            title: 'Fuel 95 Price',
            child: buildInput(
              "Enter Fuel 95 Price",
              dollarText(),
              true,
              fuel95Controller,
            ),
          ),
          const SizedBox(height: 30),
          _buildSection(
            title: 'Fuel Diesel Price',
            child: buildInput(
              "Enter Diesel Price",
              dollarText(),
              true,
              dieselController,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 14, 72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // Start loading
                  });

                  try {
                    // Get entered fuel prices
                    final fuel98Price = double.parse(fuel98Controller.text);
                    final fuel95Price = double.parse(fuel95Controller.text);
                    final dieselPrice = double.parse(dieselController.text);

                    final fuel98PriceResponse =
                        FuelResponse(type: "98", description: "Fuel 98");
                    final fuel95PriceResponse =
                        FuelResponse(type: "95", description: "Fuel 95");
                    final dieselPriceResponse =
                        FuelResponse(type: "Diesel", description: "Diesel");

                    final String currentDate = DateTime.now().toIso8601String();

                    // Create list of entered fuel prices
                    final List<FuelPrice> enteredFuelPrices = [
                      FuelPrice(
                          price: fuel98Price,
                          createdDate: "2024-04-23",
                          fuelResponse: fuel98PriceResponse),
                      FuelPrice(
                          price: fuel95Price,
                          createdDate: "2024-04-23",
                          fuelResponse: fuel95PriceResponse),
                      FuelPrice(
                          price: dieselPrice,
                          createdDate: "2024-04-23",
                          fuelResponse: dieselPriceResponse),
                    ];

                    for (var fuelPrice in enteredFuelPrices) {
                      final not.NotificationBody notification =
                          not.NotificationBody(
                        fuelPrice.fuelResponse!.type,
                        fuelPrice.price,
                        currentDate,
                      );

                      // Send the notification
                      await notificationService.addNotification(notification);
                    }

                    // Send push notifications with entered prices
                    await fuelPricesService
                        .sendPushNotifications(enteredFuelPrices);

                    // Close the dialog
                    Navigator.pop(context);
                  } catch (e) {
                    // Handle error
                    print('Failed to send push notifications: $e');
                    // Optionally show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 60),
                        content: Text('Failed to send push notifications: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 14, 72),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 1, 14, 72),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget dollarText() {
    return const Text(
      '\$ / liter',
      style: TextStyle(
        color: Color.fromRGBO(114, 212, 171, 1),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
