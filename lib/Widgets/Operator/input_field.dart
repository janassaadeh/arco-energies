import 'package:flutter/material.dart';

Widget buildInput(String hintText, Widget widgetAtLeft, bool withBorder,
    TextEditingController textEditingController,
    {bool isPressable = false, void Function(String)? fn}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromRGBO(196, 196, 196, 0.2),
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
                : TextFormField(
                    controller: textEditingController,
                    onChanged: fn,
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
