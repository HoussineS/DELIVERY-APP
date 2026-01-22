// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final favoritesRefreshNotifier = ValueNotifier<int>(0);

final favotiteProvider = ChangeNotifierProvider<FavoriteProvider>(
  (ref) => FavoriteProvider(),
);

class FavoriteProvider extends ChangeNotifier {
  List<String> _favId = [];
  final _supabaseClient = Supabase.instance.client;
  //getters
  List<String> get getFav => _favId;
  String? get getUserId => _supabaseClient.auth.currentUser?.id;
  FavoriteProvider() {
    //load the favorite
    loadData();
  }
  void rest() {
    _favId = [];
    notifyListeners();
  }

  bool isFav(String productId) {
    return _favId.contains(productId);
  }

  Future<void> toogleFav(String productId) async {
    print('toogle ok  $productId');
    if (_favId.isNotEmpty && _favId.contains(productId)) {
      //server side
      print('remove from fav');
      await removeFromfav(productId);

      _favId.remove(productId);
    } else {
      await addTofav(productId);
      print('add to fav');
      _favId.add(productId);
    }
    notifyListeners();
  }

  Future<void> addTofav(String productId) async {
    if (getUserId == null) return;
    try {
      print('add to fav');
      await _supabaseClient.from("favorites").insert({
        "userId": getUserId,
        "productId": productId,
      });
      print('added to fav successfully');
    } catch (e) {
      print(e.toString());
      throw ("Error on add favorite");
    }
  }

  Future<void> removeFromfav(String productId) async {
    if (getUserId == null) return;
    try {
      await _supabaseClient.from("favorites").delete().match({
        "userId": getUserId!,
        "productId": productId,
      });
      print('removed from fav');
    } catch (e) {
      print(e.toString());
      throw ("Error on remove favorite");
    }
  }

  Future<void> loadData() async {
    if (getUserId == null) return;
    try {
      final data = await _supabaseClient
          .from("favorites")
          .select("productId")
          .eq("userId", getUserId!);
      _favId = data.map((row) => row['productId'] as String).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw ("Error on load favorites");
    }
  }
}
