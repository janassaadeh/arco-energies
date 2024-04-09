
import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  // final String subtitle3;
  // final String imagePath;

  const CompanyCard({
    Key? key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    // required this.subtitle3,
    // required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:25.0,right: 25,left: 25,bottom: 12),
      child: Container(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: .0),
              child: Container(
                width: 78.86980438232422,
                height: 69.47300720214844,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color.fromRGBO(209, 73, 91, 1), Color.fromRGBO(209, 73, 91, 0.5)],
                  ),
                ),
                child: Image.asset("assets/images/CustomerW.png",color:Colors.white),
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 61, 91, 1),
                    fontFamily: 'Inter',
                    fontSize: 18,
                    letterSpacing: -0.44,
                    fontWeight: FontWeight.w800,
                    height: 1.28,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      subtitle1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff72D4AB),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing: -0.44,
                        fontWeight: FontWeight.w600,
                        height: 1.28,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset('assets/images/dot.png'),
                    SizedBox(width: 10),
                    Text(
                      subtitle2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff777676),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing: -0.44,
                        fontWeight: FontWeight.w600,
                        height: 1.28,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                // Text(
                //   subtitle3,
                //   textAlign: TextAlign.left,
                //   style: TextStyle(
                //     color: Color.fromRGBO(0, 0, 0, 1),
                //     fontFamily: 'Inter',
                //     fontSize: 14,
                //     letterSpacing: -0.44,
                //     fontWeight: FontWeight.w800,
                //     height: 1.28,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
