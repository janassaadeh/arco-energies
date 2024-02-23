import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final String description;
  final int pointsText;

  RewardCard({
    required this.title,
    required this.description,
    required this.pointsText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/images/ticket.png",
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.only(left: 72, right: 102, top: 22, bottom: 12),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Space Grotesk',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(141, 141, 141, 1),
                            fontFamily: 'Space Grotesk',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: Image.asset(
                "assets/images/s1.png",
                width: 50,
                height: 50,
              ),
            ),
            Positioned(
              top: 15,
              right: 50,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "$pointsText pts ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Image.asset(
                        "assets/images/s1.png",
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: Text(
                      'Claim',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffD1495B),
                        fontFamily: 'Space Grotesk',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height:15)
      ],
    );
  }
}
