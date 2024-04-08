
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';



class Companies extends StatefulWidget {
  final List <Company> companies;
  const Companies({Key? key,required this.companies}) : super(key: key);

  @override
  State<Companies> createState() => _MyCompaniesState();
}
class _MyCompaniesState extends State<Companies> with SingleTickerProviderStateMixin {
  late List<SlidableController> controllers;
  double ratio = 0.3;
  late List<TickerProvider> tickerProviders;
  String searchQuery = '';
 late List<Company> filteredCompanies;
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

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
                    child: ListView.builder(
                      itemCount: filteredCompanies.length,
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
                                    MaterialPageRoute(builder: (context) => CompanyDetails(company:filteredCompanies[index])),
                                  );
                                  if (newCompany!= filteredCompanies[index]) {
                                    setState(() {
                                      filteredCompanies[index]=newCompany;
                                    });
                                  }
                                },
                                child: CompanyCard(
                                  title: filteredCompanies[index].name,
                                  subtitle1: filteredCompanies[index].email,
                                  subtitle2: filteredCompanies[index].contactName,
                                  // subtitle3: '#${cars[index].carId}',
                                ),
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
      filteredCompanies = filterCompanies(); // Update filteredOperators when searchQuery changes
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
  
Future<void> _showCupertinoLikeDialog(BuildContext context, int index,List<Company>filteredCompanies) async {
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
                                final companyId = filteredCompanies[index].id;
final companyIndex = widget.companies.indexWhere((company) => company.id == companyId);

if (companyIndex != -1) {
    setState(() {
        widget.companies.removeAt(companyIndex);
    });
}

                // Filter companies again after deletion
                
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

