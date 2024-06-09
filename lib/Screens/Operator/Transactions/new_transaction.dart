import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Screens/Operator/Transactions/car_access.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Operator/next_button.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';

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

    List<Transaction> updatedTransactions =
        await transactionService.getTransactions();
    Provider.of<TransactionProvider>(context, listen: false)
        .cachedTransactions = updatedTransactions;
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

                      transactions.sort((a, b) => b.date.compareTo(a.date));

                      return ListView.builder(
                        itemCount: searchResults.isNotEmpty
                            ? searchResults.length
                            : transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = searchResults.isNotEmpty
                              ? searchResults[index]
                              : transactions[index];
                          String createdDate = transaction.date;
                          DateTime dateTime = DateTime.parse(createdDate);

                          final formattedDate =
                              DateFormat.yMMMd().add_jms().format(dateTime);
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
