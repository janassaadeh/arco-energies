import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Widgets/Common/confirmation_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:provider/provider.dart'; // Import your fuel price service
import 'package:company_pages/Models/notification.dart' as not;
import 'package:intl/intl.dart';

class FuelPricesScreen extends StatefulWidget {
  const FuelPricesScreen({Key? key}) : super(key: key);

  @override
  _FuelPricesScreenState createState() => _FuelPricesScreenState();
}

class _FuelPricesScreenState extends State<FuelPricesScreen> {
  late Future<List<FuelPrice>> fuelPricesFuture;
  late Future<List<not.Notification>> notificationListFuture;

  final FuelPricesService fuelPricesService = FuelPricesService();
  final FuelService fuelService = FuelService();
  final NotificationService notificationService = NotificationService();

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();
    fuelPricesFuture = _fetchVehicles();
    notificationListFuture = _fetchNotifications();
  }

  Future<List<FuelPrice>> _fetchVehicles() async {
    try {
      List<FuelPrice> cachedVehicles =
          Provider.of<FuelPricesProvider>(context, listen: false)
              .cachedFuelPrices;

      if (cachedVehicles.isNotEmpty) {
        return cachedVehicles;
      } else {
        final List<FuelPrice> vehicles =
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

  Future<List<not.Notification>> _fetchNotifications() async {
    try {
      List<not.Notification> cachedNotifications =
          Provider.of<FuelPricesProvider>(context, listen: false)
              .cachedNotifications;

      if (cachedNotifications.isNotEmpty) {
        return cachedNotifications;
      } else {
        final List<not.Notification> notifications =
            await notificationService.getAllNotifications();
        // Cache fetched pumps
        Provider.of<FuelPricesProvider>(context, listen: false)
            .cachedNotifications = notifications;
        return notifications;
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

  Future<void> _refreshNotifications() async {
    setState(() {
      notificationListFuture = notificationService.getAllNotifications();
    });
  }

  void deleteAllNotifications() {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
          content: 'Delete all notifications?',
          onCancel: () {
            Navigator.pop(ctx);
          },
          onConfirm: () async {
            try {
              Navigator.pop(ctx);
              await notificationService.deleteAllNotifications();
              Provider.of<FuelPricesProvider>(context, listen: false)
                  .clearCachedNotifications();
              _refreshNotifications();
            } catch (e) {
              print('Failed to delete notifications: $e');
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003D58),
        title: Center(
            child: Text(
          'Fuel Prices',
          style: TextStyle(color: Colors.white),
        )),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        actions: [
          IconButton(
            onPressed: () {
              deleteAllNotifications();
            },
            icon: const Icon(
              Icons.delete,
            ),
          )
        ],
      ),
      body: _buildFuelPricesList(),
    );
  }

  Widget _buildFuelPricesList() {
    return FutureBuilder<List<not.Notification>>(
      future: notificationListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to fetch fuel prices: ${snapshot.error}'),
          );
        } else {
          List<not.Notification> notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return Center(
              child: Text('No notifications'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await _refreshNotifications();
            },
            color: const Color(0xff003D58),
            child: ListView.builder(
              reverse: true,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                String createdDate = notification.createdDate;
                DateTime dateTime = DateTime.parse(createdDate);

                final formattedDate =
                    DateFormat.yMMMd().add_jms().format(dateTime);

                String displayType;
                if (notification.type.toLowerCase().contains('diesel')) {
                  displayType = notification.type; // Keep 'Diesel' as is
                } else {
                  displayType =
                      'Fuel ${notification.type}'; // Prefix with 'Fuel'
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 8,
                  ),
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set rounded corners
                    ),
                    child: ListTile(
                      title: Text(
                        "${formattedDate}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                            child: Text(
                              displayType,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              '${notification.price.toString()} \$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 14, 72),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              _handleApprove(notification);
                            },
                            color: Colors.green,
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _handleDecline(notification);
                            },
                            color: Colors.red,
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
    );
  }

  void _handleApprove(not.Notification fuelPrice) async {
    try {
      // Add the fuel price based on the notification
      await fuelPricesService.addFuelPrice(
        fuelPrice.type, // Assuming type is the fuel type
        fuelPrice.price,
        DateTime.now(),
      );

      // Delete the notification from the list
      await _deleteNotificationById(fuelPrice.id);

      // Refresh the fuel prices list
      _refreshFuelPrices();
      _refreshNotifications(); // Refresh notifications after updating

      // Update cached notifications in the provider
      Provider.of<FuelPricesProvider>(context, listen: false)
          .removeCachedNotification(
              fuelPrice); // Implement this method in your provider
    } catch (e) {
      // Handle errors
      print('Failed to approve fuel price: $e');
      // Optionally show error message to the user
    }
  }

  void _handleDecline(not.Notification fuelPrice) async {
    try {
      // Delete the notification from the list
      await _deleteNotificationById(fuelPrice.id);

      // Refresh the fuel prices list
      _refreshFuelPrices();
      _refreshNotifications(); // Refresh notifications after updating

      // Update cached notifications in the provider
      Provider.of<FuelPricesProvider>(context, listen: false)
          .removeCachedNotification(
              fuelPrice); // Implement this method in your provider
    } catch (e) {
      // Handle errors
      print('Failed to decline notification: $e');
      // Optionally show error message to the user
    }
  }

  Future<void> _deleteNotificationById(String id) async {
    try {
      await notificationService.deleteNotificationById(id);
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }
}
