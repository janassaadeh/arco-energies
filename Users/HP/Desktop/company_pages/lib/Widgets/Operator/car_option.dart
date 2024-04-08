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
      padding:
          const EdgeInsets.only(top: 25.0, right: 25, left: 25, bottom: 12),
      child: GestureDetector(
        onTap: () {
          onSelect(vehicle);
        },
        child: SizedBox(
          height: 70,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // gradient: isSelected
              //     ? const LinearGradient(
              //         begin: Alignment.topRight,
              //         end: Alignment.bottomLeft,
              //         colors: [
              //           Color.fromRGBO(212, 210, 210, 1),
              //           Color.fromRGBO(93, 88, 88, 0.498)
              //         ],
              //       )
              //     : null,
              color: isSelected ? null : Colors.white,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: .0),
                  child: Container(
                    width: 78.86980438232422,
                    height: 69.47300720214844,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
                    child: Image.asset("assets/images/WhiteCar.png"),
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.model,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: isSelected
                            ? const Color.fromRGBO(209, 73, 91, 1)
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
