import 'package:flutter/material.dart';

class CustomCarSearch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 328,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 8, top: 12),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
                // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed
            hintText: "Search Cars ...",
            hintStyle: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontFamily: 'Mulish',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: Image.asset('assets/images/red-slider.png'),
            ),
            prefixIcon: Padding(
              // padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(bottom:8.0),

              child: Image.asset('assets/images/green-search.png'),
            ),

          ),
        ),
      ),
    );
  }
}


