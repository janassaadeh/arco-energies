import 'package:company_pages/Screens/Operator/Screens/Transactions/car_access_body.dart';
import 'package:flutter/material.dart';

class CarAccess extends StatelessWidget {
  const CarAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 40,
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        leading: GestureDetector(
          child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 17),
              child: Image.asset(
                "assets/images/cancel.png",
                width: 15,
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff003D5B),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPathPoint("  Car  ", true, () {}),
                // _buildPathLine(),
                _buildPathPoint("Pump", false, () {}),
                // _buildPathLine(),
                _buildPathPoint("Odometer", false, () {}),
                // _buildPathLine(),
                _buildPathPoint("Liter", false, () {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CarAccessBody(),
        ],
      ),
    );
  }

  Widget _buildPathPoint(
      String name, bool isActive, void Function() dotDestination) {
    return Column(
      children: [
        GestureDetector(
          onTap: dotDestination,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: isActive ? Colors.white : Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPathLine() {
    return Container(
      height: 2,
      width: 20,
      color: Colors.white,
    );
  }
}
