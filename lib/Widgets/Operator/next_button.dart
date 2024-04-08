import 'package:company_pages/Widgets/Common/CustomButton.dart';
import 'package:flutter/material.dart';

Widget nextButton(String text, {required void Function() fn}) {
  return GestureDetector(
    onTap: () {
      fn();
    },
    child: CustomButton(buttonText: text),
  );
}
