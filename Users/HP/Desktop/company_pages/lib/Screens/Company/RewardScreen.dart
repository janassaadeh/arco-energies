import 'package:flutter/material.dart';

import '../../Widgets/Rewards/reward.dart';

class Reward {
  final String title;
  final int points;

  Reward({required this.title, required this.points});
}

class RewardScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return 
      
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
              width: 403.64825439453125,
              height: 152,
              decoration: BoxDecoration(
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
          padding: const EdgeInsets.all(25.0),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
 
              Row(
                children: [
                  Text('0', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: 32,
                        letterSpacing: -0.3199999928474426,
                        fontWeight: FontWeight.bold,
                        height: 0.75
                      ),),
                  Text(' pts', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: 32,
                        letterSpacing: -0.3199999928474426,
                        fontWeight: FontWeight.w400,
                        height: 0.75
                      ),),
                      SizedBox(width: 12,),
                  Image.asset("assets/images/s1.png")
                        
                ],
              ),
              SizedBox(height: 37,),
                             Text('* Filling up 1 liter earns you 1 point.', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 0.75
                  ),),    
            ],
          ),
          
        ],
          ),
          
        ),
              ),
                            const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Rewards",style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffA9A7A7),
                ),),
              ),
              const SizedBox(height: 20,),
              
              Container(
                height:800,
                child: ListView(
                  children: [
                    RewardCard(title: "Shine On Us Reward",description: "Indulge in free or discounted car washes as our token of gratitude.", pointsText: 50,),
                    RewardCard(title: "Shine On Us Reward",description: "Indulge in free or discounted car washes as our token of gratitude.", pointsText: 50,),
                    RewardCard(title: "Shine On Us Reward",description: "Indulge in free or discounted car washes as our token of gratitude.", pointsText: 50,),
                    RewardCard(title: "Shine On Us Reward",description: "Indulge in free or discounted car washes as our token of gratitude.", pointsText: 50,),
                   SizedBox(height: 20,),
                    Divider(
                  color: Color(0xffA9A7A7).withOpacity(0.5),height: 0.3,)
              
                  ],
                ),
              ),
            ],
          )
        ),
      
    );
  }
}
