import 'package:flutter/material.dart';

Widget buildText(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: const TextStyle(
      color: Color.fromRGBO(147, 147, 147, 1),
      fontFamily: 'Inter',
      fontSize: 17,
      letterSpacing: -0.4399999976158142,
      fontWeight: FontWeight.normal,
      height: 1.2777777777777777,
    ),
  );
}
