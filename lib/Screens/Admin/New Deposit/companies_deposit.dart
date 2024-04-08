
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
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

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    final filteredCompanies = filterCompanies(); // Filtered list of companies

    return Scaffold(
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
}

