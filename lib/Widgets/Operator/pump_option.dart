import 'package:company_pages/Models/pump.dart';
import 'package:flutter/material.dart';

class PumpOption extends StatelessWidget {
  final Pump pump;
  final bool isSelected;
  final Function(Pump) onSelect;

  const PumpOption({
    super.key,
    required this.pump,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onSelect(pump);
      },
      child: Column(
        children: [
          Container(
            width: 140,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin:
                    const Alignment(-1.1779649257659912, -1.3327655792236328),
                end: const Alignment(1.3327656984329224, -1.139451026916504),
                colors: isSelected
                    ? [
                        const Color.fromRGBO(94, 181, 149, 1),
                        const Color.fromRGBO(94, 181, 149, 0.57)
                      ]
                    : [
                        const Color.fromRGBO(114, 212, 171, 1),
                        const Color.fromRGBO(114, 212, 171, 0.57)
                      ],
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/pump.png",
                width: 85,
                height: 85,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // const SizedBox(height: 5),
          Expanded(
            child: Text(
              pump.name,
              style: TextStyle(
                color: isSelected
                    ? Colors.black
                    : const Color.fromRGBO(0, 61, 91, 1),
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: -0.4399999976158142,
                fontWeight: FontWeight.w500,
                height: 1.2777777777777777,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class PumpCardOption extends StatefulWidget {
//   const PumpCardOption({
//     super.key,
//     required this.pump,
//     required this.onSelectPump,
//     required this.isSelected,
//   });

//   final Pump pump;
//   final void Function() onSelectPump;
//   final bool isSelected;

//   @override
//   State<PumpCardOption> createState() => _PumpCardOptionState();
// }

// class _PumpCardOptionState extends State<PumpCardOption> {
//   bool isTapped = false;

//   // bool isInUse(String status) {
//   //   status = status.toLowerCase();
// //
//   //   switch (status) {
//   //     case "in use":
//   //       return true;
//   //     case "out of service":
//   //       return false;
//   //     default:
//   //       return true;
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
        // setState(() {
        //   isTapped = !isTapped;
        // });
//         widget.onSelectPump();
//       },
//       child: Card(
//         // color: widget.isSelected
//         //     ? const Color.fromARGB(255, 140, 211, 255).withOpacity(.5)
//         //     : Theme.of(context).colorScheme.onPrimary,
//         elevation: widget.isSelected ? 25 : 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 152.95,
//               height: 135,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: LinearGradient(
//                   begin:
//                       const Alignment(-1.1779649257659912, -1.3327655792236328),
//                   end: const Alignment(1.3327656984329224, -1.139451026916504),
//                   colors: widget.isSelected
//                       ? [
//                           const Color.fromRGBO(94, 181, 149, 1),
//                           const Color.fromRGBO(94, 181, 149, 0.57)
//                         ]
//                       : [
//                           const Color.fromRGBO(114, 212, 171, 1),
//                           const Color.fromRGBO(114, 212, 171, 0.57)
//                         ],
//                 ),
//                 boxShadow: widget.isSelected
//                     ? [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           blurRadius: 4,
//                           offset: const Offset(0, 4),
//                         )
//                       ]
//                     : null,
//               ),
//               child: Center(
//                 child: Image.asset(
//                   "assets/images/pump.png",
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               widget.pump.name,
//               style: TextStyle(
//                 color: widget.isSelected
//                     ? Colors.black
//                     : const Color.fromRGBO(0, 61, 91, 1),
//                 fontFamily: 'Inter',
//                 fontSize: 18,
//                 letterSpacing: -0.4399999976158142,
//                 fontWeight: FontWeight.w500,
//                 height: 1.2777777777777777,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
