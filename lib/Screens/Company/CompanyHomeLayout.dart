import 'package:company_pages/Screens/Company/HomeScreen.dart';
import 'package:company_pages/Screens/Company/RewardScreen.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Services/Auth/user_service.dart' as User;

import '../../Services/deposit_service.dart';


// import 'AfterLogin/adminHome.dart'; //
class CompanyHomePageLayout extends StatefulWidget {
const CompanyHomePageLayout({Key? key}) : super(key: key);

  @override
  State<CompanyHomePageLayout> createState() => _CompanyHomePageLayoutState();
}

class _CompanyHomePageLayoutState extends State<CompanyHomePageLayout> {
String name="John Doe";
dynamic company;
List <DepositReceipt> depositList=[];
List <Reward> rewards=[];

var _currentIndex=0;
  @override
  void initState() {

    super.initState();
 _fetchUserData().then((_) {
    // Call _getDepositList() only after _fetchUserData() completes
    _getDepositList();
    _getReward();
  });
  }

  Future<void> _fetchUserData() async {
  try {
    User.UserService userService = User.UserService();
  dynamic userData = await userService.fetchUserData();
  setState(() {
    company=userData;
  });
  } catch (e) {
    // Handle error appropriately, e.g., show a snackbar
    print('Error fetching company: $e');
  }
}

Future<void> _getDepositList() async {
  try {
    if (company == null) {
      print('Company data is not yet fetched.');
      return; // Exit the method if admin data is not available
    }

    DepositService depositService = DepositService();
    List<DepositReceipt> adminDepositList = await depositService.getCashAdditionEventsByCompanyId(company.id);
    setState(() {
      depositList = adminDepositList;
    });

    if (depositList.isNotEmpty) {
      print('Deposit list fetched successfully:');
      depositList.forEach((receipt) {
        print('Receipt ID: ${receipt.id}, date: ${receipt.timestamp}, Amount: ${receipt.cashAmount}');
      });
    } else {
      print('Deposit list is empty.');
    }
  } catch (e) {
    // Handle error appropriately, e.g., show a snackbar
    print('Error fetching deposit list : $e');
  }
}

Future<void> _getReward() async {
  try {
    if (company == null) {
      print('Company data is not yet fetched.');
      return; // Exit the method if admin data is not available
    }

    RewardService rewardService = RewardService();
    List<Reward> rewardsList = await rewardService.getRewards(company.id);
    setState(() {
      rewards = rewardsList;
    });

    if (rewards.isNotEmpty) {
      print('Rewards list fetched successfully:');
      rewards.forEach((reward) {
        print('rewards ID: ${reward.id}, pts: ${reward.points}, desc: ${reward.description}');
      });
    } else {
      print('rewards list is empty.');
    }
  } catch (e) {
    // Handle error appropriately, e.g., show a snackbar
    print('Error fetching rewards list : $e');
  }
}
  @override
  Widget build(BuildContext context) {    
    Widget getBody() {
    switch (_currentIndex) {
      case 0:
        return  HomeScreen(company:company,depositList: depositList,);
      case 1:
        return   RewardScreen(company:company,rewards:rewards);
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
        actions: const [Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color: Colors.white,),
        )],
      ),
      bottomNavigationBar: BottomNavigationBar(
      elevation:0.0,
  selectedItemColor: const Color(0xffD1495B), // Set the color for the selected item
  unselectedItemColor: Colors.grey.shade600, 
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/Voucher.png",color: (_currentIndex==1)?const Color(0xffD1495B):Colors.grey.shade600,),
            label: 'Offers',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: 
       getBody(),);}
      }