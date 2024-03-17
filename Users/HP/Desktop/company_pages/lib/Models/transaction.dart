class Transaction {
  final String id;
  final double quantity;
  final double odometer;
  final String date;

  Transaction({
    required this.id,
    required this.quantity,
    required this.odometer,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      quantity: json['quantity'],
      odometer: json['odometer'],
      date: json['date'],
    );
  }
}
