import "package:flutter/material.dart";

Widget gradientBox(
    String txt, String imgPath, Color lightColor, Color darkColor) {
  return SizedBox(
    width: 171,
    height: 150,
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: 171,
            height: 150,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 171,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: const Alignment(
                            -1.1779649257659912, -1.3327655792236328),
                        end: const Alignment(
                            1.3327656984329224, -1.139451026916504),
                        colors: [
                          lightColor,
                          darkColor,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      letterSpacing: 0.3199999928474426,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 94,
          child: Opacity(
            opacity: 0.75,
            child: Container(
              width: 60,
              height: 68,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
