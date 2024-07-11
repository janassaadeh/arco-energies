import 'package:company_pages/Models/shift.dart';
import 'package:company_pages/Screens/Company/deposit_receipt.dart';
import 'package:company_pages/Screens/Company/transaction_receipt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';

class ShiftDetails extends StatefulWidget {
  Shift shift;
  ShiftDetails({Key? key, required this.shift}) : super(key: key);

  @override
  State<ShiftDetails> createState() => _ShiftDetailsState();
}

class _ShiftDetailsState extends State<ShiftDetails> {
  late Future<List<dynamic>> _combinedFuture;
  final TransactionService transactionService = TransactionService();
  final DepositService depositService = DepositService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    _combinedFuture = _fetchCombinedData();
  }

  Future<List<dynamic>> _fetchCombinedData() async {
    try {
      List<Transaction> transactions = widget.shift.transactions;
      List<DepositReceipt> deposits = widget.shift.deposits;

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .1,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Shift Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.abc,
                color: Color(0xff003D5B),
                size: 60,
              )
            ],
          ),
        ),
        leading: GestureDetector(
          child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 17),
              child: Image.asset(
                "assets/images/cancel.png",
                width: 15,
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff003D5B),
      ),
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
              child: FutureBuilder<List<dynamic>>(
                future: _combinedFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<dynamic> combinedList = snapshot.data ?? searchResults;

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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionReceipt(
                                          transaction: item)),
                                );
                              },
                              child: _buildTransactionItem(item));
                        } else if (item is DepositReceipt) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DepositDetails(receipt: item)),
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
