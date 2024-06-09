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
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLocked = true;
  bool isLoading = false;
  bool showError = false;
  bool emailPassError = false;

  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService = AuthenticationService();
    return WillPopScope(
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
                  alignment: Alignment.center,
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
                              top: -80,
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
                              top: 220,
                              left: MediaQuery.sizeOf(context).width / 2.65,
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(22),
                                            topRight: Radius.circular(22),
                                            bottomLeft: Radius.circular(22),
                                            bottomRight: Radius.circular(22),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.2),
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/arco.jpg"),
                                              // fit: BoxFit.fitWidth
                                            ),
                                          ),
                                         
                                      ),
                                      ))
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 335,
                            //   left: MediaQuery.sizeOf(context).width / 2.9,
                            //   child: Text(
                            //     'Arco Energies',
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(
                            //       color: Color.fromRGBO(0, 0, 0, 1),
                            //       fontFamily: 'Inter',
                            //       fontSize: 22,
                            //       letterSpacing: 0,
                            //       fontWeight: FontWeight.bold,
                            //       height: 1,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomInputFieldLarge(
                  controller: _emailController,
                  imagePath: "assets/images/Envelope.png",
                  hintText: "Email"),
              const SizedBox(
                height: 20,
              ),
              // CustomInputFieldLarge(controller: _passwordController, imagePath: "assets/images/Eye.png", hintText: "Password"),

              Container(
                width: 328,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(196, 196, 196, 0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 8, bottom: 8, top: 11),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: isLocked,
                    // obscuringCharacter: '⚫',
                    obscuringCharacter: '●',

                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0), // Adjust padding as needed

                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLocked = !isLocked;
                            });
                          },
                          child: isLocked
                              ? Image.asset(
                                  'assets/images/Blind.png',
                                )
                              : Image.asset(
                                  'assets/images/Eye.png',
                                  color: Color(0xff666666),
                                )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  push(const ForgotPassword(), context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 40.0, bottom: 30),
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
              Visibility(
                visible:
                    showError, // Show error widget based on showError state
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Authentication Error. Please check your credentials.",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Visibility(
                visible: emailPassError,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Please fill in all fields.",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool isEmailValid = _emailController.text.isNotEmpty;
                  bool isPasswordValid = _passwordController.text.isNotEmpty;

                  if (isEmailValid && isPasswordValid && !isLoading) {
                    setState(() {
                      isLoading = true;
                      showError = false;
                    });

                    try {
                      await authenticationService.authenticate(
                          _emailController.text, _passwordController.text);
                      String? role = await authenticationService.getRole();
                      print(role);
                      if (role == 'COMPANY') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompanyHomePageLayout()));
                      } else if (role == 'OPERATOR') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Operator()));
                      } else if (role == 'ADMIN') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminHomePageLayout()));
                      }
                    } catch (e) {
                      print('Authentication Error: $e');
                      setState(() {
                        showError = true;
                      });
                      Future.delayed(const Duration(seconds: 10), () {
                        setState(() {
                          showError = false;
                        });
                      });
                    }

                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      emailPassError = true;
                    });
                    Future.delayed(const Duration(seconds: 10), () {
                      setState(() {
                        emailPassError = false;
                      });
                    });
                  }
                },
                child: isLoading
                    ? Container(
                        width: 342,
                        height: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment(1.5, 1),
                            end: Alignment(-1.5, 1),
                            colors: [
                              Color.fromRGBO(0, 61, 91, 1),
                              Color.fromRGBO(2, 91, 134, 0.8999999761581421)
                            ],
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const CustomButton(buttonText: "Sign In"),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 90.0, top: 30),
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
                        onTap: () {
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

void push(Widget s, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => s,
    ),
  );
}
