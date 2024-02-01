import 'package:company_pages/CustomButton.dart';
import 'package:company_pages/Login/Login.dart';
import 'package:company_pages/SignUp/Widgets/CustomInputField.dart';
import 'package:company_pages/main.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return Scaffold(
              body: Container(
                  width: 735,
                  height: 900,
                  decoration: BoxDecoration(
                      
              ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
            Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                  width: 709,
                  height: 900,
                  
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                  width: 709,
                  height: 900,
                  decoration: BoxDecoration(
                      
              ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                    top: 0,
                    left: -50,
                    child: Image.asset(
                    'assets/images/e1.png',
                  )
                  ),
                  Positioned(
                    bottom: 0,
                    left: 65,
                    child: Image.asset(
                    'assets/images/e11.png',
                  )
                  ),
                  Positioned(
                    top: -50,
                    left: 160,
                    child: Image.asset(
                    'assets/images/e2.png',
                  )
                  ),Positioned(
                    top: -58,
                    left: 160,
                    child: Image.asset(
                    'assets/images/e3.png',
                  )
                  ),Positioned(
                    top: 550,
                    left: 0,
                    child: Image.asset(
                    'assets/images/e31.png',
                  )
                  )
                    ]
                  )
                )
                  ),
                    ]
                  )
                )
                  ),
                  Positioned(child: 
                        // Figma Flutter Generator Rectangle10Widget - RECTANGLE
                      Padding(
                        padding: EdgeInsets.only(left:20,right:20,top:45,bottom:20),
                        child: Container(
                          width: 380,
                          height: 844,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                            offset: Offset(0,4),
                            blurRadius: 4
                        )],
                        color : Color.fromRGBO(255, 255, 255, 1),
                                        )
                            ,child: Column(children: [
                              SizedBox(height: 20,),
                  
                              Text("Sign Up",style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mulish',

                              ),),
                              SizedBox(height: 5,),
                  
                             Image.asset("assets/images/Business Building.png",width: 90,height: 90,) ,
                              SizedBox(height: 20,),
                             
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Business.png", hintText: "Name"),
                              SizedBox(height: 15,),
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Customer.png", hintText: "Contact Name"),
                              SizedBox(height: 15,), 
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Envelope.png", hintText: "Email"),
                              SizedBox(height: 15,),                                 
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/iPhone 14 Pro.png", hintText: "Phone Number"),
                              SizedBox(height: 15,),  
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Eye.png", hintText: "Password"),
                              SizedBox(height: 15,), 
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Eye.png", hintText: "Confirm Password"),
                              SizedBox(height: 15,),                                 
                              CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Map Pin.png", hintText: "Address"),
                              SizedBox(height: 25,),      
                              GestureDetector(
                                onTap:(){
                                  push(SignUp(),context);
                                } ,
                                child: CustomButton(buttonText: "Sign up"))   ,
                                          Padding(
              padding: const EdgeInsets.only(left:80.0,top:30),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                  Text(
                    'Already have an account? ',
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
                      push(LoginScreen(),context);
                    },
                    child: Text(
                      'Sign in',
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
                            ]),
                        ),
                      )
                  )
                    ]
                  )
                ),
                
            );
          }
        }
        