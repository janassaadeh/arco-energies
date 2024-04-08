class Vehicle {
  final String id;
  final int year;
  final String model;
  final String plateNumber;
  final String driverName;
  final String type;
  final String color;
  final List<dynamic> transactions;

  Vehicle({
    required this.id,
    required this.year,
    required this.model,
    required this.plateNumber,
    required this.driverName,
    required this.type,
    required this.color,
    required this.transactions,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      year: json['year'],
      model: json['model'],
      plateNumber: json['plateNumber'],
      driverName: json['driverName'],
      type: json['type'],
      color: json['color'],
      transactions: json['transactions'],
    );
  }
}
