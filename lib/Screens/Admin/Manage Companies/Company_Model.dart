
class Company {
  String id;
  String name;
  String contactName;
  String location;
  String email;
  String phone;
  double balance;

  Company({
    required this.id,
    required this.name,
    required this.contactName,
    required this.location,
    required this.email,
    required this.phone,
    required this.balance,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      contactName: json['contactName'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      balance: json['balance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contactName'] = this.contactName;
    data['location'] = this.location;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    return data;
  }
  
}