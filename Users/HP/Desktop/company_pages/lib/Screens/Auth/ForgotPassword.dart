import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Auth/VerifyEmail.dart';
import 'package:company_pages/Services/Auth/PassResetService.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Common/CustomInputFieldLarge.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

          @override
          Widget build(BuildContext context) {
          PasswordResetService passwordResetService=PasswordResetService();
          final TextEditingController emailController = TextEditingController();
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                    width: 735,
                    height: 900,
                    decoration: const BoxDecoration(
                        
                ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                          Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
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
                    decoration: const BoxDecoration(
                        
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
                          padding: const EdgeInsets.only(left:20,right:20,top:105,bottom:20),
                          child: Container(
                            width: 380,
                            height: 667,
                            decoration: const BoxDecoration(
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
                                const SizedBox(height: 20,),
                    
                                const Text("Forgot Password",style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Mulish',
              
                                ),),
                                // SizedBox(height: 5,),
                    
                               Image.asset("assets/images/forgotPass1.gif",width: 380,height: 270,) ,
                                // SizedBox(height: 20,),
                               
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left:30.0,right:30),
                                      child: Text('Please enter your email address to receive a verification code.', textAlign: TextAlign.left, style: TextStyle(
                                        color: Color.fromRGBO(147, 147, 147, 1),
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        letterSpacing: -0.4399999976158142,
                                        fontWeight: FontWeight.normal,
                                        height: 1.4375
                                      ),),
                                    ),
                                  ),
                                const SizedBox(height: 20,), 
                                CustomInputFieldLarge(controller: emailController, imagePath: "assets/images/Envelope.png", hintText: "Email"),
                                const SizedBox(height: 20,),                                 
              
                                GestureDetector(
                                  onTap:()async{
                                    if(emailController.text.isNotEmpty){
                                    push(const VerifyEmail(),context);
                                    await passwordResetService.initiatePasswordReset(emailController.text);
              
                                    }
              
                                  } ,
                                  child: const CustomButton(buttonText: "Send"))   ,
                                            Padding(
                padding: const EdgeInsets.only(left:80.0,top:30),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                    const Text(
                      'Remember Password? ',
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
                      child: const Text(
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
              ),
                
            );
          }
        }
        