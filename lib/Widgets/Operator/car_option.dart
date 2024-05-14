import 'package:company_pages/Models/vehicle.dart';

import 'package:flutter/material.dart';

class CarOption extends StatelessWidget {
  final Vehicle vehicle;
  final bool isSelected;
  final Function(Vehicle) onSelect;

  const CarOption({
    super.key,
    required this.vehicle,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 25, left: 25, bottom: 5),
      child: GestureDetector(
        onTap: () {
          onSelect(vehicle);
        },
        onDoubleTap: () {
          onSelect(vehicle);
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color.fromRGBO(0, 61, 91, 1)
                  : Colors.transparent, // Border color when selected
              width: 2.5, // Border width
            ),
          ),
          child: Card(
            borderOnForeground: isSelected,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            // margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 70,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? null : Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(209, 73, 91, 1),
                              Color.fromRGBO(209, 73, 91, 0.5)
                            ],
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Image.asset(
                          "assets/images/WhiteCar.png",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.model,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: isSelected
                                ? const Color.fromRGBO(232, 169, 69, 1)
                                : const Color.fromRGBO(0, 61, 91, 1),
                            fontFamily: 'Inter',
                            fontSize: 18,
                            letterSpacing: -0.44,
                            fontWeight: FontWeight.w800,
                            height: 1.28,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              vehicle.color,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 58, 184, 132),
                                fontFamily: 'Inter',
                                fontSize: 14,
                                letterSpacing: -0.44,
                                fontWeight: FontWeight.w600,
                                height: 1.28,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/dot.png'),
                            const SizedBox(width: 10),
                            Text(
                              vehicle.driverName,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xff777676),
                                fontFamily: 'Inter',
                                fontSize: 14,
                                letterSpacing: -0.44,
                                fontWeight: FontWeight.w600,
                                height: 1.28,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          vehicle.plateNumber,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing: -0.44,
                            fontWeight: FontWeight.w800,
                            height: 1.28,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vehicle.company!.name,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color.fromRGBO(209, 73, 91, 1)
                                  : Color.fromARGB(255, 1, 14, 72),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
