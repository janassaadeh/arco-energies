import 'package:flutter/material.dart';


class Cash extends StatelessWidget {
  final String cashBalance;


  const Cash({super.key,required this.cashBalance});

          @override
          Widget build(BuildContext context) {
          // Figma Flutter Generator Group2Widget - GROUP
            return Container(
            width: 403.64825439453125,
            height: 132,
            decoration: const BoxDecoration(
            borderRadius : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            ),
            boxShadow : [BoxShadow(
            color: Color.fromRGBO(132, 177, 203, 0.30000001192092896),
            offset: Offset(0,3),
            blurRadius: 10
            )],
            gradient : LinearGradient(
            begin: Alignment(-1.5,1),
            end: Alignment(1.5,1),
            colors: [Color.fromRGBO(0, 61, 91, 1),Color.fromRGBO(2, 91, 134, 0.8999999761581421)]
            ),
  ),child:  Padding(
    padding: const EdgeInsets.all(30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Total', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  letterSpacing: -0.3199999928474426,
                  fontWeight: FontWeight.normal,
                  height: 0.75
                ),),       
                SizedBox(height: 25,),
            Text('\$ ${cashBalance}', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Inter',
                  fontSize: 27,
                  letterSpacing: -0.3199999928474426,
                  fontWeight: FontWeight.bold,
                  height: 0.75
                ),),
          ],
        ),
        
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Image.asset("assets/images/Cash1.png",width: 100,height: 100,),
        )
      ],
    ),
  ),
            );
          }
        }
        