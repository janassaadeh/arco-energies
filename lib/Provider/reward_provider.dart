import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardProvider extends ChangeNotifier {
  List<dynamic> _rewardList = []; // List of companies

  // Getter for the company list
  List<dynamic> get rewardList => _rewardList;

  // Method to set the entire company list
  void setRewardList(List<dynamic> newList) {
    _rewardList = newList;
    notifyListeners(); // Notify listeners of the change
  }
}
