import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:company_pages/Widgets/Common/CustomInputFieldLarge.dart';
import 'package:company_pages/Widgets/Common/CustomInputFieldSmall.dart';
import 'package:flutter/material.dart';

import '../../Services/Auth/RegisterService.dart';
import '../Company/HomeScreen.dart';
import 'Login.dart';

class SignUp extends StatelessWidget {
   final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegistrationService registrationService=RegistrationService();
  AuthenticationService authenticationService=AuthenticationService();

  SignUp({super.key});

          @override
          Widget build(BuildContext context) {
            return 
        WillPopScope(
        onWillPop: () async {
          // Prevent back button press
          return false;
        },
            
      child: Scaffold(
           appBar: AppBar(
        toolbarHeight: 70,

                leading: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),

        title: const Center(
          child:  Text('Sign Up',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: const [Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color:Color(0xff003D5B),),
        )],
      ),     
                body: Container(
                    width: 735,
                    height: 900,
                    decoration: const BoxDecoration(
                        
                ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left:20,right:20,top:0,bottom:20),
                        child: Column(children: [
                          // const SizedBox(height: 20,),
                                    
                          // const Text("Sign Up",style: TextStyle(
                          //   fontSize: 27,
                          //   fontWeight: FontWeight.bold,
                          //   fontFamily: 'Mulish',
                                
                          // ),),
                          // const SizedBox(height: 5,),
                                    
                         Image.asset("assets/images/Business Building.png",width: 150,height: 150,) ,
                          const SizedBox(height: 20,),
                         
                          CustomInputFieldLarge(controller:nameController, imagePath: "assets/images/Business.png", hintText: "Name"),
                          const SizedBox(height: 15,),
                          CustomInputFieldLarge(controller: contactNameController, imagePath: "assets/images/Customer.png", hintText: "Contact Name"),
                          const SizedBox(height: 15,), 
                          CustomInputFieldLarge(controller: emailController, imagePath: "assets/images/Envelope.png", hintText: "Email"),
                          const SizedBox(height: 15,),                                 
                          CustomInputFieldLarge(controller: phoneController, imagePath: "assets/images/iPhone 14 Pro.png", hintText: "Phone Number"),
                          const SizedBox(height: 15,),  
                          CustomInputFieldLarge(controller: passwordController, imagePath: "assets/images/Eye.png", hintText: "Password"),
                          const SizedBox(height: 15,), 
                          CustomInputFieldLarge(controller: confirmPasswordController, imagePath: "assets/images/Eye.png", hintText: "Confirm Password"),
                          const SizedBox(height: 15,),                                 
                          CustomInputFieldLarge(controller: locationController, imagePath: "assets/images/Map Pin.png", hintText: "Location"),
                          const SizedBox(height: 35,),      
                          GestureDetector(
                            onTap:()async{
                                        String name = nameController.text;
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    String phone = phoneController.text;
                                    String contactName = contactNameController.text;
                                    String location = locationController.text;
                                    await registrationService.registerCompany(name: name,balance: 0.0,email: email,password: password,contactName: contactName,phone: phone,location: location);
                                Navigator.pop(context);
    //   // Authenticate the user after registration
    //   try {
    //     await authenticationService.authenticate(email, password);
    //     // Navigate to HomeScreen if login is successful
    //     push(HomeScreen(), context);
    //   } catch (e) {
    //     // Handle login failure
    //     print('Login failed: $e');
    //     // You can display an error message to the user
    //   }
    }
  ,
                            child: const CustomButton(buttonText: "Sign up"))   ,
                                      Padding(
                                padding: const EdgeInsets.only(left:80.0,top:30),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                    const Text(
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
                       
                       SizedBox(height: 40,)
                        ]),
                      ),
                    )
                  ),
                  
              ),
            );
          }
        }
        