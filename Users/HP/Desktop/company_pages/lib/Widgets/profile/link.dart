import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback? onTap;

  const Link({
    Key? key,
    required this.imagePath,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
               
              ),
              SizedBox(width: 15),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_outlined, size: 20),
        ],
      ),
    );
  }
}
