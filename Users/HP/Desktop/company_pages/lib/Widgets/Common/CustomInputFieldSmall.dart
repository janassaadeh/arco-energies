import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String imagePath;
  final String hintText;

  const CustomInputField({super.key, 
    required this.controller,
    required this.imagePath,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(196, 196, 196, 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed

            hintStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontFamily: 'Mulish',
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}


