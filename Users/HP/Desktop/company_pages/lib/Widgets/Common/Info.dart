import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String imagePath;
  final String title;
  final String content;

  const Info({super.key, 
    required this.imagePath,
    required this.title,
    required this.content,
  }) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (title=='Driver Name')?
          Image.asset(imagePath):

          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // Image.asset(imagePath),
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color.fromRGBO(0, 121, 140, 1),
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            content,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
