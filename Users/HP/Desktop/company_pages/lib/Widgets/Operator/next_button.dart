import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:flutter/material.dart';

Widget nextButton(Widget page, context, String text,
    {required void Function() fn}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
      fn();
    },
    child: CustomButton(buttonText: text),
  );
}
