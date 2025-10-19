// class FoodModel {
//   String imageCard, imageDetail, name;
//   double price, rate;
//   String specialItems;
//    String category;
//   FoodModel({
//     required this.imageCard,
//     required this.imageDetail,
//     required this.name,
//     required this.price,
//     required this.rate,
//     required this.specialItems,
//     required this.category,
//   });
// }
// List<FoodModel> foodProduct = [
//   FoodModel(
//     imageCard: 'assets/food-delivery/product/beef_burger.png',
//     imageDetail: 'assets/food-delivery/product/beef_burger1.png',
//     name: 'Beef Burger',
//     price: 7.59,
//     rate: 4.5,
//     specialItems: 'Cheesy Mozarella 🧀',
//     category: 'Burger'
//   ),
//   FoodModel(
//     imageCard: 'assets/food-delivery/product/double_burger.png',
//     imageDetail: 'assets/food-delivery/product/double_burger1.png',
//     name: 'Double Burger',
//     price: 10.0,
//     rate: 4.9,
//     specialItems: 'Double Beef 🍖',
//     category: 'Burger'
//   ),
//   FoodModel(
//     imageCard: 'assets/food-delivery/product/cheese-burger.png',
//     imageDetail: 'assets/food-delivery/product/cheese-burger1.png',
//     name: 'Cheese Burger',
//     price: 8.88,
//     rate: 4.8,
//     specialItems: 'Extra Cheese 🧀',
//     category: 'Burger',
//   ),
//   FoodModel(
//     imageCard: 'assets/food-delivery/product/bacon_burger.png',
//     imageDetail: 'assets/food-delivery/product/bacon_burger1.png',
//     name: 'Bacon Burger',
//     price: 9.99,
//     rate: 5.0,
//     specialItems: 'Mix Beef 🥩',
//     category: 'Burger'
//   ),
//   FoodModel(
//     imageCard: 'assets/food-delivery/product/pizza111.png',
//     imageDetail: 'assets/food-delivery/product/pizza.png',
//     name: 'Chicken Pizza',
//     price: 19.99,
//     rate: 4.0,
//     specialItems: 'Cheese Pizza 🍕',
//     category: 'Pizza'
//   ),
//    FoodModel(
//     imageCard: 'assets/food-delivery/product/cup_cake.png',
//     imageDetail: 'assets/food-delivery/product/cup-cake1.png',
//     name: 'Cream Cake',
//     price: 5.99,
//     rate: 4.7,
//     specialItems: 'Mix Cream 🧁',
//     category: 'Cup Cake',
//   ),
// ];
// i have a csv file of this saample data, i will upload this csv file in my supabase project,


var desc =
    "This is a special types of tiems, often served with cheese, lettuce, tomato, onion, pickles, bacon, or chilis; condiments such as ketchup, mustard, mayonnaise, relish, or a 'specialItems sauce', often a variation of Thousand Island dressing; and are frequently placed on sesame seed buns.";

// this is the model
// first let's upload the csv file in supabase.
// if you have required this sample data then join your discord server i will attach all the sampel file there,
class FoodModel {
  final String imageCard;
  final String id; // Add this
  final String imageDetail;
  final String name;
  final double price;
  final double rate;
  final String specialItems;
  final String category;
  final int kcal;
  final String time;

  FoodModel({
    required this.imageCard,
    required this.imageDetail,
    required this.name,
    required this.price,
    required this.rate,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
    required this.id,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? "",
      imageCard: json['imageCard'] ?? "",
      imageDetail: json['imageDetail'] ?? "",
      name: json['name'] ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      specialItems: json['specialItems'] ?? '',
      category: json['category'] ?? '',
      kcal: json['kcal'] ?? '',
      time: json['time']??''
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageCard': imageCard,
      'imageDetail': imageDetail,
      'name': name,
      'price': price,
      'rate': rate,
      'specialItems': specialItems,
      'category': category,
      'kcal': kcal,
      'time': time,
    };
  }
}
