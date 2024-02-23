import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;

  CodeBox({
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 8, bottom: 25),
        child: TextFormField(
          cursorColor: Color.fromRGBO(243, 243, 243, 1),
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: (value) {
            if (value.isEmpty) {
              FocusScope.of(context).requestFocus(previousFocusNode);
            } else {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
             counterText: '',
          ),
        ),
      ),
    );
  }
}
