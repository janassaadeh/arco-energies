import 'package:flutter/material.dart';

Widget horizontalGradientBox(context, String txt, String imgPath) {
  return Container(
    height: 130,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(2, 91, 135, 1),
          Color.fromRGBO(0, 61, 91, .6),
        ], // Gradient colors
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Text(
            txt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Image.asset(
            imgPath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}
