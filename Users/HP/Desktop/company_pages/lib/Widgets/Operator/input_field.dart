import 'package:flutter/material.dart';

Widget buildInput(String hintText, Widget widgetAtLeft, bool withBorder,
    TextEditingController textEditingController,
    {bool isPressable = false}) {
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
            padding: isPressable
                ? const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18)
                : const EdgeInsets.symmetric(horizontal: 18.0),
            child: isPressable
                ? Text(
                    hintText,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                : TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
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
