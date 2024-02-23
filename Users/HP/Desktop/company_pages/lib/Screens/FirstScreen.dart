import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Company/CompanyHomeLayout.dart';
import 'package:flutter/material.dart';

import '../Services/Auth/AuthenticationService.dart';
import 'Operator/operator_bottom_nav.dart';

class MainScreen extends StatelessWidget {
  final AuthenticationService authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return FutureBuilder(
              future: authService.getRole(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (roleSnapshot.data == 'operato') {
                    return Operator();
                  } else {
                    return CompanyHomePageLayout();
                  }
                }
              },
            );
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
