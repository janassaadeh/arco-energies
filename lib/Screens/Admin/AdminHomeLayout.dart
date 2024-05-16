import 'dart:typed_data';

import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/redemption_model.dart';
import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/fuel_prices_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Companies.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Screens/Admin/admin_profile.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Home/Edit%20Fuel%20Prices/fuel_prices_notifications.dart';
import 'package:company_pages/Services/Auth/user_service.dart' as User;
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:company_pages/Services/Operator/pump_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import '../../../Screens/Admin/Manage Companies/Company_Model.dart' as company;
import '../../../Screens/Admin/ManageOperators/operator_model.dart' as op;

import 'package:company_pages/Screens/Admin/HomeScreen.dart';
import 'package:company_pages/Screens/Admin/new_deposit.dart';
import 'package:company_pages/Screens/Company/HomeScreen.dart';
import 'package:company_pages/Screens/Company/RewardScreen.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/Manage%20Accounts/Company_Services.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/notification.dart' as not;
import '../../Services/Auth/user_service.dart';

// import 'AfterLogin/adminHome.dart'; //
class AdminHomePageLayout extends StatefulWidget {
  AdminHomePageLayout({Key? key}) : super(key: key);

  @override
  State<AdminHomePageLayout> createState() => _AdminHomePageLayoutState();
}

class _AdminHomePageLayoutState extends State<AdminHomePageLayout> {
  String name = "John Doe";
  var _currentIndex = 0;
  dynamic admin;
  List<DepositReceipt> depositList = [];
  List<company.Company> _companies =
      []; // State variable to store the fetched companies
  List<op.Operator> operators = [];
  List<Reward> rewards = [];
  dynamic _imageData;
  List<Pump> pumps = [];
  List<Vehicle> cars = [];
  List<RedemptionEvent> redemptions = [];
  int _notificationCount=0;
  @override
  void initState() {
    super.initState();
    _fetchCompanies();
    _fetchOperators();
    // _fetchRedemptions();
    _fetchUserData().then((_) {
      // Call _getDepositList() only after _fetchUserData() completes
      _getDepositList();
      // if(admin.imageId=='')
      _fetchImage();
      _fetchPumpsndVehicles();
      updateNotificationCount();
      // print('image yes');
    });
    _fetchRewards();
    setupPushNotifications();
  }

  Future<void> _fetchImage() async {
    try {
      ImageService imageService = ImageService();
      // Fetch image data using the image ID
// print(admin.imageId);
      if (admin.imageId != null) {
        Uint8List imageData = await imageService.getImageFromId(admin.imageId);
        if (imageData != null) {
          // Update the state to trigger a rebuild with the fetched image data
          setState(() {
            _imageData = imageData;
          });
        }
        // Check if imageData is not null before setting the state
      } else {
        setState(() {
          _imageData = 'no image';
        });
        print('Image data is null.');
      }
    } catch (e) {
      // Handle errors
      print('Failed to fetch image: $e');
    }
  }

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  Future<void> _fetchPumpsndVehicles() async {
    try {
      PumpService pumpService = PumpService();

      List<Pump> fetchedpumps = await pumpService.getPumps();
      VehicleService vehicleService = VehicleService();
      final List<Vehicle> vehicles = await vehicleService.getVehicles();

      setState(() {
        pumps = fetchedpumps;
        cars = vehicles;
      });
    } catch (e) {
      throw Exception('Failed to fetch pumps: $e');
    }
  }

  Future<void> _fetchOperators() async {
    try {
      AuthenticationService authenticationService = AuthenticationService();
      OperatorService operatorService = OperatorService();
      List<op.Operator> _operators = await operatorService.getAllOperators();

      setState(() {
        operators = _operators;
      });
      for (int i = 0; i < operators.length; i++) {
        print(operators[i]);
      }
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
  }

  Future<void> _fetchRewards() async {
    try {
      AuthenticationService authenticationService = AuthenticationService();
      RewardService rewardService = RewardService();
      List<Reward> _rewards = await rewardService.getAllRewards();

      setState(() {
        rewards = _rewards;
      });
      for (int i = 0; i < operators.length; i++) {
        print(operators[i]);
      }
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
  }

  Future<void> _fetchRedemptions() async {
    try {
      AuthenticationService authenticationService = AuthenticationService();
      RewardService rewardService = RewardService();
      List<RedemptionEvent> _redemptions = await rewardService.getRedemptions();

      setState(() {
        redemptions = _redemptions;
      });
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching redemptions: $e');
    }
  }

  Future<void> _fetchCompanies() async {
    try {
      AuthenticationService authenticationService = AuthenticationService();
      CompanyService companyService = CompanyService();
      List<company.Company> companies = await companyService.getAllCompanies();

      setState(() {
        _companies = companies;
      });
      for (int i = 0; i < _companies.length; i++) {
        print(_companies[i]);
      }
      CompanyProvider companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
      companyProvider.setCompanyList(_companies);
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
  }

  Future<void> _fetchUserData() async {
    try {
      User.UserService userService = User.UserService();
      dynamic userData = await userService.fetchUserData();
      setState(() {
        admin = userData;
      });
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching companies: $e');
    }
  }

  Future<void> _getDepositList() async {
    try {
      if (admin == null) {
        print('Admin data is not yet fetched.');
        return; // Exit the method if admin data is not available
      }

      DepositService depositService = DepositService();
      List<DepositReceipt> adminDepositList =
          await depositService.getCashAdditionEventsByAdminId(admin.id);
      setState(() {
        depositList = adminDepositList;
      });

      if (depositList.isNotEmpty) {
        print('Deposit list fetched successfully:');
        depositList.forEach((receipt) {
          print(
              'Receipt ID: ${receipt.id}, date: ${receipt.timestamp}, Amount: ${receipt.cashAmount}');
        });
      } else {
        print('Deposit list is empty.');
      }
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching deposit list : $e');
    }
  }

  Future<void> updateNotificationCount() async {
    // Get the initial notification count when the widget initializes
    List<not.Notification> notifications =
        await Provider.of<FuelPricesProvider>(context, listen: false)
            .getNotifications();
    setState(() {
      _notificationCount = notifications.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<not.Notification> notifications =
    //     Provider.of<FuelPricesProvider>(context, listen: false)
    //         .cachedNotifications;

    Widget _getBody() {
      switch (_currentIndex) {
        case 0:
          return AdminHomeScreen(
            companies: _companies,
            admin: admin,
            operators: operators,
            imageData: _imageData,
            pumps: pumps,
            cars: cars,
            rewards: rewards,
          );
        case 1:
          return NewDeposit(deposits: depositList);
        case 2:
          return AdminProfile(
            admin: admin,
            imageData: _imageData,
          );
        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Image.asset("assets/images/logoWhite.png"),
                const Text(
                  'rco Energies',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  push(FuelPricesScreen(), context);
                },
                icon: Icon(
                  Icons.notifications,
                  size: 37,
                  color: Colors.white,
                ),
              ),
              Consumer<FuelPricesProvider>(
                builder: (context, fuelPricesProvider, _) {
                  List<not.Notification> notifications =
                      fuelPricesProvider.cachedNotifications;
                  return Positioned(
                    right: 8,
                    top: 3,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        '${notifications.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff003D58),
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Request Money.png",
              color: (_currentIndex == 1)
                  ? Color(0xff003D5B)
                  : Colors.grey.shade600,
            ),
            label: 'New Deposit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _getBody(),
    );
  }
}
