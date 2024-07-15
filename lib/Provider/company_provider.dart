import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyProvider extends ChangeNotifier {
  List<Company> _companyList = []; // List of companies
  dynamic? _company ; // List of companies
dynamic? get company => _company;

  // Getter for the company list
  List<Company> get companyList => _companyList;
  void setCompany(dynamic company) {
    _company = company;
    notifyListeners(); // Notify listeners of the change
  }
  // Method to set the entire company list
  void setCompanyList(List<Company> newList) {
    _companyList = newList;
    notifyListeners(); // Notify listeners of the change
  }
}
