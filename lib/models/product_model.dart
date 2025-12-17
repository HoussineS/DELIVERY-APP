class FoodModel {
  final String id;
  final String imageCard;
  final String imageDetail;
  final String name;
  final double price;
  final double rate;
  final String specialItems;
  final String category;
  final int kcal;
  final String time;
  final String description;

  FoodModel({
    required this.id,
    required this.imageCard,
    required this.imageDetail,
    required this.name,
    required this.price,
    required this.rate,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
    required this.description,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']?.toString() ?? '',
      imageCard: json['imagecard'] ?? '',
      imageDetail: json['imagedetail'] ?? '',
      name: json['name'] ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      specialItems: json['specialitems'] ?? '',
      category: json['category'] ?? '',
      kcal: (json['kcal'] as num?)?.toInt() ?? 0,
      time: json['time'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagecard': imageCard,
      'imagedetail': imageDetail,
      'name': name,
      'price': price,
      'rate': rate,
      'specialitems': specialItems,
      'category': category,
      'kcal': kcal,
      'time': time,
    };
  }
}
