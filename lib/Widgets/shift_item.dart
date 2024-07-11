import 'package:company_pages/Models/shift.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ShiftItem extends StatelessWidget {
  final Shift shift;
  final Function(Shift) onSelect;

  const ShiftItem({
    super.key,
    required this.shift,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = shift.status.toLowerCase() == 'active';

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 25, left: 25, bottom: 5),
      child: GestureDetector(
        onTap: () {
          onSelect(shift);
        },
        onDoubleTap: () {
          onSelect(shift);
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive
                  ? const Color.fromRGBO(0, 61, 91, 1)
                  : Colors.transparent, // Border color when active
              width: 2.5, // Border width
            ),
          ),
          child: Card(
            borderOnForeground: isActive,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            // margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isActive ? null : Colors.white,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/FullStop.png",
                      color: Colors.red,
                      width: 20,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shift.operator.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 61, 91, 1),
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
                              DateFormat.yMMMd()
                                  .add_jms()
                                  .format(shift.startTime),
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
                          ],
                        ),
                        Text(
                          shift.endTime != null
                              ? DateFormat.yMMMd()
                                  .add_jms()
                                  .format(shift.endTime!)
                              : "Shift In Progress",
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
                        Text(
                          "Transactions Total: ${shift.totalTransactionsAmount.toStringAsFixed(2)} \$",
                          style: TextStyle(
                            color: isActive
                                ? const Color.fromRGBO(209, 73, 91, 1)
                                : const Color.fromARGB(255, 1, 14, 72),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Deposits Total: ${shift.totalDepositsAmount.toStringAsFixed(2)} \$",
                          style: TextStyle(
                            color: isActive
                                ? const Color.fromRGBO(209, 73, 91, 1)
                                : const Color.fromARGB(255, 1, 14, 72),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
