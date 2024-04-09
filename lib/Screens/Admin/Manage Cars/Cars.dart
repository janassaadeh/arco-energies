import 'package:company_pages/Screens/Admin/CarCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/AddCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/CarDetails.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Admin/dis.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Models/vehicle.dart';
import '../../../Widgets/cars/CustomCarSearch.dart';
import '../Car_Model.dart';


class Cars extends StatefulWidget {
  final List<Vehicle> cars;
  final Company company;

  const Cars({required this.cars,required this.company,Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _MyCarsState();
}
class _MyCarsState extends State<Cars> with SingleTickerProviderStateMixin {
 late List<SlidableController> controllers;
 double ratio=0.3;
 String searchQuery = '';
   late List<TickerProvider> tickerProviders;
     late List <Vehicle> filteredCars ;

  @override
  void initState() {
    super.initState();
    tickerProviders = List.generate(
      widget.cars.length,
      (index) => _TickerProvider(),
    );
    controllers = List.generate(
      widget.cars.length,
      (index) => SlidableController(tickerProviders[index]),
    );
    filteredCars=filterCars();
  }
  
  // Method to filter companies based on search query
  List<Vehicle> filterCars() {
    return widget.cars.where((car) {
      final color = car.color.toLowerCase();
      final driverName = car.driverName.toLowerCase();
      final model = car.model.toLowerCase();
      final plateNumber = car.plateNumber.toLowerCase();

      final query = searchQuery.toLowerCase();
      return color.contains(query) || driverName.contains(query) || model.contains(query)|| plateNumber.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Center(
          child:  Text('${widget.company.name}\'s Cars',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: GestureDetector(
            onTap:  () async {
            final newCar = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCar(company: widget.company,)),
            );
            if (newCar != null) {
                 setState(() {
                  filteredCars.add(newCar); // Add the new company to the list
                  controllers.add(SlidableController(_TickerProvider())); // Add a new SlidableController
                  tickerProviders.add(_TickerProvider()); // Add a new TickerProvider
                });
            }
          },
            child: Icon(Icons.add,size:37,color: Colors.white,)),
        )],
      ),
      backgroundColor: Color(0xff003D58),
body: 
          SingleChildScrollView(
           
            child: Stack(clipBehavior: Clip.none,
              children: [
                
                
          
                Column(
                  children: [
                    Container(
                      height: 120,
                      color:Color(0xff003D58)),
                    Container(
                        color: Colors.white,
                        height: 652,
                      
                      child: ListView.builder(
                        itemCount:filteredCars.length,
                        itemBuilder: (context, index) {
                          
                        
                        return Column(
                          children: [
                        Slidable(
                                   key: ValueKey(index),
                                  controller: controllers[index],
                                  endActionPane: ActionPane(
                                    extentRatio: ratio,
                                    motion: const ScrollMotion(),
                                       
                                    children: [
                                       GestureDetector(
                                        onTap: (){
                                         controllers[index].close();
                                           _showCupertinoLikeDialog(context,index,filteredCars);
                                           
                                        },
                                         child: Padding(
                                           padding: const EdgeInsets.only(top:18,left:22,bottom:18),
                                           child: Container(
                                            decoration: BoxDecoration(
                                            color:Colors.red,
                                            borderRadius: BorderRadius.circular(12)
                                            ),
                                            width: 88,
                                             child: Padding(
                                                                padding: const EdgeInsets.only(top:18,bottom:12),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(Icons.delete, color: Colors.white,size: 20,),
                                                                    SizedBox(height: 1,),
                                                                    Text("Delete",style: TextStyle(color:Colors.white, fontSize: 14,fontWeight: FontWeight.bold),)
                                                                  ],
                                                                ),
                                             ),
                                           ),
                                         ),
                                       ),
                                    ],
                                    
                                  ),
                                  
                                  child: GestureDetector(
                                        onTap: () async {
                                                        // Navigating to CarDetails
                final newCar = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarDetails(car: filteredCars[index], company: widget.company)),
                );

                // Handling the returned car object from CarDetails
                if (newCar != null) {
                  setState(() {
                    filteredCars[index] = newCar; // Update the list with the edited car object
                  });
                }

                                        },

          
                                    child: CarCard(
                                      title: filteredCars[index].driverName,
                                      subtitle1: filteredCars[index].model,
                                      subtitle2:filteredCars[index].year.toString(),
                                      // subtitle3: '#${cars[index].carId}',
                                    ),
                                  ),
                                  
                                ),
                          ],
                        );}
                      ),
                    ),
                  ],
                ),
                    Padding(
                      padding: const EdgeInsets.only(top:100.0),
                      child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                            ),),
                    ),
              Padding(
                padding: const EdgeInsets.only(top:15,left:15.0,right:15),
                child: Container(
                  // width: 328,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 8, top: 12),
                    child: TextFormField(
                       onChanged: (value) {
    setState(() {
      searchQuery = value;
      filteredCars = filterCars(); // Update filteredOperators when searchQuery changes
    });
  },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed
                        hintText: "Search Companies ...",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Image.asset('assets/images/red-slider.png'),
                        ),
                        prefixIcon: Padding(
                          // padding: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.only(bottom:8.0),

                          child: Image.asset('assets/images/green-search.png'),
                        ),

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
 Future<void> _showCupertinoLikeDialog(BuildContext context, int index,List<Vehicle>filteredCars) async {
  await showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this company?'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF0169AA), fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'Confirm',
              style: TextStyle(color: Color(0xFF0169AA)),
            ),
            onPressed: () async {
              try {
                VehicleCompanyService vehicleCompanyService = VehicleCompanyService();
                // Call deleteCompany function to delete the company
                await vehicleCompanyService.deleteVehicleForCompany(widget.company.id,filteredCars[index].id);
                                final carId = filteredCars[index].id;
final carIndex = widget.cars.indexWhere((car) => car.id == carId);

if (carIndex != -1) {
    setState(() {
        widget.cars.removeAt(carIndex);
    });
}

                // Filter companies again after deletion
                
                Navigator.pop(context);

                // Show a success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Car deleted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (error) {
                // Show an error Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete company: $error'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}}

class _TickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
void doNothing(BuildContext context) {}

