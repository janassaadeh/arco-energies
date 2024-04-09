// Import necessary packages
import 'package:company_pages/Screens/Admin/AdminHomeLayout.dart';
import 'package:company_pages/Screens/Company/CompanyHomeLayout.dart';
import 'package:company_pages/Screens/Operator/operator_bottom_nav.dart';
import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:company_pages/Screens/Auth/ForgotPassword.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Screens/Auth/SignUp.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Common/CustomInputFieldLarge.dart';
import '../Admin/Manage Cars/Cars.dart';



// Define the LoginScreen class
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService=AuthenticationService();
    return
        WillPopScope(
        onWillPop: () async {
          // Prevent back button press
          return false;
        },
            
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 709,
                height: 420,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 709,
                        height: 491,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -20,
                              left: -26,
                              child: Image.asset(
                                'assets/images/Ellipse 1.png',
                              ),
                            ),
                            Positioned(
                              top: -58,
                              left: 110,
                              child: Image.asset(
                                'assets/images/Ellipse 2.png',
                              ),
                            ),
                            Positioned(
                              top: -55.8,
                              left: 110,
                              child: Image.asset(
                                'assets/images/Ellipse 3.png',
                              ),
                            ),
                            Positioned(
                              top: 200,
                              left: 160,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(22),
                                            topRight: Radius.circular(22),
                                            bottomLeft: Radius.circular(22),
                                            bottomRight: Radius.circular(22),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 315,
                              left: 150,
                              child: Text(
                                'Arco Energies',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomInputFieldLarge(controller: _emailController, imagePath: "assets/images/Envelope.png", hintText: "Email"),
              const SizedBox(height: 30,),
              CustomInputFieldLarge(controller: _passwordController, imagePath: "assets/images/Eye.png", hintText: "Password"),
              const SizedBox(height: 30),
              GestureDetector(
                onTap:() {
                 
                  push(const ForgotPassword(), context);
    
                  
                },
                child: const Padding(
                  padding: EdgeInsets.only(right:40.0,bottom:30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(48, 99, 142, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            
              GestureDetector(
      onTap: () async {
      print("hi");
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        await authenticationService.authenticate(_emailController.text, _passwordController.text);
    
        // Wait for getRole() to complete and then handle the role
        String? role = await authenticationService.getRole();
        print(role);
    
        // Handle the role accordingly
        if (role == 'COMPANY') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyHomePageLayout()));
        } else if (role == 'OPERATOR') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Operator()));
        }
         else if (role == 'ADMIN') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomePageLayout()));
    
        }
    
      }
      },
      
    
                child: const CustomButton(buttonText: "Sign In")),
              Padding(
                padding: const EdgeInsets.only(left:90.0,top:30),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          letterSpacing: 0,
                          height: 1,
                        ),
                      ),
                      GestureDetector(
                       onTap: (){
                  
                        push(SignUp(), context);
        
                                    },
                        child: const Text(
                          'Sign up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(48, 99, 142, 1),
                            fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),                    
            ],
          ),
        ),
      ),
    );
  }
}
 void push(Widget s,BuildContext context){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => s,
          ),
        );

 }
