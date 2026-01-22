import 'package:delivery_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final categorieProvider = ChangeNotifierProvider<CategorieProvider>(
  (ref) => CategorieProvider(),
);

class CategorieProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<FoodModel> product = [];
  List<FoodModel> filtredProduct = [];
  bool isLoading = false;
  CategorieProvider() {
    loadProduct();
  }
  Future<void> loadProduct() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await supabase.from("menu_items").select();
      product = response.map((data) => FoodModel.fromJson(data)).toList();
      product.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      filtredProduct = product;
    } catch (e) {
      debugPrint(e.toString());
      throw ("Error on loading data");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategorie(String categorie) {
    if (categorie == "") return;

    if (categorie == 'ALL') {
      filtredProduct = product;
      notifyListeners();
      return;
    }
    filtredProduct = product
        .where((product) => product.category == categorie)
        .toList();
    notifyListeners();
  }
}
