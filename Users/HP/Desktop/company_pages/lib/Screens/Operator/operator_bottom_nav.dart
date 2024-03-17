import 'package:company_pages/Screens/Operator/Home/DashBoard/dashboard.dart';
import 'package:company_pages/Screens/Operator/Profile/operator_profile.dart';
import 'package:flutter/material.dart';

import 'Transactions/new_transaction.dart';

class Operator extends StatefulWidget {
  const Operator({super.key});

  @override
  State<Operator> createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logoWhite.png"),
              const Text(
                'rco Energies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(209, 73, 91, 1),
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
                  ? const Color.fromRGBO(209, 73, 91, 1)
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
        return const DashBoard();
      case 1:
        return const NewTransaction();
      case 2:
        return const Profile(
            // operator: operatorProvider.operator,
            );
      default:
        return Container();
    }
  }
}
