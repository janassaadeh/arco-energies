import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  CalendarBottomSheet({required this.selectedDate, required this.onDateSelected});

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  int _displayedYear = DateTime.now().year;
  int _displayedMonth = DateTime.now().month;

  void _changeYear(int newYear) {
    setState(() {
      _displayedYear = newYear;
      _focusedDay = DateTime(newYear, _displayedMonth);
    });
  }

  void _changeMonth(int newMonth) {
    setState(() {
      _displayedMonth = newMonth;
      _focusedDay = DateTime(_displayedYear, newMonth);
    });
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
    _displayedYear = _focusedDay.year;
    _displayedMonth = _focusedDay.month;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.5,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _changeYear(_displayedYear - 1);
                },
                icon: Icon(Icons.keyboard_arrow_left),
              ),
              Text(
                '$_displayedYear',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _changeYear(_displayedYear + 1);
                },
                icon: Icon(Icons.keyboard_arrow_right),
              ),
              IconButton(
                onPressed: () {
                  _changeMonth(_displayedMonth - 1);
                },
                icon: Icon(Icons.keyboard_arrow_left),
              ),
              Text(
                DateFormat('MMMM').format(DateTime(_displayedYear, _displayedMonth)),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _changeMonth(_displayedMonth + 1);
                },
                icon: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
          TableCalendar(
            firstDay: DateTime(1930, 1),
            lastDay: DateTime(2005, 12),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              rowDecoration: BoxDecoration(
                border: Border(top: BorderSide(color: const Color.fromARGB(255, 195, 194, 194))),
              ),
              defaultTextStyle: TextStyle(fontSize: 13)
            ),
            selectedDayPredicate: (day) => isSameDay(widget.selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              widget.onDateSelected(selectedDay);
              Navigator.pop(context);
            },
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) {
                return Center(
                  child: Container(
                    height:30,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            headerVisible: false,
          ),
        ],
      ),
    );
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
