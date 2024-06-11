import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:company_pages/Screens/Company/transaction_receipt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:company_pages/Provider/deposit_provider.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:company_pages/Models/transaction.dart';
// import 'package:company_pages/Models/deposit_receipt.dart';
import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
import 'package:company_pages/Screens/Admin/New%20Deposit/SelectCompany.dart';
import 'package:company_pages/Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';

class NewTransaction extends StatefulWidget {
  dynamic operator;
  NewTransaction({Key? key, required this.operator}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late Future<List<dynamic>> _combinedFuture;
  final TransactionService transactionService = TransactionService();
  final DepositService depositService = DepositService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();
    _combinedFuture = _fetchCombinedData();
    setupPushNotifications();
  }

  Future<List<dynamic>> _fetchCombinedData() async {
    try {
      List<Transaction> transactions = await _fetchTransactions();
      List<DepositReceipt> deposits = await _fetchDeposits();

      List<dynamic> combinedList = [...transactions, ...deposits];
      combinedList.sort((a, b) {
        DateTime aDate = a is Transaction
            ? DateTime.parse(a.date)
            : DateTime.parse(a.timestamp);
        DateTime bDate = b is Transaction
            ? DateTime.parse(b.date)
            : DateTime.parse(b.timestamp);
        return bDate.compareTo(aDate);
      });

      return combinedList;
    } catch (e) {
      throw Exception('Failed to fetch combined data: $e');
    }
  }

  Future<List<Transaction>> _fetchTransactions() async {
    try {
      List<Transaction> cachedTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;

      if (cachedTransactions.isNotEmpty) {
        return cachedTransactions
            .where(
                (transaction) => transaction.operator.id == widget.operator.id)
            .toList();
      } else {
        final List<Transaction> transactions =
            await transactionService.getTransactions();

        // Filter the transactions by operatorId
        final filteredTransactions = transactions
            .where(
                (transaction) => transaction.operator.id == widget.operator.id)
            .toList();

        Provider.of<TransactionProvider>(context, listen: false)
            .cachedTransactions = filteredTransactions;

        return filteredTransactions;
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<List<DepositReceipt>> _fetchDeposits() async {
    try {
      List<DepositReceipt> cachedDeposits =
          Provider.of<DepositProvider>(context, listen: false).cachedDeposits;

      if (cachedDeposits.isNotEmpty) {
        return cachedDeposits;
      } else {
        final List<DepositReceipt> deposits = await depositService
            .getCashAdditionEventsByAdminId(widget.operator.id);

        Provider.of<DepositProvider>(context, listen: false).cachedDeposits =
            deposits;
        return deposits;
      }
    } catch (e) {
      throw Exception('Failed to fetch deposits: $e');
    }
  }

  void _searchTransactions(String query) async {
    List<dynamic> allData = await _combinedFuture;

    setState(() {
      searchResults = allData.where((item) {
        if (item is Transaction) {
          String vehicleCompanyName = item.vehicle.company.name.toLowerCase();
          String transactionDate = item.date.toLowerCase();
          String pumpId = item.pump.id.toLowerCase();
          return vehicleCompanyName.contains(query.toLowerCase()) ||
              transactionDate.contains(query.toLowerCase()) ||
              pumpId.contains(query.toLowerCase());
        } else if (item is DepositReceipt) {
          String depositDate = item.timestamp.toLowerCase();
          String amount = item.cashAmount.toString().toLowerCase();
          return depositDate.contains(query.toLowerCase()) ||
              amount.contains(query.toLowerCase());
        }
        return false;
      }).toList();
    });
  }

  Future<void> _refreshCombinedData() async {
    print('Refreshing combined data...');
    try {
      // Fetch new data
      await _updateCachedDeposits();
      await _updateCachedTransactions();

      List<Transaction> transactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;
      List<DepositReceipt> deposits =
          Provider.of<DepositProvider>(context, listen: false).cachedDeposits;
      // Update cached transactions and deposits

      List<dynamic> combinedList = [...transactions, ...deposits];
      combinedList.sort((a, b) {
        DateTime aDate = a is Transaction
            ? DateTime.parse(a.date)
            : DateTime.parse(a.timestamp);
        DateTime bDate = b is Transaction
            ? DateTime.parse(b.date)
            : DateTime.parse(b.timestamp);
        return bDate.compareTo(aDate);
      });
      setState(() {
        _combinedFuture = Future.value(combinedList);
      });
      print('Data refreshed successfully');
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }

  Future<void> _updateCachedTransactions() async {
    try {
      final List<Transaction> transactions =
          await transactionService.getTransactions();

      // Filter the transactions by operatorId
      final filteredTransactions = transactions
          .where((transaction) => transaction.operator.id == widget.operator.id)
          .toList();
      Provider.of<TransactionProvider>(context, listen: false)
          .cachedTransactions = transactions;
    } catch (e) {
      print('Error updating cached transactions: $e');
    }
  }

  Future<void> _updateCachedDeposits() async {
    try {
      // List<DepositReceipt> deposits = newData.whereType<DepositReceipt>().toList();
      final List<DepositReceipt> deposits = await depositService
          .getCashAdditionEventsByAdminId(widget.operator.id);
      Provider.of<DepositProvider>(context, listen: false).cachedDeposits =
          deposits;
    } catch (e) {
      print('Error updating cached deposits: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            buildInput(
              "Search Transactions ...",
              Icon(Icons.search, color: Colors.grey[500]),
              true,
              _searchController,
              fn: (value) {
                _searchTransactions(value);
              },
            ),
            const SizedBox(height: 15),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshCombinedData,
                color: const Color(0xff003D58),
                child: FutureBuilder<List<dynamic>>(
                  future: _combinedFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<dynamic> combinedList =
                          snapshot.data ?? searchResults;

                      return ListView.builder(
                        itemCount: searchResults.isNotEmpty
                            ? searchResults.length
                            : combinedList.length,
                        itemBuilder: (context, index) {
                          final item = searchResults.isNotEmpty
                              ? searchResults[index]
                              : combinedList[index];
                          if (item is Transaction) {
                            return GestureDetector(
                              onTap:(){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>TransactionReceipt(transaction:item)),
        );
      },
                              
                              child: _buildTransactionItem(item));
                          } else if (item is DepositReceipt) {
                            return GestureDetector(
                              onTap:(){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>DepositDetails(receipt:item)),
        );
      },
                              child: _buildDepositItem(item));
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: nextButton(
                "New Deposit",
                fn: () {
                  push(SelectCompany(), context);
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: nextButton(
                "New Transaction",
                fn: () {
                  push(const CarAccess(), context);
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    DateTime dateTime = DateTime.parse(transaction.date);
    final formattedDate = DateFormat.yMMMd().add_jms().format(dateTime);
    final total = transaction.quantity * transaction.pump.fuel.fuelPrice!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Image.asset(
            "assets/images/FullStop.png",
            color: Colors.red,
            width: 20,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    transaction.vehicle.company.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total: \$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(182, 34, 34, 1),
                ),
              ),
              Text(
                'Liters: ${transaction.quantity}',
                style: const TextStyle(
                  color: Color.fromRGBO(157, 194, 132, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositItem(DepositReceipt deposit) {
    DateTime dateTime = DateTime.parse(deposit.timestamp);
    final formattedDate = DateFormat.yMMMd().add_jms().format(dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Image.asset(
            "assets/images/FullStop.png",
            // color: Colors.red,
            width: 20,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deposit.companyName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Amount: \$${deposit.cashAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(182, 34, 34, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
