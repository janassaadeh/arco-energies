import 'package:company_pages/Screens/Admin/CarCard.dart';

import 'package:company_pages/Screens/Company/Car_Details.dart';
// import 'package:company_pages/Screens/CarDetails.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Models/vehicle.dart';



class Cars extends StatefulWidget {
  final List<Vehicle> cars;
  final dynamic company;

  const Cars({required this.cars,required this.company,Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _MyCarsState();
}
class _MyCarsState extends State<Cars> with SingleTickerProviderStateMixin {

 String searchQuery = '';

     late List <Vehicle> filteredCars ;

  @override
  void initState() {
    super.initState();

    filteredCars=filterCars();
  }
  // final List<Car> cars = [
  //   Car(
  //     model: "Toyota",
  //     plateNumber: "ABC123",
  //     year: 2020,
  //     color: "Red",
  //     driverName: "John Doe",
  //     modelName: "Camry",
  //     carId: 1,
  //   ),
  //   Car(
  //     model: "Honda",
  //     plateNumber: "XYZ789",
  //     year: 2018,
  //     color: "Blue",
  //     driverName: "Jane Smith",
  //     modelName: "Accord",
  //     carId: 2,
  //   ),
  // ];
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
        leading: Container(),
        title: Center(
          child:  Text('All Cars',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.add,size:37,color: Color(0xff003D5B),),
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
                        GestureDetector(
                              onTap: ()  {
                                              // Navigating to CarDetails
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarDetails(car: filteredCars[index], company: widget.company)),
                );

                // Handling the returned car object from CarDetails
                

                              },

          
                          child: CarCard(
                            title: filteredCars[index].driverName,
                            subtitle1: filteredCars[index].model,
                            subtitle2:filteredCars[index].year.toString(),
                            // subtitle3: '#${cars[index].carId}',
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
    );
  }}