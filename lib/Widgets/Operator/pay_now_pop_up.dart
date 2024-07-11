import 'package:company_pages/Models/shift.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Services/Operator/shift_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:flutter/material.dart';

class PayNowPopUp extends StatefulWidget {
  const PayNowPopUp({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  State<PayNowPopUp> createState() => _PayNowPopUpState();
}

class _PayNowPopUpState extends State<PayNowPopUp> {
  final DepositService depositService = DepositService();
  final ShiftService shiftService = ShiftService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            "Do You Want To Pay Now?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Return false for "No"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 14, 72),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                child: const Text('No', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      double cashAmount = widget.transaction.quantity *
                          widget.transaction.pump.fuel.fuelPrice!;
                      var id = await depositService.addCashRequest(
                        cashAmount,
                        widget.transaction.vehicle.company.id,
                        "Pay Now",
                      );

                      await shiftService.addDepositToActiveShift(id);

                      Navigator.pop(context, true); // Return true for "Yes"
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => ErrorPopUp(
                            text: 'Failed to process the payment: $e'),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 14, 72),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
