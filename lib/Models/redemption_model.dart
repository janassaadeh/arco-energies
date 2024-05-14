
import 'package:company_pages/Models/company_response.dart';
import 'package:company_pages/Models/operator_response.dart';
import 'package:company_pages/Models/reward_model.dart';

class RedemptionEvent {
  String id;
  CompanyResponse company;
  OperatorResponse operator;
  Reward reward;
  int pts;
  DateTime date;

  RedemptionEvent({
    required this.id,
    required this.company,
    required this.operator,
    required this.reward,
    required this.pts,
    required this.date,
  });

  factory RedemptionEvent.fromJson(Map<String, dynamic> json) {
    return RedemptionEvent(
      id: json['id'] ,
      company: CompanyResponse.fromJson(json['company']),
      operator: OperatorResponse.fromJson(json['operator']),
      reward: Reward.fromJson(json['reward']),
      pts: json['pts'],
      date: DateTime.parse(json['timestamp']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': id,
  //     'company': company.toJson(),
  //     'operator': operator.toJson(),
  //     'reward': reward.toJson(),
  //     'pts': pts,
  //     'timestamp': timestamp.toIso8601String(),
  //   };
  // }
}
