import 'package:company_pages/Models/operator_response.dart';

class Notification {
  String id;
  String type;
  double price;
  String createdDate;
  OperatorResponse operator;

  Notification(this.id, this.type, this.price, this.createdDate, this.operator);

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      json['id'] as String,
      json['type'] as String,
      json['price'] as double,
      json['createdDate'] as String,
      OperatorResponse.fromJson(json['operator']),
    );
  }

  Map<String, dynamic> toJson() {
    // final formatter = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'type': type,
      'price': price,
      'createdDate': createdDate,
    };
  }
}

class NotificationBody {
  String type;
  double price;
  String createdDate;

  NotificationBody(
    this.type,
    this.price,
    this.createdDate,
  );

  factory NotificationBody.fromJson(Map<String, dynamic> json) {
    return NotificationBody(
      json['type'] as String,
      json['price'] as double,
      json['createdDate'] as String,
    );
  }
}
