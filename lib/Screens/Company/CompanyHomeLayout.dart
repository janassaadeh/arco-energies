import 'dart:typed_data';

import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Screens/Company/HomeScreen.dart';
import 'package:company_pages/Screens/Company/RewardScreen.dart';
// import 'package:company_pages/Screens/Company/RewardScreen.dart';
import 'package:company_pages/Screens/Company/profile.dart';
import 'package:company_pages/Services/Manage%20Accounts/vehicle_company_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/image_service.dart';
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
List <Transaction> transactionList=[];
List <dynamic> mergedAndSorted=[];
List <Reward> rewards=[];
dynamic _imageData;
dynamic cars;
var _currentIndex=0;
@override
void initState() {
  super.initState();
  
  _fetchUserData().then((_) {
    _getCars();
    // Call _getDepositList() only after _fetchUserData() completes
    _fetchImage();
    _getDepositList();
    _getReward();
    _getTransaction(company.id).then((_) {
      // Both _getDepositList() and _getTransaction() are completed here
      List<dynamic> mergedAndSorted1 = [...depositList!, ...transactionList!];

// Sort the combined list by time (from newest to oldest)
mergedAndSorted1.sort((a, b) {
  if (a is DepositReceipt && b is DepositReceipt) {
    // For DepositReceipt objects, compare timestamps in reverse order
    return b.timestamp.compareTo(a.timestamp);
  } else if (a is Transaction && b is Transaction) {
    // For Transaction objects, compare dates in reverse order
    return b.date.compareTo(a.date);
  } else if (a is DepositReceipt && b is Transaction) {
    // For mixed types, compare timestamp of DepositReceipt and date of Transaction
    return b.date.compareTo(a.timestamp);
  } else {
    // For mixed types, compare date of Transaction and timestamp of DepositReceipt
    return b.timestamp.compareTo(a.date);
  }
});

// Set the state with the sorted list
setState(() {
  mergedAndSorted = mergedAndSorted1;
});

// Print the sorted list
mergedAndSorted1.forEach((item) {
  print(item);
});

    });
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
Future<void> _getTransaction(String companyId) async {
  try {
    if (company == null) {
      print('Company data is not yet fetched.');
      return; // Exit the method if admin data is not available
    }

    TransactionService transactionService = TransactionService();
    List<Transaction> allTransactions = await transactionService.getTransactions();
    
    // Filter transactions for the specific company
    List<Transaction> companyTransactions = allTransactions.where((transaction) => transaction.vehicle.company.id == companyId).toList();

    setState(() {
      transactionList = companyTransactions;
    });
  } catch (e) {
    print('Error fetching transactions: $e');
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
    List<Reward> rewardsList = await rewardService.getAllRewards();
    setState(() {
      rewards = rewardsList;
    });

    if (rewards.isNotEmpty) {
      print('Rewards list fetched successfully:');
      rewards.forEach((reward) {
        print('rewards ID: ${reward.id}, pts: ${reward.pts}, desc: ${reward.description}');
      });
    } else {
      print('rewards list is empty.');
    }
  } catch (e) {
    // Handle error appropriately, e.g., show a snackbar
    print('Error fetching rewards list : $e');
  }
}

 Future<void> _fetchImage() async {
  try {
    ImageService imageService = ImageService();
    // Fetch image data using the image ID
// print(admin.imageId);
if(company.imageId!=null){
    Uint8List imageData = await imageService.getImageFromId(company.imageId);
 if (imageData != null) {
      // Update the state to trigger a rebuild with the fetched image data
      setState(() {
        _imageData = imageData;
      });
}
    // Check if imageData is not null before setting the state
   
      
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
Future<void>_getCars()async{
    VehicleCompanyService vehicleService=VehicleCompanyService();
                              final dynamic carslist=await vehicleService.getVehiclesForCompany(company.id);
    setState(() {
      cars=carslist;
    });

}
  @override
  Widget build(BuildContext context) {    
    Widget getBody() {
    switch (_currentIndex) {
      case 0:
        return  HomeScreen(company:company,depositList: depositList,transactionList:transactionList,mergedAndSorted: mergedAndSorted);
      case 1:
        return   RewardScreen(company:company,rewards:rewards);
      case 2:
        return Profile(company: company,imageData:_imageData,cars:cars,mergeAndSorted: mergedAndSorted,);
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