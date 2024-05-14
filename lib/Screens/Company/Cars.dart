import 'dart:typed_data';

import 'package:company_pages/Screens/Admin/CarCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/AddCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/CarDetails.dart';
import 'package:company_pages/Screens/Admin/Manage%20Cars/EditCar.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:company_pages/Screens/Admin/dis.dart';
import 'package:company_pages/Screens/Company/view%20car.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Models/vehicle.dart';
import '../../../Widgets/cars/CustomCarSearch.dart';
// import '../Car_Model.dart';


class MyCars extends StatefulWidget {
  final List<Vehicle> cars;
  final dynamic company;

  const MyCars({required this.cars,required this.company,Key? key}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}
class _MyCarsState extends State<MyCars> with SingleTickerProviderStateMixin {
 late List<SlidableController> controllers;
 double ratio=0.3;
 String searchQuery = '';
   late List<TickerProvider> tickerProviders;
     late List <Vehicle> filteredCars ;
     List<dynamic> imageDataList=[];

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
    fetchImageForFilteredCars();

  }
  
  Future<void> fetchImageForFilteredCars() async {
    ImageService _apiService = ImageService();

    // Initialize imageDataList with null values
    imageDataList = List.generate(filteredCars.length, (_) => null);

    for (int index = 0; index < filteredCars.length; index++) {
      String? imageId = filteredCars[index].imageId;
      try {
         if (imageId != '') {
          // Fetch image data using the provided image ID
          Uint8List imageData = await _apiService.getImageFromId(imageId!);
          setState(() {
            // Update the imageDataList with fetched image data
            imageDataList[index] = imageData;

          });
          
          
    print("${index} done ");

        }
    
      } catch (e) {
        // Handle errors
        print('Failed to fetch image for company at index $index: $e');
      }
    }
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
          child:  Text('All Cars',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.add,size:37,color: const Color(0xff003D5B),),
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
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 50), // Adjust the padding as needed

                        itemCount:filteredCars.length,
                        itemBuilder: (context, index) {
                          
                        
                        return Column(
                          children: [
                        GestureDetector(
                              onTap: () async {
                                              // Navigating to CarDetails
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewCar(car: filteredCars[index], company: widget.company,imageData: imageDataList[index],)),
                );

                // Handling the returned car object from CarDetails
              
                              },

          
                          child: Padding(
                            padding: EdgeInsets.only(bottom:0.0),
                            child: CarCard(
                              title: filteredCars[index].driverName,
                              subtitle1: filteredCars[index].model,
                              subtitle2:filteredCars[index].year.toString(),
                              imageData:(filteredCars[index].imageId=='')?'no image':imageDataList[index],
                          
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
                              // borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                            ),),
                    ),
                            Padding(
                padding: const EdgeInsets.only(top:15,left:15.0,right:15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                  
                  child: TextFormField(
                    // controller: searc,
                    onChanged: (value) {
                         setState(() {
      searchQuery = value;
      filteredCars = filterCars(); // Update filteredOperators when searchQuery changes
    });
    fetchImageForFilteredCars();
  
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Cars ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom:8.0),
                        child: Icon(Icons.search, color: Colors.grey[500]),
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
 Future<void> _showCupertinoLikeDialog(BuildContext context, int index, List<Vehicle> filteredCars) async {
  await showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this car?'),
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
                // Call deleteVehicleForCompany function to delete the car
                await vehicleCompanyService.deleteVehicleForCompany(widget.company.id, filteredCars[index].id);
                
                // Remove the car from the original list
                final carId = filteredCars[index].id;
                final carIndex = widget.cars.indexWhere((car) => car.id == carId);
                if (carIndex != -1) {
                  setState(() {
                    widget.cars.removeAt(carIndex);
                  });
                }

                // Remove the car from the filtered list
                setState(() {
                  filteredCars.removeAt(index);
                });

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
                    content: Text('Failed to delete car: $error'),
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
}
}

class _TickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
void doNothing(BuildContext context) {}

