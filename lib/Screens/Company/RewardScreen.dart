

import 'package:company_pages/Services/reward_services.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Rewards/reward.dart';

class Reward {
  final String title;
  final int points;
  final String id;
  final String description;


  Reward({required this.title, required this.points,required this.id,required this.description});
    factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      title: json['name'],
      points: json['pts'],
      id:json['id'],
      description:json['description']
    );
  }
}

class RewardScreen extends StatelessWidget {
  dynamic company;
  List <Reward> rewards;
   RewardScreen({required this.company,required this.rewards,super.key});



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
          padding: const EdgeInsets.all(25.0),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
 
              Row(
                children: [
                   Text(company.pts.toString(), textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: 32,
                        letterSpacing: -0.3199999928474426,
                        fontWeight: FontWeight.bold,
                        height: 0.75
                      ),),
                  const Text(' pts', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: 32,
                        letterSpacing: -0.3199999928474426,
                        fontWeight: FontWeight.w400,
                        height: 0.75
                      ),),
                      const SizedBox(width: 12,),
                  Image.asset("assets/images/s1.png")
                        
                ],
              ),
              const SizedBox(height: 37,),
                             const Text('* Filling up 1 liter earns you 1 point.', textAlign: TextAlign.center, style: TextStyle(
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
              
              SizedBox(
                height:rewards.length*110.0,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
      itemCount: rewards.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async{
            RewardService rewardService=RewardService();
            var imageData=await rewardService.getQrCode(company.id, rewards[index].id);
            showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return Container(
      height: 620, // Adjust height as needed
      width: double.infinity,
      decoration: BoxDecoration(
      color: Colors.white,

        borderRadius: BorderRadius.circular(25)
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
              width: 76,
              child: Divider(thickness: 4,color:Color(0xffDEDEDE))),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Redeem Reward',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              ),
                  Divider(thickness: 1,color:Color(0xffDEDEDE)),
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/images/s1.png",fit:BoxFit.fill)),
      
                Text(rewards[index].title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
      SizedBox(height: 5,),
                Container(
                  width: 320,
                  child: Center(
                    child: Text(textAlign: TextAlign.center,'Visit our gas station and have one of our staff members scan your QR code to claim your reward.'
                    ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                  ),
                ),
            Container(
         
              
              child: 
              
              Column(children: [
              Image.memory(imageData),
              // Text(textAlign: TextAlign.center,'${rewards[index].id}'
              //       ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                
              ],)
              ),
            

      
          ],
        ),
      )
    );
  },
);

          },
          child: RewardCard(title: rewards[index].title, description: rewards[index].description, pointsText: rewards[index].points));}),
              ),
                 SizedBox(height: 20,),
                    Divider(
                  color: const Color(0xffA9A7A7).withOpacity(0.5),height: 0.3,)
            ],
          )
        ),
      
    );
  }
}
