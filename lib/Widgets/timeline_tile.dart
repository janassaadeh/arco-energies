import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isCurrent;
  final bool isNotReached;

  const MyTimeLineTile({
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.isCurrent,
    required this.isNotReached,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set the width of the timeline tile
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color:isCurrent?Colors.white: isNotReached?Color(0xff939393): Color.fromRGBO(114, 212, 171, 1)),
        indicatorStyle: IndicatorStyle(
          // width: 100, 
          height: 30,// Adjust this value to make the indicator larger
          color:isCurrent?Colors.white: isNotReached?Color(0xff939393):  Color.fromRGBO(114, 212, 171, 1),
          iconStyle: IconStyle(
            iconData: Icons.done,
            color:isCurrent||isNotReached?Colors.transparent: Colors.white,
            fontSize: 25
          ),
          drawGap: true
        ),
      ),
    );
  }
}
