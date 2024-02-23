import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;

  CustomButton({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment(1.5, 1),
          end: Alignment(-1.5, 1),
          colors: [
            Color.fromRGBO(237, 174, 73, 0.5),
            Color.fromRGBO(237, 174, 73, 1),
            Color.fromRGBO(237, 174, 73, 0.5)
          ],
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Inter',
            fontSize: 21,
            letterSpacing: -0.44,
            fontWeight: FontWeight.normal,
            height: 1.0952380952380953,
          ),
        ),
      ),
    );
  }
}


