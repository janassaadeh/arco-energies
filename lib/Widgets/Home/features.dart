import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  final Color color;
  final String imageAsset;
  final String text;

  const Features(
      {super.key,
      required this.color,
      required this.imageAsset,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: const Alignment(-1.1779649257659912, -1.3327655792236328),
          end: const Alignment(1.3327656984329224, -1.139451026916504),
          colors: [color.withOpacity(1), color.withOpacity(0.5699999928474426)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: imageAsset=='assets/images/Gift.png'?63:imageAsset=='assets/images/Budget.png'?65:72,
                  width: imageAsset=='assets/images/Gift.png'?63:imageAsset=='assets/images/Budget.png'?65:72,
                  child: Image.asset(
                    imageAsset,fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
