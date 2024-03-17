import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Company/CompanyHomeLayout.dart';
import 'package:company_pages/Screens/Operator/operator_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Auth/Login.dart';
import 'Services/Auth/AuthenticationService.dart';

void main() {
  final AuthenticationService authService = AuthenticationService();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: MyApp(
        authService: authService,
      ),
    ),
  );
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
      home: FutureBuilder<bool>(
        future: authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator if authentication state is being fetched
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData && snapshot.data!) {
              // User is logged in, determine role and redirect accordingly
              return FutureBuilder<String?>(
                future: authService.getRole(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show loading indicator if role is being fetched
                    return const CircularProgressIndicator();
                  } else {
                    String role =
                        snapshot.data ?? ""; // Use empty string as default
                    if (role == "COMPANY") {
                      return const CompanyHomePageLayout();
                    } else if (role == "OPERATOR") {
                      return const Operator();
                    } else {
                      // Unknown role, redirect to login
                      return LoginScreen();
                    }
                  }
                },
              );
            } else {
              // User is not logged in, redirect to login
              return LoginScreen();
            }
          }
        },
      ),
    );
  }
}
