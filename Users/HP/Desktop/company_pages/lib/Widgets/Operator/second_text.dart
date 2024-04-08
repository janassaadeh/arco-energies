import "package:flutter/material.dart";

Widget buildSecondText(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Color.fromRGBO(147, 147, 147, 1),
      fontFamily: 'Inter',
      fontSize: 16,
      letterSpacing: -0.4399999976158142,
      fontWeight: FontWeight.normal,
      height: 1.5333333333333334,
    ),
  );
}
