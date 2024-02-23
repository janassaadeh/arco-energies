
import 'package:flutter/material.dart';

import '../../../../Widgets/profile/link.dart';

class Profile extends StatelessWidget {
// AuthenticationService authenticationService=AuthenticationService();

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
                    'Operaor Ashraf',
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
                    'ashraf@gmail.com',
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
                        const Link(
                          imagePath: "assets/images/email.png",
                          buttonText: 'ashraf@gmail.com',
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/name.png",
                          buttonText: "Ashraf Samir",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/phone.png",
                          buttonText: "03 123 456",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/location.png",
                          buttonText: "Mina Street, Tripoli",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                        const Link(
                          imagePath: "assets/images/calendar.png",
                          buttonText: "1980-4-23",
                        ),
                        Divider(
                          color: const Color(0xff9E9C9C).withOpacity(0.7),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 60,
              right: 140,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 67,
                child: CircleAvatar(
                  radius: 65,
                  child: Image.asset("assets/images/operator-profile.png"),
                ),
              ))
        ],
      ),
    );
  }
}
