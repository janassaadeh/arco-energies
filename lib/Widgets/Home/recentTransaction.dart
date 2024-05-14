import 'package:flutter/material.dart';


class Transactions extends StatelessWidget {
  final String id;
  final double price;
  final String type;
  final int day;
  final String? company;


   Transactions({super.key, required this.id, required this.price,required this.type,required this.day, this.company});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration:  BoxDecoration(
                              color: type=="-"?Colors.red: type=="/"?Colors.amber: const Color(0xff9DC284),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text("#$id", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(day==0?"Today":day==1?"1-day ago":"$day-days ago", style: const TextStyle(fontSize: 16, color: Color(0xff9E9C9C))),
                    ),
                  ],
                ),
              ],
            ),
            (type=='/')?Text("${company}", style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)):Text("$type \$ ${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, color: type=="-"?Colors.red:const Color(0xff9DC284), fontWeight: FontWeight.bold)),
          ],
        ),
            const SizedBox(height: 30,)
      ],
    );
  }
}
