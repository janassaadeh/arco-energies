// import 'package:company_pages/Models/vehicle.dart';
// import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
// import 'package:company_pages/Services/Operator/vehicle_service.dart';
// import 'package:company_pages/Widgets/cars/CustomCarSearch.dart';
// // import 'package:company_pages/Widgets/cars/CarCard.dart';
// import 'package:flutter/material.dart';

// import '../Admin/CarCard.dart';
// import '../Admin/Manage Cars/CarDetails.dart';

// class MyCars extends StatefulWidget {
//   final dynamic cars;
//   final dynamic company;

//   MyCars({ this.cars,this.company}) ;

//   @override
//   _MyCarsState createState() => _MyCarsState();
// }

// class _MyCarsState extends State<MyCars> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//          leading: GestureDetector(
//           onTap: (){
//             Navigator.pop(context);
//           },
//           child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
//         title: const Center(
//           child: Text(
//             'All Cars',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: const Color(0xff003D5B),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: Icon(
//               Icons.notifications,
//               size: 37,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       backgroundColor: const Color(0xff003D58),
//       body: SingleChildScrollView(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Column(
//               children: [
//                 Container(height: 120, color: const Color(0xff003D58)),
//                 Container(
//                   height: 700,
//                   color: Colors.white,
//                   child: ListView.builder(
//                           padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 50), // Adjust the padding as needed

//                     itemCount: widget.cars.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () async {
//                           // Navigating to CarDetails
//                           final newCar = await Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => CarDetails(car: widget.cars[index], company: widget.company)),
//                           );

//                           // Handling the returned car object from CarDetails
//                           if (newCar != null) {
//                             setState(() {
//                               widget.cars[index] = newCar; // Update the list with the edited car object
//                             });
//                           }
//                         },
//                         child: CarCard(
//                           title: widget.cars[index].driverName,
//                           subtitle1: widget.cars[index].model,
//                           subtitle2: widget.cars[index].year.toString(),
//                           imageData: 'no image',
//                           // subtitle3: '#${cars[index].carId}',
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 100.0),
//               child: Container(
//                 height: 30,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(0),
//                     topRight: Radius.circular(0),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 15, left: 15.0, right: 15),
//               child: CustomCarSearch(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
