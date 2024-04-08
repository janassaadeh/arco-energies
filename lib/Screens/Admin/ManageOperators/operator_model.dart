
class Operator{
    String id;
    String email; String phone; String name; String dob;String address;


  Operator({
    required this.id,
    required this.email,
    required this.phone,

    required this.name,
    required this.dob,
    required this.address,

  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
  
}