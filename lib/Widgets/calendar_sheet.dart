import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  CalendarBottomSheet({required this.selectedDate, required this.onDateSelected});

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
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
          SfCalendar(
            view: CalendarView.month,
            headerHeight: 0,
            todayHighlightColor: Colors.grey[300],
            backgroundColor: Colors.transparent,
            initialSelectedDate: widget.selectedDate,
            monthViewSettings: MonthViewSettings(showTrailingAndLeadingDates: false),
            onTap: (CalendarTapDetails details) {
              widget.onDateSelected(details.date!);
              Navigator.pop(context);
            },
            onViewChanged: (ViewChangedDetails details) {
              _focusedDay = details.visibleDates[0];
            },
          ),
        ],
      ),
    );
  }
}
