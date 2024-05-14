class Reward {
  final String id;
  final String name;
  final int pts;
  final String description;
  final String category;

  Reward({
    required this.id,
    required this.name,
    required this.pts,
    required this.description,
    required this.category,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      name: json['name'],
      pts: json['pts'],
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pts': pts,
      'description': description,
      'category': category,
    };
  }
}
