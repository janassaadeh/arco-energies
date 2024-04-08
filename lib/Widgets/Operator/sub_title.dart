import "package:flutter/material.dart";

Widget subTitle(String txt) {
  return Text(
    txt,
    textAlign: TextAlign.left,
    style: const TextStyle(
      color: Color.fromRGBO(76, 76, 76, 1),
      fontFamily: 'Inter',
      fontSize: 17,
      letterSpacing: -0.3199999928474426,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  );
}
