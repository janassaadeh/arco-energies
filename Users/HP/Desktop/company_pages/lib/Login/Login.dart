// Import necessary packages
import 'package:company_pages/Login/Widgets/CustomInputField.dart';
import 'package:company_pages/CustomButton.dart';
import 'package:company_pages/SignUp/SignUp.dart';
import 'package:company_pages/main.dart';
import 'package:flutter/material.dart';

import '../Home/Cash.dart';
import '../Home/HomeScreen.dart';

// Define the LoginScreen class
class LoginScreen extends StatelessWidget {
  // Build method to create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                          child: Container(
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
          CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Envelope.png", hintText: "Email"),
          const SizedBox(height: 30,),
          CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Eye.png", hintText: "Password"),
          const SizedBox(height: 30),
          const Padding(
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
    
          GestureDetector(
            onTap: (){
                push(HomeScreen(), context);
            },
            child: CustomButton(buttonText: "Sign In")),
          Padding(
            padding: const EdgeInsets.only(left:90.0,top:30),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
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
                    child: Text(
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
