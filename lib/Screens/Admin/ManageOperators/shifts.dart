import 'package:company_pages/Screens/Admin/ManageOperators/shift_details.dart';
import 'package:company_pages/Screens/Auth/Login.dart';
import 'package:company_pages/Widgets/Common/confirmation_dialog.dart';
import 'package:company_pages/Widgets/shift_item.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/shift.dart';
import 'package:company_pages/Provider/transaction_provider.dart';
import 'package:company_pages/Services/Operator/shift_service.dart';
import 'package:company_pages/Widgets/Operator/input_field.dart';
import 'package:provider/provider.dart';

class ShiftsList extends StatefulWidget {
  const ShiftsList({Key? key}) : super(key: key);

  @override
  State<ShiftsList> createState() => _ShiftsListState();
}

class _ShiftsListState extends State<ShiftsList> {
  late Future<List<Shift>> _shiftsFuture;
  final ShiftService shiftService = ShiftService();
  Shift? _selectedShift;
  final TextEditingController _searchController = TextEditingController();
  List<Shift> searchResults = [];

  @override
  void initState() {
    super.initState();
    _shiftsFuture = _fetchShifts();
  }

  Future<List<Shift>> _fetchShifts() async {
    try {
      List<Shift> cachedShifts =
          Provider.of<TransactionProvider>(context, listen: false).cachedShifts;

      if (cachedShifts.isNotEmpty) {
        cachedShifts.sort((a, b) => b.startTime.compareTo(a.startTime)); // Sort shifts by date
        return cachedShifts;
      } else {
        final List<Shift> shifts = await shiftService.getAllShifts();
        shifts.sort((a, b) => b.startTime.compareTo(a.startTime)); // Sort shifts by date
        Provider.of<TransactionProvider>(context, listen: false).cachedShifts =
            shifts;
        return shifts;
      }
    } catch (e) {
      throw Exception('Failed to fetch shifts: $e');
    }
  }

  Future<void> _refreshShifts() async {
    setState(() {
      _shiftsFuture = shiftService.getAllShifts();
    });

    List<Shift> updatedShifts = await shiftService.getAllShifts();
    updatedShifts.sort((a, b) => b.startTime.compareTo(a.startTime)); // Sort shifts by date
    Provider.of<TransactionProvider>(context, listen: false).cachedShifts =
        updatedShifts;
  }

  void _searchShifts(String query) async {
    List<Shift> allShifts = await _shiftsFuture;

    setState(() {
      searchResults = allShifts.where((shift) {
        return shift.operator.name
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            shift.operator.id.toLowerCase().contains(query.toLowerCase()) ||
            shift.operator.email.toLowerCase().contains(query.toLowerCase()) ||
            shift.status.toLowerCase().contains(query.toLowerCase()) ||
            shift.operator.phone.contains(query.toLowerCase());
      }).toList();
      searchResults.sort((a, b) => b.startTime.compareTo(a.startTime)); // Sort search results by date
    });
  }

    void deleteAllNotifications() {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        content: 'Delete all notifications?',
        onCancel: () {
          Navigator.pop(ctx);
        },
        onConfirm: () async {
          try {
            Navigator.pop(ctx);
            // final shifts =
            //     Provider.of<TransactionProvider>(context, listen: false)
            //         .cachedShifts;
          
            await shiftService.deleteAllShifts();

            Provider.of<TransactionProvider>(context, listen: false)
                .clearCachedShifts();
            _refreshShifts();
          } catch (e) {
            print('Failed to delete shifts: $e');
          }
        },
      ),
    );
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
                'All Shifts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Icon(
              //   Icons.abc,
              //   color: Color(0xff003D5B),
              //   size: 60,
              // )
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
        actions: [
          IconButton(
            onPressed: () {
              deleteAllNotifications();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
        backgroundColor: const Color(0xff003D5B),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: buildInput(
              "Search Shifts ...",
              Image.asset('assets/images/green-search.png'),
              true,
              _searchController,
              fn: (value) {
                _searchShifts(value);
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: FutureBuilder<List<Shift>>(
                future: _shiftsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Shift>? shifts = snapshot.data;
                    if (shifts != null && shifts.isNotEmpty) {
                      // Sort shifts by date before displaying
                      shifts.sort((a, b) => b.startTime.compareTo(a.startTime));
                      return RefreshIndicator(
                        onRefresh: () async {
                          await _refreshShifts();
                        },
                        color: const Color(0xff003D58),
                        child: ListView.builder(
                          itemCount: searchResults.isNotEmpty
                              ? searchResults.length
                              : shifts.length,
                          itemBuilder: (context, index) {
                            Shift shift = searchResults.isNotEmpty
                                ? searchResults[index]
                                : shifts[index];
                            return ShiftItem(
                              shift: shift,
                              onSelect: (selectedShift) {
                                push(ShiftDetails(shift: shift), context);
                                setState(() {
                                  _selectedShift = selectedShift;
                                });
                                if (shift == _selectedShift) {
                                  final String shiftId = shift.id;
                                  print(shiftId);
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text('No shifts found'));
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
