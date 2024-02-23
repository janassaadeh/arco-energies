import 'package:flutter/material.dart';

import 'Common/CustomButton.dart';

Widget nextButton(Widget page, context, String text) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    child: CustomButton(buttonText: text),
  );
}
