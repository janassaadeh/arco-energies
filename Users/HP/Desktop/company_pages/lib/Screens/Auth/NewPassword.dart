import 'package:company_pages/Widgets/Common/CustomButton.dart';

import 'package:company_pages/main.dart';
import 'package:flutter/material.dart';

import '../../Services/Auth/PassResetService.dart';

import '../../Widgets/Common/CustomInputFieldLarge.dart';
import 'Login.dart';

class NewPassword extends StatefulWidget {
    final String code;

  // Constructor with required code parameter
  const NewPassword({Key? key, required this.code}) : super(key: key);
  
  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
          PasswordResetService _passwordResetService=PasswordResetService();
          final TextEditingController newPasswordController = TextEditingController();
          final TextEditingController confirmPasswordController = TextEditingController();

          @override
          Widget build(BuildContext context) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
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
                          padding: EdgeInsets.only(left:20,right:20,top:105,bottom:20),
                          child: Container(
                            width: 380,
                            height: 667,
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
                    
                                Row(
                                  children: [
                                    SizedBox(width: 20,),

                                    Icon(Icons.arrow_back_ios_outlined),
                                    SizedBox(width: 40,),
                                    Text("Change Password",style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mulish',
              
                                    ),),
                                  ],
                                ),
                                // SizedBox(height: 5,),
                    
                               Image.asset("assets/images/forgotPass1.gif",width: 380,height: 270,) ,
                                // SizedBox(height: 20,),
                               

                                SizedBox(height: 20,), 
                                // CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Envelope.png", hintText: "Email"),
                                        CustomInputFieldLarge(controller: newPasswordController, imagePath: "assets/images/Eye.png", hintText: "New Password"),
          const SizedBox(height: 20),
                                // SizedBox(height: 20,),                                 
                        CustomInputFieldLarge(controller: confirmPasswordController, imagePath: "assets/images/Eye.png", hintText: "Confirm Password"),
          const SizedBox(height: 20),
                                GestureDetector(
                                  onTap:()async{
                                    if(newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                                     if(newPasswordController.text==confirmPasswordController.text){
                                     await _passwordResetService.resetPassword(widget.code, newPasswordController.text);
                                    push(LoginScreen(),context);

                                     }
                                    }
                                  } ,
                                  child: CustomButton(buttonText: "Change"))   ,
                                                                    
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
        