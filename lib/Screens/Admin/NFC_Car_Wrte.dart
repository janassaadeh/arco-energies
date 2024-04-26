import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Transactions/pump_selection.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:company_pages/Widgets/Operator/car_option.dart';
import 'package:company_pages/Widgets/Operator/error_pop_up.dart';
import 'package:provider/provider.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'dart:convert';
import 'package:ndef/ndef.dart' as ndef; // Import the 'ndef' namespace

class WriteCarId extends StatefulWidget {
  const WriteCarId({Key? key}) : super(key: key);

  @override
  State<WriteCarId> createState() => _WriteCarIdState();
}

class _WriteCarIdState extends State<WriteCarId> {
  late Future<List<Vehicle>> _vehiclesFuture;
  final VehicleService vehicleService = VehicleService();
  Vehicle? _selectedVehicle;
  final TextEditingController _searchController = TextEditingController();
  List<Vehicle> searchResults = [];

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = _fetchVehicles();
  }

  Future<List<Vehicle>> _fetchVehicles() async {
    try {
      List<Vehicle> cachedVehicles =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedVehicles;

      if (cachedVehicles.isNotEmpty) {
        return cachedVehicles;
      } else {
        final List<Vehicle> vehicles = await vehicleService.getVehicles();
        // Cache fetched pumps
        Provider.of<TransactionProvider>(context, listen: false)
            .cachedVehicles = vehicles;
        return vehicles;
      }
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  Future<void> _refreshVehicles() async {
    setState(() {
      _vehiclesFuture = vehicleService.getVehicles();
    });
  }

  void _searchVehicles(String query) async {
    List<Vehicle> allVehicles = await _vehiclesFuture;

    setState(() {
      searchResults = allVehicles.where((vehicle) {
        return vehicle.color.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.plateNumber.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.driverName.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.model.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
        leading: Container(),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All Cars',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 40,
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
      backgroundColor: const Color(0xff003D58),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(height: 120, color: const Color(0xff003D58)),
                Container(
                  height: screenSize.height * .85,
                  color: Colors.white,
                  child: FutureBuilder<List<Vehicle>>(
                    future: _vehiclesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Vehicle>? vehicles = snapshot.data;
                        if (vehicles != null && vehicles.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await _refreshVehicles();
                            },
                            color: const Color(0xff003D58),
                            child: ListView.builder(
                              itemCount: searchResults.isNotEmpty
                                  ? searchResults.length
                                  : vehicles.length,
                              itemBuilder: (context, index) {
                                Vehicle vehicle = searchResults.isNotEmpty
                                    ? searchResults[index]
                                    : vehicles[index];
                                return CarOption(
                                  vehicle: vehicle,
                                  isSelected: vehicle == _selectedVehicle,
                                  onSelect: (selectedVehicle)async {


                                    setState(() {
                                      _selectedVehicle = selectedVehicle;
                                    });
                                    if (vehicle == _selectedVehicle) {
                                      final String vehicleId = vehicle.id;
                                   
                                    }
                                      showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return Container(
      height: 420, // Adjust height as needed
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.white,

        borderRadius: BorderRadius.circular(25)
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
              width: 76,
              child: Divider(thickness: 4,color:Color(0xffDEDEDE))),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Ready to Scan',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
              ),
              //     Divider(thickness: 1,color:Color(0xffDEDEDE)),
                    Container(
                      width: 165,
                      height: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Image.asset("assets/images/nfc read.gif",fit:BoxFit.contain)),
      
                // Text(rewards[index].title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
      SizedBox(height: 15,),
                Container(
                  width: 320,
                  child: Center(
                    child: Text(textAlign: TextAlign.center,'Hold your device near the NFC tag.'
                    ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  ),
                ),
            GestureDetector(

              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top:50,left:30.0,right:30),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xffD4D3D9),
            
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),)),
                  ),
              ),
            ),
            

      
          ],
        ),
      )
    );
  },
);
Future<void> writeCarIDToNFC(String carId) async {
  var availability = await FlutterNfcKit.nfcAvailability;
  if (availability != NFCAvailability.available) {
    print("NFC not available on this device.");
    return;
  }

  var tag = await FlutterNfcKit.poll(
    timeout: Duration(seconds: 10),
  );
  print(jsonEncode(tag));

  if (tag.ndefWritable != null && tag.ndefWritable!) {
    var ndefRecord = ndef.TextRecord(
      text: carId,
      language: 'en'
    );

    // Write NDEF record
    await FlutterNfcKit.writeNDEFRecords([ndefRecord, ndef.MimeRecord(decodedType: 'Content-type',
  payload: Uint8List.fromList(
    'vnd.com.example.company_pages'.codeUnits)),]);

    Navigator.pop(context);
    print("Car ID written successfully: $carId");
  } else {
    print("Tag is not writable.");
  }

  // Finish NFC operation
  await FlutterNfcKit.finish();
}

                await writeCarIDToNFC(vehicle.id);
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('No vehicles found');
                        }
                      }
                    },
                  ),
                ),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                ),
                SizedBox(
                  height: screenSize.height * .03,
                ),
                
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchVehicles(value);
                    },
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Search Cars ...",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset('assets/images/green-search.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
