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
            return
        WillPopScope(
        onWillPop: () async {
          // Prevent back button press
          return true;
        },
            
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
  appBar: AppBar(
        toolbarHeight: 70,

                leading: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),

        title: const Center(
          child:  Text('Forgot Password',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: const [Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color:Color(0xff003D5B),),
        )],
      ),
                  body: SingleChildScrollView(
                    child:  Padding(
                              padding: const EdgeInsets.only(left:20,right:20,top:0,bottom:20),
                              child: Column(children: [
                                const SizedBox(height: 20,),
                        
                                // const Text("Forgot Password",style: TextStyle(
                                //   fontSize: 27,
                                //   fontWeight: FontWeight.bold,
                                //   fontFamily: 'Mulish',
                  
                                // ),),
                                // SizedBox(height: 5,),
                        
                               Image.asset("assets/images/forgotPass1.gif",width: 380,height: 270,) ,
                                // SizedBox(height: 20,),
                                const SizedBox(height: 20,),
                               
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
                                const SizedBox(height: 40,), 
                                CustomInputFieldLarge(controller: emailController, imagePath: "assets/images/Envelope.png", hintText: "Email"),
                                const SizedBox(height: 40,),                                 
                  
                                GestureDetector(
                                  onTap:()async{
                                    if(emailController.text.isNotEmpty){
                                    push( VerifyEmail(email:'${emailController.text}'),context);
                                    await passwordResetService.initiatePasswordReset(emailController.text);
                  
                                    }
                  
                                  } ,
                                  child: const CustomButton(buttonText: "Send"))   ,
                                            Padding(
                    padding: const EdgeInsets.only(left:80.0,top:50),
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
                            )
                  ),
                    
                ),
      ),
            );
          }
        }
        