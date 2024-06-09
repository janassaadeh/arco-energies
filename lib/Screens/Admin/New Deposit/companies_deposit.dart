
import 'dart:typed_data';

import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';



class SelectCompanies extends StatefulWidget {
  final List <Company> companies;
  const SelectCompanies({Key? key,required this.companies}) : super(key: key);

  @override
  State<SelectCompanies> createState() => _MyCompaniesState();
}
class _MyCompaniesState extends State<SelectCompanies>  {

  String searchQuery = '';
 late List<Company> filteredCompanies;
List<dynamic?> imageDataList = [];


  @override
  void initState() {
    super.initState();
  
    filteredCompanies = filterCompanies(); // Filtered list of companies
    fetchImageForFilteredCompanies();

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

  @override
  Widget build(BuildContext context) {
    var filteredCompanies = filterCompanies(); // Filtered list of companies

    return     Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Center(
    child:  Text('All Companies',style: TextStyle(
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

                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap:  ()  {
                          Navigator.pop(context,filteredCompanies[index].id);
                        },
                        child: CompanyCard(
                          title: filteredCompanies[index].name,
                          subtitle1: filteredCompanies[index].email,
                          subtitle2: filteredCompanies[index].contactName,
                             imageData:(filteredCompanies[index].imageId=='')?'no image':imageDataList[index],
                              activated: filteredCompanies[index].activated,
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
      ],
    ),
          )
      );
  }
}

