import 'package:company_pages/Widgets/Common/CustomButton.dart';

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
          final PasswordResetService _passwordResetService=PasswordResetService();
          final TextEditingController newPasswordController = TextEditingController();
          final TextEditingController confirmPasswordController = TextEditingController();
          bool isLocked=true;
          bool isLocked2=true;
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
          child:  Text('Change Password',style: TextStyle(
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
                            padding: const EdgeInsets.only(left:20,right:20,top:0,bottom:20),
                            child: Column(children: [
                              
                              // SizedBox(height: 5,),
                            const SizedBox(height: 20,),
                      
                             Image.asset("assets/images/forgotPass1.gif",width: 380,height: 270,) ,
                              SizedBox(height: 20,),
                             
            
                              const SizedBox(height: 20,), 
                              // CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Envelope.png", hintText: "Email"),
                                      
                                      
                                      
                                      // CustomInputFieldLarge(controller: newPasswordController, imagePath: "assets/images/Eye.png", hintText: "New Password"),
                                      
              Container(
      width: 328,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(196, 196, 196, 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
        child: TextFormField(
          controller: newPasswordController,
          obscureText: isLocked,
          // obscuringCharacter: '⚫',
            obscuringCharacter: '●',

          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'New Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed

            hintStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontFamily: 'Mulish',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: GestureDetector(
              
              onTap: (){
              setState(() {
                isLocked=!isLocked;
              });
              },
              child:isLocked? 
              
              Image.asset('assets/images/Blind.png',): Image.asset('assets/images/Eye.png',color: Color(0xff666666),)),
          ),
        ),
      ),
    ),
                      const SizedBox(height: 20),
                              SizedBox(height: 10,),                                 
                          // CustomInputFieldLarge(controller: confirmPasswordController, imagePath: "assets/images/Eye.png", hintText: "Confirm Password"),
                          
              Container(
      width: 328,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(196, 196, 196, 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
        child: TextFormField(
          controller: confirmPasswordController,
          obscureText: isLocked2,
          // obscuringCharacter: '⚫',
            obscuringCharacter: '●',

          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Confirm Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed

            hintStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontFamily: 'Mulish',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: GestureDetector(
              
              onTap: (){
              setState(() {
                isLocked2=!isLocked2;
              });
              },
              child:isLocked2? 
              
              Image.asset('assets/images/Blind.png',): Image.asset('assets/images/Eye.png',color: Color(0xff666666),)),
          ),
        ),
      ),
    ),
                      const SizedBox(height: 40),
                              GestureDetector(
                                onTap:()async{
                                  if(newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                                   if(newPasswordController.text==confirmPasswordController.text){
                                   await _passwordResetService.resetPassword(widget.code, newPasswordController.text);
                                  push(LoginScreen(),context);
            
                                   }
                                  }
                                } ,
                                child: const CustomButton(buttonText: "Change"))   ,
                                                                  
                            ]),
                          )
                      )
                        ]
                      )
                    ),
                ),
                  
              ),
            );
          }
}
        