import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:company_pages/Screens/Auth/NewPassword.dart';

import 'package:company_pages/main.dart';
import 'package:flutter/material.dart';

import '../../Widgets/ForgotPass/code.dart';
import 'Login.dart';

class VerifyEmail extends StatefulWidget {
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
    late TextEditingController _controller1;

  late TextEditingController _controller2;

  late TextEditingController _controller3;

  late TextEditingController _controller4;

  late FocusNode _focusNode1;

  late FocusNode _focusNode2;

  late FocusNode _focusNode3;

  late FocusNode _focusNode4;

  @override
  void initState() {
    super.initState();

    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();

    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();

    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    super.dispose();
  }

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

                                    GestureDetector(
                                      onTap:(){
                                            pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios_outlined)),
                                    SizedBox(width: 70,),
                                    Text("Verify Email",style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mulish',
              
                                    ),),
                                  ],
                                ),
                                // SizedBox(height: 5,),
                    
                               Image.asset("assets/images/forgotPass1.gif",width: 380,height: 270,) ,
                                // SizedBox(height: 20,),
                               
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:30.0,right:30),
                                      child: Text('Please enter the verification code sent to jana@gmail.com .', textAlign: TextAlign.left, style: TextStyle(
                                        color: Color.fromRGBO(147, 147, 147, 1),
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        letterSpacing: -0.4399999976158142,
                                        fontWeight: FontWeight.normal,
                                        height: 1.4375
                                      ),),
                                    ),
                                  ),
                                SizedBox(height: 20,), 
                                // CustomInputField(controller: TextEditingController(), imagePath: "assets/images/Envelope.png", hintText: "Email"),
                                Padding(
                                  // padding: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.only(left:30.0,right:30),
              
                                  child: Row(
                                    children: [
                                      CodeBox(controller: _controller1,
                                         focusNode: _focusNode1,
              nextFocusNode: _focusNode2,
              previousFocusNode:_focusNode1
                                      ),
                                  SizedBox(width: 20,), 
                                    
                                      CodeBox(controller:_controller2,
                                         focusNode: _focusNode2,
              nextFocusNode: _focusNode3,
              previousFocusNode:_focusNode1
              ),
                                  SizedBox(width: 20,), 
                                
                                      CodeBox(controller: _controller3,
                                         focusNode: _focusNode3,
              nextFocusNode: _focusNode4,
              previousFocusNode:_focusNode2
              
                                      ),
                                  SizedBox(width: 20,), 
                                      
                                      CodeBox(controller:_controller4,
                                         focusNode: _focusNode4,
              nextFocusNode: _focusNode4,
              previousFocusNode:_focusNode3
              
              ),
                                
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),                                 
              
                                GestureDetector(
                                  onTap:(){
                                    if(_controller1.text.isNotEmpty &&
                                    _controller2.text.isNotEmpty && 
                                    _controller3.text.isNotEmpty && 
                                    _controller4.text.isNotEmpty  ){
                                    push(NewPassword(code: "${_controller1.text}${_controller2.text}${_controller3.text}${_controller4.text}",),context);

                                    }

                                  } ,
                                  child: CustomButton(buttonText: "Verify"))   ,
                                            Padding(
                padding: const EdgeInsets.only(left:80.0,top:30),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                    Text(
                      'Didn’t receive code? ',
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
                        // push(LoginScreen(),context);
                      },
                      child: Text(
                        'Resend',
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
          
             void pop(BuildContext context){
    Navigator.pop(context);
  }
}
        