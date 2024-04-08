import 'package:flutter/material.dart';

Widget buildInput(String hintText, Widget widgetAtLeft, bool withBorder,
    TextEditingController textEditingController) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: withBorder
          ? Border.all(
              color: Colors.black,
              width: 1,
            )
          : const Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              enabled: !(hintText=="Select Payment Method"),
),
            ),
          ),
        
        widgetAtLeft,
        const SizedBox(
          width: 15,
        )
      ],
    ),
  );
}
