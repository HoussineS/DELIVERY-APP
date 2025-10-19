// class Category {
//   String image, name;

//   Category({required this.image, required this.name});
// }

// List<Category> myCategories = [
//   Category(
//     image: 'assets/food-delivery/burger.png',
//     name: 'Burger',
//   ),
//   Category(
//     image: 'assets/food-delivery/pizza.png',
//     name: 'Pizza',
//   ),
//   Category(
//     image: 'assets/food-delivery/cup cake.png',
//     name: 'Cup Cake',
//   ),
// ];
//
// this is our category model where we have fetch data from supabse
class CategoryModel {
  String image, name;

  CategoryModel({required this.image, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(image: json['image'] ?? "", 
    name: json['name'] ?? "");
  }
}
// you can just add this name and image url manually but i have collected this and save it in my csv file
// that's why i am directly upload it.

// we will make this bucket private later
// let's start to fetch this category items,