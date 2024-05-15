import 'package:company_pages/Screens/Admin/AdminHomeLayout.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Company/CompanyHomeLayout.dart';
import 'package:company_pages/Screens/Operator/operator_bottom_nav.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  AuthenticationService authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FutureBuilder<bool>(
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show loading indicator if role is being fetched
                              return const CircularProgressIndicator();
                            } else {
                              String role = snapshot.data ??
                                  ""; // Use empty string as default
                              if (role == "COMPANY") {
                                return  LoginScreen();
                              } else if (role == "OPERATOR") {
                                return const Operator();
                              } else if (role == "ADMIN") {
                                return AdminHomePageLayout();
                              }
                              // else if(authService.getToken())
                              else {
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
                )),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              // fit: BoxFit.fitWidth
            ),
          ),
        ),
      ),
    );
  }
}
