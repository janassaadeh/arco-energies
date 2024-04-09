
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/AddOperator.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/Operator%20Details.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import 'operator_model.dart';



class Operators extends StatefulWidget {
  final List <Operator> operators;
  const Operators({Key? key,required this.operators}) : super(key: key);

  @override
  State<Operators> createState() => _MyOperatorsState();
}
class _MyOperatorsState extends State<Operators> with SingleTickerProviderStateMixin {
  late List<SlidableController> controllers;
  double ratio = 0.3;
  late List<TickerProvider> tickerProviders;
  String searchQuery = '';
 late List<Operator> filteredOperators;
 
  @override
  void initState() {
    super.initState();
    tickerProviders = List.generate(
      widget.operators.length,
      (index) => _TickerProvider(),
    );
    controllers = List.generate(
      widget.operators.length,
      (index) => SlidableController(tickerProviders[index]),
    );
    filteredOperators = filterOperators(); // Filtered list of companies

  }

  // Method to filter companies based on search query
  List<Operator> filterOperators() {
    return widget.operators.where((op) {
      final name = op.name.toLowerCase();
      final email = op.email.toLowerCase();
      final address = op.address.toLowerCase();
      final phone=op.phone.toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || email.contains(query) || address.contains(query) || phone.contains(query);
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
          child:  Text('All Operators',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [ Padding(
          padding: EdgeInsets.only(right:8.0),
          child: GestureDetector(
            onTap:  () async {
              final newOperator = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddOperator()),
              );
              if (newOperator != null) {
                setState(() {
                  filteredOperators.add(newOperator); // Add the new company to the list
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
                      itemCount: filteredOperators.length,
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
                                      _showCupertinoLikeDialog(context,index,filteredOperators);
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
                                  final newOperator = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => OperatorDetails(operator:filteredOperators[index])),
                                  );
                                  if (newOperator!= filteredOperators[index]) {
                                    setState(() {
                                      filteredOperators[index]=newOperator;
                                    });
                                  }
                                },
                                child: CompanyCard(
                                  title: filteredOperators[index].name,
                                  subtitle1: filteredOperators[index].email,
                                  subtitle2: filteredOperators[index].phone,
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
      filteredOperators = filterOperators(); // Update filteredOperators when searchQuery changes
    });
  },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        // contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding as needed
                        hintText: "Search Operators ...",
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
  
Future<void> _showCupertinoLikeDialog(BuildContext context, int index,List<Operator>filteredOperators) async {
  await showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this operator?'),
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
                OperatorService operatorService = OperatorService();
                // Call deleteCompany function to delete the company
                await operatorService.deleteOperator(filteredOperators[index].id);
                                final operatorId = filteredOperators[index].id;
final operatorIndex = widget.operators.indexWhere((operator) => operator.id == operatorId);

if (operatorIndex != -1) {
    setState(() {
        widget.operators.removeAt(operatorIndex);
    });
}

                // Filter companies again after deletion
                
                Navigator.pop(context);

                // Show a success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Operator deleted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (error) {
                // Show an error Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete operator: $error'),
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

