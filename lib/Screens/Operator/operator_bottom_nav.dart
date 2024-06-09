// import 'dart:html';
import 'dart:typed_data';

import 'package:company_pages/Screens/Operator/Home/DashBoard/dashboard.dart';
import 'package:company_pages/Screens/Operator/Profile/operator_profile.dart';
import 'package:company_pages/Services/Auth/user_service.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/material.dart';

import 'Transactions/new_transaction.dart';

class Operator extends StatefulWidget {
  const Operator({super.key});

  @override
  State<Operator> createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  dynamic operator;
  dynamic _imageData;

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    _fetchUserData().then((_) {
      // Call _getDepositList() only after _fetchUserData() completes
      _fetchImage();
    });
  }

  Future<void> _fetchUserData() async {
    try {
      UserService userService = UserService();
      dynamic userData = await userService.fetchUserData();
      setState(() {
        operator = userData;
      });
    } catch (e) {
      // Handle error appropriately, e.g., show a snackbar
      print('Error fetching operator: $e');
    }
  }

  Future<void> _fetchImage() async {
    try {
      ImageService imageService = ImageService();

      if (operator.imageId != null) {
        Uint8List imageData =
            await imageService.getImageFromId(operator.imageId);
        if (imageData != null) {
          setState(() {
            _imageData = imageData;
          });
        }
      } else {
        setState(() {
          _imageData = 'no image';
        });
        print('Image data is null.');
      }
    } catch (e) {
      // Handle errors
      print('Failed to fetch image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        toolbarHeight: 80,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width:200,
                child: Image.asset(fit:BoxFit.fill,"assets/images/arco_logo.png",color: Colors.white,)),
              // Padding(
              //   padding: const EdgeInsets.only(top:8.0),
              //   child: const Text(
              //     'rco Energies',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              const Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 40,
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xff003D58),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Gaspump.png",
              width: 28,
              color: _currentIndex == 1
                  ? const Color(0xff003D58)
                  : const Color.fromARGB(255, 114, 113, 113),
            ),
            label: 'Transactions',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return DashBoard(
          operator: operator,
          imageData: _imageData,
        );
      case 1:
        return  NewTransaction(operator:operator);
      case 2:
        return Profile(
          operator: operator,
          imageData: _imageData,
          // operator: operatorProvider.operator,
        );
      default:
        return Container();
    }
  }
}
