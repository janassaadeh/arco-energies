import 'dart:typed_data';

import 'package:company_pages/Models/reward_model.dart';
import 'package:company_pages/Provider/reward_provider.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/AddCompany.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company%20Details.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/AddOperator.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/Edit%20Operator.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/Operator%20Details.dart';
import 'package:company_pages/Screens/Admin/Rewards/add_reward.dart';
import 'package:company_pages/Screens/Admin/Rewards/edit_reward.dart';
import 'package:company_pages/Services/Manage%20Accounts/operator_manage_services.dart';
import 'package:company_pages/Services/image_service.dart';
import 'package:company_pages/Services/reward_services.dart';
import 'package:company_pages/Widgets/RewardCard2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../Services/Manage Accounts/Company_Services.dart';
import '../../../Widgets/CompanyCard.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

// import 'operator_model.dart';

class AllRewards extends StatefulWidget {
  final List<dynamic> rewards;
  const AllRewards({Key? key, required this.rewards}) : super(key: key);

  @override
  State<AllRewards> createState() => _MyOperatorsState();
}

class _MyOperatorsState extends State<AllRewards>
    with SingleTickerProviderStateMixin {
  late List<SlidableController> controllers;
  double ratio = 0.3;
  late List<TickerProvider> tickerProviders;
  String searchQuery = '';
  late List<dynamic> filteredOperators;

  @override
  void initState() {
    super.initState();
    tickerProviders = List.generate(
      widget.rewards.length,
      (index) => _TickerProvider(),
    );
    controllers = List.generate(
      widget.rewards.length,
      (index) => SlidableController(tickerProviders[index]),
    );
    filteredOperators = filterRewards(); // Filtered list of companies

    //  fetchImageForFilteredOperators();
  }

  // Method to filter companies based on search query
  List<dynamic> filterRewards() {
    return widget.rewards.where((op) {
      final name = op.name.toLowerCase();
      final description = op.description.toLowerCase();
      final catgeory = op.category.toLowerCase();
      final pts = op.pts.toString();
      final query = searchQuery.toLowerCase();
      return name.contains(query) ||
          description.contains(query) ||
          description.contains(query) ||
          description.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
         RewardProvider rewardProvider =
          Provider.of<RewardProvider>(context, listen: false);
      // rewardProvider.setRewardList(rewards);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                rewardProvider.setRewardList(filteredOperators);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Center(
            child: Text(
              'All Rewards',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color(0xff003D5B),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                  onTap: () async {
                    final newOperator = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddReward()),
                    );
                    if (newOperator != null) {
                      setState(() {
                        widget.rewards.add(newOperator);
                        filteredOperators.add(
                            newOperator); // Add the new company to the list
                        controllers.add(SlidableController(
                            _TickerProvider())); // Add a new SlidableController
                        tickerProviders
                            .add(_TickerProvider()); // Add a new TickerProvider
                      });
                    }
                  },
                  child: Icon(
                    Icons.add,
                    size: 37,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        backgroundColor: Color(0xff003D58),
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(height: 120, color: Color(0xff003D58)),
                  Container(
                    color: Colors.white,
                    height: 652,
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom +
                                50), // Adjust the padding as needed

                        itemCount: filteredOperators.length,
                        itemBuilder: (context, index) {
                          // filteredOperators
                          //     .sort((a, b) => b.date.compareTo(a.date));

                          return Column(
                            children: [
                              Slidable(
                                key: ValueKey(index),
                                controller: controllers[index],
                                endActionPane: ActionPane(
                                  extentRatio: ratio,
                                  motion: const ScrollMotion(),
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controllers[index]?.close();
                                        _showCupertinoLikeDialog(
                                            context, index, filteredOperators);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 18,
                                            left: 22,
                                            bottom: 18,
                                            right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          width: 88,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18, bottom: 12, right: 10),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    final newOperator = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditReward(
                                              reward:
                                                  filteredOperators[index])),
                                    );
                                    if (newOperator !=
                                        filteredOperators[index]) {
                                      setState(() {
                                        filteredOperators[index] = newOperator;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 0.0),
                                    child: RewardCard2(
                                      title: filteredOperators[index].name,
                                      subtitle1: filteredOperators[index]
                                          .pts
                                          .toString(),
                                      subtitle2:
                                          filteredOperators[index].category,
                                      // subtitle3: '#${cars[index].carId}',
                                      imageData: ('no image'),
                                      activated: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight:Radius.circular(25))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8, top: 12),
                    child: TextFormField(
                      // controller: searc,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          filteredOperators =
                              filterRewards(); // Update filteredOperators when searchQuery changes
                        });
                        // filterOperators();

                        // fetchImageForFilteredOperators();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Rewards ...",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.search, color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _showCupertinoLikeDialog(
      BuildContext context, int index, List<dynamic> filteredOperators) async {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Are you sure you want to delete this reward?'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF0169AA), fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                'Confirm',
                style: TextStyle(color: Color(0xFF0169AA)),
              ),
              onPressed: () async {
                try {
                  RewardService rewardService = RewardService();
                  // Call deleteOperator function to delete the operator
                  await rewardService.deleteReward(filteredOperators[index].id);

                  // Remove the operator from the list
                  final operatorId = filteredOperators[index].id;
                  final operatorIndex = widget.rewards
                      .indexWhere((operator) => operator.id == operatorId);
                  if (operatorIndex != -1) {
                    setState(() {
                      widget.rewards.removeAt(operatorIndex);
                      filteredOperators
                          .removeAt(index); // Remove from filtered list as well
                    });
                  }

                  Navigator.pop(context);

                  // Show a success Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reward deleted successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (error) {
                  // Show an error Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete reward: $error'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _TickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

void doNothing(BuildContext context) {}
