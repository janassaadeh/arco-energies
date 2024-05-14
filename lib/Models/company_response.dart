class CompanyResponse {
  final String id;
  final String email;
  final String phone;
  final String name;
  final double balance;
  final String contactName;
  final String location;

  CompanyResponse({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.balance,
    required this.contactName,
    required this.location,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      balance: json['balance'],
      contactName: json['contactName'],
      location: json['location'],
    );
  }
  
}
