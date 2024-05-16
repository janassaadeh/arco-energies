import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Services/Auth/user_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Rewards/reward.dart';

class RewardScreen extends StatefulWidget {
  dynamic company;
  List<Reward> rewards;

  RewardScreen({required this.company, required this.rewards, super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    _fetchCompanyData();
  }

  Future<void> _fetchCompanyData() async {
    UserService userService = UserService();
    final fetchedCompany = await userService.fetchUserData();
    setState(() {
      widget.company = fetchedCompany;
    });
  }

  Future<void> _refreshData(BuildContext context) async {
    await _fetchCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                width: 403.64825439453125,
                height: 152,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(132, 177, 203, 0.30000001192092896),
                      offset: Offset(0, 3),
                      blurRadius: 10,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment(-1.5, 1),
                    end: Alignment(1.5, 1),
                    colors: [
                      Color.fromRGBO(0, 61, 91, 1),
                      Color.fromRGBO(2, 91, 134, 0.8999999761581421)
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.company != null
                                    ? widget.company.pts.toString()
                                    : '0',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 32,
                                  letterSpacing: -0.3199999928474426,
                                  fontWeight: FontWeight.bold,
                                  height: 0.75,
                                ),
                              ),
                              const Text(
                                ' pts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 32,
                                  letterSpacing: -0.3199999928474426,
                                  fontWeight: FontWeight.w400,
                                  height: 0.75,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Image.asset("assets/images/s1.png"),
                            ],
                          ),
                          const SizedBox(height: 37),
                          const Text(
                            '* Filling up 1 liter earns you 1 point.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 0.75,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rewards",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffA9A7A7),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: widget.rewards.length * 110.0,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 50),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.rewards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        RewardService rewardService = RewardService();
                        var imageData = await rewardService.getQrCode(
                            widget.company.id, widget.rewards[index].id);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                Container(
                                  height: 600,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        Container(
                                          width: 76,
                                          child: const Divider(
                                              thickness: 4,
                                              color: Color(0xffDEDEDE)),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            'Redeem Reward',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const Divider(
                                            thickness: 1,
                                            color: Color(0xffDEDEDE)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                "assets/images/s1.png",
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Text(
                                          widget.rewards[index].name,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          width: 320,
                                          child: const Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Visit our gas station and have one of our staff members scan your QR code to claim your reward.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          width: 350,
                                          height: 280,
                                          child: Column(
                                            children: [
                                              Image.memory(imageData,
                                                  fit: BoxFit.fill),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: RewardCard(
                          title: widget.rewards[index].name,
                          description: widget.rewards[index].description,
                          pointsText: widget.rewards[index].pts,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: const Color(0xffA9A7A7).withOpacity(0.5),
                height: 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
