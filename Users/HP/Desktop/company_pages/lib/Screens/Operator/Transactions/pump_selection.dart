import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Operator/Transactions/odometer_value_entry.dart';
import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/text.dart';
import 'package:company_pages/Widgets/Operator/title.dart';
import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Services/Operator/pump_service.dart';
import 'package:company_pages/Widgets/Operator/pump_option.dart';

class PumpSelection extends StatefulWidget {
  const PumpSelection({Key? key}) : super(key: key);

  @override
  State<PumpSelection> createState() => _PumpSelectionState();
}

class _PumpSelectionState extends State<PumpSelection> {
  late Future<List<Pump>> _pumpsFuture;
  PumpService pumpService = PumpService();
  Pump? _selectedPump;

  @override
  void initState() {
    super.initState();
    _pumpsFuture = _fetchPumps();
  }

  Future<List<Pump>> _fetchPumps() async {
    try {
      return await pumpService.getPumps();
    } catch (e) {
      throw Exception('Failed to fetch pumps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
            ),
          ),
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
                _buildPathPoint("  Car  ", false, true),
                _buildPathPoint("Pump", true, false),
                _buildPathPoint("Odometer", false, false),
                _buildPathPoint("Liter", false, false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                buildTitleWidget("Select Pump", "2"),
                const SizedBox(height: 10),
                buildText("Select the pump you need to use for filling."),
                // const SizedBox(height: 20),
                SizedBox(
                  height: screenSize.height * .55,
                  child: FutureBuilder<List<Pump>>(
                    future: _pumpsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final List<Pump> pumps = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1,
                          ),
                          itemCount: pumps.length,
                          itemBuilder: (context, index) {
                            final Pump pump = pumps[index];
                            return PumpOption(
                              pump: pump,
                              isSelected: pump == _selectedPump,
                              onSelect: (selectedPump) {
                                setState(() {
                                  _selectedPump = selectedPump;
                                });
                                if (pump == _selectedPump) {
                                  final String pumpId = pump.id;
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .setSelectedPumpId(pumpId);
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                nextButton(
                  const OdometerValueEntry(),
                  context,
                  "Next",
                  fn: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathPoint(String name, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: isCompleted
                ? Colors.white
                : isActive
                    ? Colors.white
                    : Colors.transparent,
          ),
          child: isCompleted
              ? Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(114, 212, 171, 1),
                      border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(25, 25)),
                    ),
                    child: Image.asset(
                      'assets/images/Done.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : null, // If not completed, don't render anything inside the circle
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
}
