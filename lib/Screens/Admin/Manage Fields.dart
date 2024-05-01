import 'package:flutter/material.dart';

class ManageFields extends StatelessWidget {
  final TextEditingController controller;
  final String imagePath;
  final String hintText;
  final bool? enabled;


  const ManageFields({super.key, 
    required this.controller,
    required this.imagePath,
    required this.hintText,
    this.enabled
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(196, 196, 196, 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8, top: 11),
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: (hintText=="Password"),
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed

            hintStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontFamily: 'Mulish',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: Image.asset(imagePath,color: Color(0xff666666),),
          ),
        ),
      ),
    );
  }
}


