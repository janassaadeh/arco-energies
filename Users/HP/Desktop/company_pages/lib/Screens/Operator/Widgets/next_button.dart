import 'package:flutter/material.dart';

import '../../../Widgets/Common/CustomButton.dart';

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
