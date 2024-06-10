import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:company_pages/Provider/shift_provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Admin/AdminHomeLayout.dart';
import 'package:company_pages/Screens/Company/CompanyHomeLayout.dart';
import 'package:company_pages/Screens/Operator/operator_bottom_nav.dart';
import 'package:company_pages/Screens/splash.dart';
import 'package:company_pages/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'Provider/company_provider.dart';
import 'Provider/fuel_prices_provider.dart';
import 'Screens/Auth/Login.dart';
import 'Services/Auth/AuthenticationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ensure the timezone database is initialized
  await initializeTimezones();

  final AuthenticationService authService = AuthenticationService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TransactionProvider>(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider<CompanyProvider>(
          create: (_) => CompanyProvider(),
        ),
        ChangeNotifierProvider<DepositProvider>(
          create: (_) => DepositProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FuelPricesProvider()),
        ChangeNotifierProvider<ShiftProvider>(
          create: (_) => ShiftProvider(),
        ),
      ],
      child: MyApp(
        authService: authService,
      ),
    ),
  );
}

Future<void> initializeTimezones() async {
  // Initialize timezone database
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  final AuthenticationService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
