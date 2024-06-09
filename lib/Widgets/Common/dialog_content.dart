import 'package:flutter/material.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';

class DialogContent extends StatelessWidget {
  final TextEditingController fuel95Controller;
  final TextEditingController fuel98Controller;
  final TextEditingController dieselController;
  final bool isLoading;
  final Future<void> Function() onSend;

  const DialogContent({
    Key? key,
    required this.fuel95Controller,
    required this.fuel98Controller,
    required this.dieselController,
    required this.isLoading,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSection(
            title: 'Fuel 98 Price',
            child: buildInput(
              "Enter Fuel 98 Price",
              dollarText(),
              true,
              fuel98Controller,
            ),
          ),
          const SizedBox(height: 10),
          _buildSection(
            title: 'Fuel 95 Price',
            child: buildInput(
              "Enter Fuel 95 Price",
              dollarText(),
              true,
              fuel95Controller,
            ),
          ),
          const SizedBox(height: 10),
          _buildSection(
            title: 'Diesel Price',
            child: buildInput(
              "Enter Diesel Price",
              dollarText(),
              true,
              dieselController,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 14, 72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: isLoading ? null : onSend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 14, 72),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                ),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 1, 14, 72),
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }

  Widget dollarText() {
    return const Text(
      '\$ / liter',
      style: TextStyle(
        color: Color.fromRGBO(114, 212, 171, 1),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
