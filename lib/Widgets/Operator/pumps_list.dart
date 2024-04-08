// import 'package:company_pages/Models/pump.dart';
// import 'package:company_pages/Widgets/Operator/pump_option.dart';
// import 'package:flutter/material.dart';

// class PumpsList extends StatefulWidget {
//   const PumpsList({
//     super.key,
//     required this.pumps,
//   });

//   final List<Pump> pumps;

//   @override
//   State<PumpsList> createState() => _PumpsListState();
// }

// class _PumpsListState extends State<PumpsList> {
//   int? selectedPumpIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 25.0, right: 15, left: 15),
//       child: Column(
//         children: [
//           Expanded(
//             // Wrap the Column with Expanded
//             child: SizedBox(
//               // height: double.infinity,
//               child: GridView.builder(
//                 itemCount: widget.pumps.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 6,
//                   crossAxisSpacing: 6,
//                   childAspectRatio: 1,
//                 ),
//                 itemBuilder: (ctx, index) {
//                   final pump = widget.pumps[index];
//                   return PumpCardOption(
//                     pump: pump,
//                     onSelectPump: () {
//                       // Update the selected pump index
//                       setState(() {
//                         selectedPumpIndex = index;
//                       });

//                       // Additional logic if needed when a pump is selected
//                       // For example, you can pass the selected pump to a function
//                       // or perform other actions.
//                       handleSelectedPump(pump);
//                     },
//                     isSelected: selectedPumpIndex == index,
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void handleSelectedPump(Pump pump) {
//     print('Selected pump: ${pump.name}');
//   }
// }
