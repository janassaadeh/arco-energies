import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines/timelines.dart';
import 'package:company_pages/Widgets/timeline_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Timeline Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HorizontalTimelinePage(),
    );
  }
}
class HorizontalTimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Timeline Example'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 100, // Set the width here
            child: MyTimeLineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              isCurrent: false,
              isNotReached: false,

            ),
          ),
          SizedBox(
            width: 100, // Set the width here
            child: MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: false,
              isCurrent: true,
              isNotReached: false,

            ),
          ),
          SizedBox(
            width: 100, // Set the width here
            child: MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: false,
              isCurrent: false,
              isNotReached: true,

            ),
          ),
          SizedBox(
            width: 100, // Set the width here
            child: MyTimeLineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              isCurrent: false,
              isNotReached: true,

            ),
          ),
        ],
      ),
    );
  }
}
