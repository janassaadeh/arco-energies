
import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/company_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Edit%20Company.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Services/Auth/AuthenticationService.dart';
import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
// import 'package:skeletonizer/skeletonizer.dart';
import 'dart:typed_data';



class Companies extends StatefulWidget {
  final List <Company> companies;
  final List<Pump> pumps;
  final List <Vehicle> allcars;
   Companies({Key? key,required this.companies,required this.allcars,required this.pumps}) : super(key: key);

  @override
  State<Companies> createState() => _MyCompaniesState();
}
class _MyCompaniesState extends State<Companies> with SingleTickerProviderStateMixin {
  late List<SlidableController> controllers;
  double ratio = 0.3;
  late List<TickerProvider> tickerProviders;
  String searchQuery = '';
 late List<Company> filteredCompanies;
List<dynamic?> imageDataList = [];


  @override
  void initState() {
    super.initState();
    tickerProviders = List.generate(
      widget.companies.length,
      (index) => _TickerProvider(),
    );
    controllers = List.generate(
      widget.companies.length,
      (index) => SlidableController(tickerProviders[index]),
    );
    filteredCompanies = filterCompanies(); // Filtered list of companies
    fetchImageForFilteredCompanies();

  }
    Map<String, int> getCarCountsPerCompany() {
    Map<String, int> carCounts = {};
    for (Company company in widget.companies) {
      int count = widget.allcars.where((car) => car.company!.id == company.id).length;
      carCounts[company.name] = count;
    }
    return carCounts;
  }
  Future<void> fetchImageForFilteredCompanies() async {
    ImageService _apiService = ImageService();

    // Initialize imageDataList with null values
    imageDataList = List.generate(filteredCompanies.length, (_) => null);

    for (int index = 0; index < filteredCompanies.length; index++) {
      String imageId = filteredCompanies[index].imageId;
      try {
         if (imageId != '') {
          // Fetch image data using the provided image ID
          Uint8List imageData = await _apiService.getImageFromId(imageId);
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
  List<Company> filterCompanies() {
    return widget.companies.where((company) {
      final name = company.name.toLowerCase();
      final email = company.email.toLowerCase();
      final contactName = company.contactName.toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || email.contains(query) || contactName.contains(query);
    }).toList();
  }
  

Future<void> refreshCompanies() async {
  CompanyService companyService = CompanyService();
  List<Company> updatedCompanies = await companyService.getAllCompanies();
  setState(() {
    filteredCompanies = updatedCompanies;
  });
  fetchImageForFilteredCompanies();
}





// Now imageDataList contains the image data for each filtered company


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
          child:  Text('All Companies',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: GestureDetector(
            onTap:  () async {
              final newCompany = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCompany()),
              );
              if (newCompany != null) {
                setState(() {
                  widget.companies.add(newCompany);
                  imageDataList.add('no image');
                  filteredCompanies.add(newCompany); // Add the new company to the list
                  controllers.add(SlidableController(_TickerProvider())); // Add a new SlidableController
                  tickerProviders.add(_TickerProvider()); // Add a new TickerProvider
                });
              }
            },
            child: Icon(Icons.add,size:37,color: Colors.white,)),
          )],
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
                    child: RefreshIndicator(
              onRefresh: () async {
                await refreshCompanies();
              },
              
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 50), // Adjust the padding as needed

                        itemCount: filteredCompanies.length,
                        itemBuilder: (context, index) {
                         Map<String, int> carCounts = getCarCountsPerCompany();
                          return 
                          
                          Column(
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
                                        controllers[index]?.close();
                                        _showCupertinoLikeDialog(context,index,filteredCompanies);
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
                                  onTap:  () async {
                                    final newCompany = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditCompany(company:filteredCompanies[index],imageData: imageDataList[index],allcars:widget.allcars,pumps: widget.pumps,)),
                                    );
                                    if (newCompany!= filteredCompanies[index]) {
                                      setState(() {
                                        filteredCompanies[index]=newCompany;
                                      });
                                    }
                                    
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom:0.0),
                                    child: CompanyCard(
                                      title:' ${filteredCompanies[index].name} (${carCounts[filteredCompanies[index].name]})',
                                      subtitle1: filteredCompanies[index].email,
                                      subtitle2: filteredCompanies[index].contactName,
                                      // imageId: filteredCompanies[index].imageId,
                                      imageData:(filteredCompanies[index].imageId=='')?'no image':imageDataList[index],
                                      activated: filteredCompanies[index].activated,
                                      // subtitle3: '#${cars[index].carId}',
                                    ),
                                  ),
                                ),
                                        
                              ),
                            ],
                          );
                        }
                      ),
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
      filteredCompanies = filterCompanies(); // Update filteredOperators when searchQuery changes
    });
    fetchImageForFilteredCompanies();
  
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Companies ...",
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
  //             Padding(
  //               padding: const EdgeInsets.only(top:15,left:15.0,right:15),
  //               child: Container(
  //                 // width: 328,
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(12),
  //                   color: Color.fromRGBO(255, 255, 255, 1),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.only(left: 10, right: 8, top: 12),
  //                   child: TextFormField(
  //                      onChanged: (value) {
  //   setState(() {
  //     searchQuery = value;
  //     filteredCompanies = filterCompanies(); // Update filteredOperators when searchQuery changes
  //   });
  //   fetchImageForFilteredCompanies();
  // },
  //                     decoration: InputDecoration(
  //                       border: OutlineInputBorder(borderSide: BorderSide.none),
  //                       // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed
  //                       hintText: "Search Companies ...",
  //                       hintStyle: TextStyle(
  //                         color: Color.fromRGBO(0, 0, 0, 0.5),
  //                         fontFamily: 'Mulish',
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.normal,
  //                       ),
  //                       suffixIcon: Padding(
  //                         padding: const EdgeInsets.only(bottom:8.0),
  //                         child: Image.asset('assets/images/red-slider.png'),
  //                       ),
  //                       prefixIcon: Padding(
  //                         // padding: const EdgeInsets.all(8.0),
  //                         padding: const EdgeInsets.only(bottom:8.0),

  //                         child: Image.asset('assets/images/green-search.png'),
  //                       ),

  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
            ],
          ),
        )
    );
  }
 Future<void> _showCupertinoLikeDialog(BuildContext context, int index, List<Company> filteredCompanies) async {
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
                CompanyService companyService = CompanyService();
                // Call deleteCompany function to delete the company
                await companyService.deleteCompany(filteredCompanies[index].id);
                
                // Remove the company from the original list
                final companyId = filteredCompanies[index].id;
                final companyIndex = widget.companies.indexWhere((company) => company.id == companyId);
                if (companyIndex != -1) {
                  setState(() {
                    widget.companies.removeAt(companyIndex);
                  });
                }

                // Remove the company from the filtered list
                setState(() {
                  filteredCompanies.removeAt(index);
                });

                Navigator.pop(context);

                // Show a success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Company deleted successfully'),
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
}

}

class _TickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
void doNothing(BuildContext context) {}

