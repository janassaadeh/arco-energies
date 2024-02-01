import 'package:company_pages/Home/Cash.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:50.0),
            child: Row(
              children: [
                Image.asset("assets/images/logoWhite.png"),
                Text('rco Energies',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xff003D5B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Cash(),
            Container(
        width: 152.94500732421875,
        height: 135,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
      gradient : LinearGradient(
          begin: Alignment(-1.1779649257659912,-1.3327655792236328),
          end: Alignment(1.3327656984329224,-1.139451026916504),
          colors: [Color.fromRGBO(209, 73, 91, 1),Color.fromRGBO(209, 73, 91, 0.5699999928474426)]
        ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Earn and Redeem Points",style: TextStyle(
          color: Colors.white
        ),),
        Row(
          children: [
            Image.asset("assets/images/Star.png")
          ],
        )
      ],
    ),
  ),
      )
          ],
        ),
      ),
    );
  }
}
