import 'package:flutter/material.dart';

Widget buildImageContainer(String imgPath, bool needsPadding) {
  return Container(
    // width: 152.95,
    // height: 135,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        begin: Alignment(-1.1779649257659912, -1.3327655792236328),
        end: Alignment(1.3327656984329224, -1.139451026916504),
        colors: [
          Color.fromRGBO(114, 212, 171, 1),
          Color.fromRGBO(114, 212, 171, 0.57)
        ],
      ),
    ),
    child: Padding(
      padding: needsPadding
          ? const EdgeInsets.symmetric(vertical: 35.0)
          : const EdgeInsets.all(0),
      child: Center(
        child: Image.asset(
          imgPath,
          height: needsPadding ? 120 : null,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
