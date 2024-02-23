import 'package:company_pages/Screens/Company/HomeScreen.dart';
import 'package:company_pages/Screens/Company/RewardScreen.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:flutter/material.dart';

// import 'AfterLogin/adminHome.dart'; //
class CompanyHomePageLayout extends StatefulWidget {
CompanyHomePageLayout({Key? key}) : super(key: key);

  @override
  State<CompanyHomePageLayout> createState() => _CompanyHomePageLayoutState();
}

class _CompanyHomePageLayoutState extends State<CompanyHomePageLayout> {
String name="John Doe";
var _currentIndex=0;
  @override
  void initState() {

    super.initState();

  }

  
  @override
  Widget build(BuildContext context) {    
    Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return  HomeScreen();
      case 1:
        return  RewardScreen();
      case 2:
        return Profile();
      default:
        return Container();
    }
  }
    return Scaffold(
      appBar:  AppBar(
        leading: Container(),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:50.0),
            child: Row(
              children: [
                Image.asset("assets/images/logoWhite.png"),
                const Text('rco Energies',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [const Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color: Colors.white,),
        )],
      ),
      bottomNavigationBar: BottomNavigationBar(
      elevation:0.0,
  selectedItemColor: Color(0xffD1495B), // Set the color for the selected item
  unselectedItemColor: Colors.grey.shade600, 
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/Voucher.png",color: (_currentIndex==1)?Color(0xffD1495B):Colors.grey.shade600,),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: 
       _getBody(),);}
      }