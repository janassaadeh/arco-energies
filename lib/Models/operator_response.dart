class OperatorResponse {
  final String id;
  final String email;
  final String phone;
  final String name;
  final String dob;
  final String address;

  final List<String> deviceTokens;

  OperatorResponse({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.dob,
    required this.address,
    required this.deviceTokens,
  });

  factory OperatorResponse.fromJson(Map<String, dynamic> json) {
    return OperatorResponse(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      dob: json['dob'],
      address: json['address'],
      deviceTokens: json['deviceTokens'] != null
          ? List<String>.from(json['deviceTokens'])
          : [],
    );
  }
}
