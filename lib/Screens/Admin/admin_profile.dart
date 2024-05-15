import 'dart:convert';
import 'dart:io';

import 'package:company_pages/Screens/Auth/ForgotPassword.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
//
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Services/image_service.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/profile/link.dart';

class AdminProfile extends StatefulWidget {
  dynamic admin;
  dynamic imageData;
  
  // dynamic cars;
  // List<dynamic>? mergeAndSorted;

  AdminProfile({required this.admin, required this.imageData});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  AuthenticationService authenticationService = AuthenticationService();
   dynamic base64Image1;

  @override
  Widget build(BuildContext context) {
    return (widget.admin == null)
        ? Container()
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                   Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffC1BEBE),
                        radius: 62,
                        child: (widget.imageData == null)
                            ? Image.asset("assets/images/buisness_profile.png")
                            : ClipOval(
                                child: Image.memory(
                                  widget.imageData!,
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                  width:
                                      134, // Set the width and height to ensure the image is circular
                                  height: 134,
                                ),
                              ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Container(
                          width:
                              30, // Adjust the width of the container as needed
                          height:
                              30, // Adjust the height of the container as needed
                          decoration: BoxDecoration(
                            color: Color(
                                0xffC1BEBE), // You can set your desired background color
                            shape: BoxShape.circle, // This makes it a circle
                            //           boxShadow: [
                            // BoxShadow(
                            //   color: Colors.black.withOpacity(0.3), // Shadow color
                            //   spreadRadius: 2, // Spread radius
                            //   blurRadius: 4, // Blur radius
                            //   offset: const Offset(0, 2), // Offset
                            // ),
                            // ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: GestureDetector(
                              onTap: () {
                                final picker = ImagePicker();

                                Future<void> _openImagePicker() async {
                                  final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    final file = File(pickedFile.path);
                                    final bytes = await file.readAsBytes();
                                    final base64Image = base64Encode(bytes);
                                    final image =
                                        "data:image/png;base64,$base64Image";

                                    // Now you have the base64-encoded image
                                    // print("Base64 Image: $base64Image");
                                    // print(base64Image);

                                    setState(() {
                                      widget.imageData =
                                          bytes; // Set the picked image file
                                      // Update the profileAvatar URL
                                      base64Image1 = base64Image;
                                    });
                                                                                               ImageService imageService =ImageService();
              if (base64Image1 != null && base64Image1!=widget.imageData) {
      ImageService imageService = ImageService();
      await imageService.uploadImage(base64Image1, widget.admin.id);
    } 
                                    // print(base64Image1);

                                    // print(imgUrl);
                                  } else {
                                    // Handle no image picked error
                                  }
                                }

                                _openImagePicker();
                              },
                              child: Center(child: Icon(Icons.add)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    // Figma Flutter Generator CompanynameWidget - TEXT

                    Text(
                      widget.admin.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          height: 1),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      '+961 ${widget.admin.phone}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffA9A9AC),
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              begin: Alignment(1.5, 1),
                              end: Alignment(-1.5, 1),
                              colors: [
                                Color.fromRGBO(0, 61, 91, 1),
                                Color.fromRGBO(2, 91, 134, 0.8999999761581421)
                              ]),
                        ),
                        //                 decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   color: const Color.fromRGBO(196, 196, 196, 0.2),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 21,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      color: Color(0xffF2F2F7),
                      width: double.infinity,
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 22),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 122),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.admin.email,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date Of Birth",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.admin.dob,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Divider(
                        color: const Color(0xff8B8B91).withOpacity(0.1),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID",
                            style: TextStyle(
                                color: Color(0xff8B8B91),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                          Text(
                            widget.admin.id,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
//   Container(
//                 color: Color(0xffF2F2F7),
//                 width: double.infinity,
//                 height: 53,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top:18.0,left: 22),
//                   child: Text("Profile Details",style: TextStyle(
//                       color: Color.fromARGB(255, 117, 117, 122),
//                       fontFamily: 'Inter',
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       height: 1),
//                                   ),
//                 ),
//               ),
//  SizedBox(height:15),
//                Padding(
//                  padding: const EdgeInsets.only(left: 22,right: 22),
//                  child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                     GestureDetector(
//                       onTap:(){
//                         //  Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) =>  MyCars(cars:cars),
//                         //     ),
//                         //   );
//                       },
//                       child: Row(children: [
//                       Image.asset('assets/images/car_w.png',color: Colors.black,),
//                       SizedBox(width: 15,),
//                         Text('Cars',style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 18,
//                              fontWeight: FontWeight.w500,
//                              height: 1),
//                                          ),
//                       ],),
//                     ),
//                     Icon(Icons.arrow_forward_ios,size: 20,)

//                    ],
//                  ),
//                ),
//               SizedBox(height:10),

//               Padding(
//                 padding: const EdgeInsets.only(left:14.0,right: 14),
//                 child: Divider(
//                         color: const Color(0xff8B8B91).withOpacity(0.1),
//                       ),
//               ),
//               SizedBox(height:5),
//      Padding(
//                  padding: const EdgeInsets.only(left: 22,right: 22),
//                  child: GestureDetector(
//                   onTap:(){
//         // Navigator.push(
//         //                     context,
//         //                     MaterialPageRoute(
//         //                       builder: (context) =>  AllTransactions(company: company,mergedAndSorted:mergeAndSorted,),
//         //                     ),
//         //                   );
//                   },
//                    child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                       Row(children: [
//                       Image.asset('assets/images/Dollar Coin blue.png',color: Colors.black,),
//                       SizedBox(width: 15,),
//                         Text('Transactions',style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 18,
//                              fontWeight: FontWeight.w500,
//                              height: 1),
//                                          ),
//                       ],),
//                       Icon(Icons.arrow_forward_ios,size: 20,)

//                      ],
//                    ),
//                  ),
//                ),

                    SizedBox(height: 5),
                    Container(
                      color: Color(0xffF2F2F7),
                      width: double.infinity,
                      height: 53,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 22),
                        child: Text(
                          "Account",
                          style: TextStyle(
                              color: Color.fromARGB(255, 117, 117, 122),
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: GestureDetector(
                        // onTap: (){
                        onTap: () async {
                          await authenticationService.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/logout.png',
                                  color: Colors.black,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1),
                                ),
                              ],
                            ),
                            // Icon(Icons.arrow_forward_ios,size: 20,)
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          );
  }
}
