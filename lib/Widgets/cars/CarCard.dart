import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/CarDetails.dart';
import 'package:company_pages/Screens/Operator/Transactions/pump_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarCard extends StatelessWidget {
  final Vehicle vehicle;

  const CarCard({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 25.0, right: 25, left: 25, bottom: 12),
      child: GestureDetector(
        onDoubleTap: () {
          final String vehicleId = vehicle.id;
          // Provider for preserving the id in order to use at the end of the transaction process
          Provider.of<TransactionProvider>(context, listen: false)
              .setSelectedVehicleId(vehicleId);
          push(const PumpSelection(), context);
        },
        onTap: () {
          push(
              CarDetails(
                vehicle: vehicle,
              ),
              context);
        },
        child: SizedBox(
          height: 70,
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
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 61, 91, 1),
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
                        vehicle.model,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color(0xff72D4AB),
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
    );
  }
}