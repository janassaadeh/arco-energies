
import 'package:company_pages/Models/company_response.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Models/vehicle_response.dart';
import 'package:company_pages/Screens/Admin/CarCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';



class SelectVehicle extends StatefulWidget {
  final List <Vehicle> cars;
  const SelectVehicle({Key? key,required this.cars}) : super(key: key);

  @override
  State<SelectVehicle> createState() => _SelectVehiclesState();
}
class _SelectVehiclesState extends State<SelectVehicle>  {

  String searchQuery = '';

  @override
  void initState() {
    super.initState();

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
    final filteredCars = filterCars(); // Filtered list of companies

    return     WillPopScope(
        onWillPop: () async {
          // Prevent back button press
          return false;
        },
            child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Center(
            child:  Text('All Cars',style: TextStyle(
                    color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                  ),),
          ),
          backgroundColor: const Color(0xff003D5B),
         
          ),
          backgroundColor: Color(0xff003D58),
          body: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
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

                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap:  ()  {
                             // Assuming filteredCars[index].company is nullable
CompanyResponse? companyResponse = filteredCars[index].company;
if (companyResponse != null) {
  VehicleResponse vehicleResponse = VehicleResponse(
    id: filteredCars[index].id,
    year: filteredCars[index].year,
    model: filteredCars[index].model,
    color: filteredCars[index].color,
    company: companyResponse,
    type: filteredCars[index].type,
    plateNumber: filteredCars[index].plateNumber,
    driverName: filteredCars[index].driverName,
  );
                                  Navigator.pop(context,vehicleResponse);

  // Handle vehicleResponse
} else {
  // Handle the case when filteredCars[index].company is null
}

                                },
                                child: CarCard(
                                        title: filteredCars[index].driverName,
                                        subtitle1: filteredCars[index].model,
                                        subtitle2:filteredCars[index].year.toString(),
                                        imageData:'no image',
                                    
                                        // subtitle3: '#${cars[index].carId}',
                                      ),
                              ),
                            ],
                          );
                        }
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
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed
                          hintText: "Search Cars ...",
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
      ),
    );
  }
}

