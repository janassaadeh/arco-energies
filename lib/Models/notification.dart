import 'package:intl/intl.dart';

class Notification {
  String id;
  String type;
  double price;
  DateTime createdDate;

  Notification(this.id, this.type, this.price, this.createdDate);

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      json['id'] as String,
      json['type'] as String,
      json['price'] as double,
      DateTime.parse(json['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'type': type,
      'price': price,
      'createdDate': formatter.format(createdDate),
    };
  }
}
