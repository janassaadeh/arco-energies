
import 'package:company_pages/Widgets/cars/CustomCarSearch.dart';
import 'package:flutter/material.dart';

import '../../Widgets/cars/CarCard.dart';


class MyCars extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Center(
          child:  Text('All Cars',style: TextStyle(
                  color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                ),),
        ),
        backgroundColor: const Color(0xff003D5B),
        actions: [const Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Icon(Icons.notifications,size:37,color: Colors.white,),
        )],
      ),
      backgroundColor: Color(0xff003D58),
      body: 
          SingleChildScrollView(
           
            child: Stack(clipBehavior: Clip.none,
              children: [
                
                
          
                Column(
                  children: [
                    Container(
                      height: 120,
                      color:Color(0xff003D58)),
                    Container(
                        color: Colors.white,
                        height: 652,
                      
                      child: Column(
                        children: [
                      
                          CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                                         CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                                           CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                                         CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                                           CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                                         CarCard(  title: 'Hallab',
                                    subtitle1: 'Mercedes-Benz',
                                    subtitle2: 'A- Class 2022',
                                    subtitle3: '#1223246',),
                        ],
                      ),
                    ),
                  ],
                ),
                    Padding(
                      padding: const EdgeInsets.only(top:100.0),
                      child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                            ),),
                    ),
                        Padding(
                          padding: const EdgeInsets.only(top:15,left:15.0,right:15),
                          child: CustomCarSearch(),
                        ),
              ],
            ),
          )
    );
  }
}
