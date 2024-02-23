import 'package:flutter/material.dart';

class PumpOption extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const PumpOption({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 152.95,
            height: 135,
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
            child: Center(
              child: Image.asset(
                "assets/images/pump.png",
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: const TextStyle(
                color: Color.fromRGBO(0, 61, 91, 1),
                fontFamily: 'Inter',
                fontSize: 18,
                letterSpacing: -0.4399999976158142,
                fontWeight: FontWeight.w500,
                height: 1.2777777777777777),
          ),
        ],
      ),
    );
  }
}
