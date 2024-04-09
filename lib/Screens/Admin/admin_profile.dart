import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Company/Company%20Details.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
//
import 'package:flutter/material.dart';

import '../../Widgets/profile/link.dart';

class AdminProfile extends StatelessWidget {
  AuthenticationService authenticationService = AuthenticationService();

  AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Image.asset("assets/images/wallpaper.png"),
              Container(
                color: Colors.white,
                height: 600,
                child: const Column(
                  children: [],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: Container(
              height: 700,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  // Figma Flutter Generator CompanynameWidget - TEXT
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Company Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'name@company.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 25.0, left: 25, top: 5, bottom: 5),
                    child: Column(
                      children: [
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                     
                        GestureDetector(
                            onTap: () {
                              // push(const CarDetails(), context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CompanyDetails(),
                                ),
                              );
                            },
                            child: const Link(
                              imagePath: "assets/images/profile.png",
                              buttonText: "Contact Information",
                            )),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/slider.png",
                          buttonText: "Preferences (notification prefrences)",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/stat.png",
                          buttonText: "Statistics (nb of users managed)",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/help.png",
                          buttonText: "Audit Logs (recent activities edit update)",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/help.png",
                          buttonText: "Help & Support",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/settings.png",
                          buttonText: "Account Settings",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        GestureDetector(
                            onTap: () async {
                              await authenticationService.logout();
                                       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>LoginScreen()));
                            },
                            child: const Link(
                              imagePath: "assets/images/logout.png",
                              buttonText: "Logout",
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
              top: 60,
              right: 140,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 67,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage("assets/images/company.png"),
                ),
              ))
        ],
      ),
    );
  }
}
