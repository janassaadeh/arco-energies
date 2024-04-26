import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Operator/next_button.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late Future<List<Transaction>> _transactionsFuture;
  final TransactionService transactionService = TransactionService();
  final TextEditingController _searchController = TextEditingController();
  List<Transaction> searchResults = [];

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _fetchTransactions();
    setupPushNotifications();
  }

  void _searchTransactions(String query) async {
    List<Transaction> allTransactions = await _transactionsFuture;

    setState(() {
      searchResults = allTransactions.where((transaction) {
        String vehicleCompanyName =
            transaction.vehicle.company.name.toLowerCase();
        String transactionDate = transaction.date.toLowerCase();
        String pumpId = transaction.pump.id.toLowerCase();
        // Customize the search criteria based on your requirements
        return vehicleCompanyName.contains(query.toLowerCase()) ||
            transactionDate.contains(query.toLowerCase()) ||
            pumpId.contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<List<Transaction>> _fetchTransactions() async {
    try {
      List<Transaction> cachedTransactions =
          Provider.of<TransactionProvider>(context, listen: false)
              .cachedTransactions;

      if (cachedTransactions.isNotEmpty) {
        return cachedTransactions;
      } else {
        final List<Transaction> transactions =
            await transactionService.getTransactions();
        // Cache fetched pumps
        Provider.of<TransactionProvider>(context, listen: false)
            .cachedTransactions = transactions;
        return transactions;
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _transactionsFuture = transactionService.getTransactions();
    });
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
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchTransactions(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Transactions ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshTransactions,
                color: const Color(0xff003D58),
                child: FutureBuilder<List<Transaction>>(
                  future: _transactionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Transaction> transactions =
                          snapshot.data ?? searchResults;
                      return ListView.builder(
                        reverse: true,
                        itemCount: searchResults.isNotEmpty
                            ? searchResults.length
                            : transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = searchResults.isNotEmpty
                              ? searchResults[index]
                              : transactions[index];
                          final total = transaction.quantity *
                              transaction.pump.fuel.fuelPrice!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/FullStop.png",
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
                                        // Text(transaction.)
                                      ],
                                    ),
                                    Text(
                                      transaction.date,
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
                                      'Total: ${transaction.pump.currency} ${total.toStringAsFixed(2)}',
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
}
