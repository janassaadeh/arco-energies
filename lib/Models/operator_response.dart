class OperatorResponse {
  final String id;
  final String email;
  final String phone;
  final String name;
  final String dob;
  final String address;

  OperatorResponse({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.dob,
    required this.address,
  });

  factory OperatorResponse.fromJson(Map<String, dynamic> json) {
    return OperatorResponse(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      dob: json['dob'],
      address: json['address'],
    );
  }
  
}
