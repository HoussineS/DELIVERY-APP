import 'package:delivery_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartProvider = ChangeNotifierProvider((ref) => null);

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  final _supabase = Supabase.instance.client;
  CartProvider() {
    loadData();
  }
  // getters
  List<CartItem> get cartItems => _cartItems;
  bool isOnCart(String id) {
    final index = _cartItems.indexWhere((element) => element.productId == id);

    return index != -1;
  }

  // user id
  String? get getUserId => _supabase.auth.currentUser?.id;
  //rest state
  void rest() {
    _cartItems = [];
    notifyListeners();
  }

  //load cart
  Future<void> loadData() async {
    if (getUserId == null) return;
    try {
      final response = await _supabase
          .from("cart")
          .select()
          .eq("user_id", getUserId!);

      if (response.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        response.forEach((item) => _cartItems.add(CartItem.fromMap(item)));
      }
    } catch (e) {
      throw ("Error on Loading Data ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  //Remove from cart
  Future<void> remove(String cartId) async {
    try {
      await _supabase.from("cart").delete().eq("id", cartId);
      _cartItems.removeWhere((item) => item.id == cartId);
    } catch (e) {
      debugPrint(e.toString());
      throw ("Error on remove item");
    }
  }

  //add to cart
  Future<void> addToCart(
    String productId,
    Map<String, dynamic> productData,
  ) async {
    try {
      final response = await _supabase
          .from("cart")
          .insert({
            "user_id": getUserId!,
            "product_id": productId,
            "quantity": 1,
            "product_data": productData,
          })
          .select()
          .single();
      _cartItems.add(CartItem.fromMap(response));
    } catch (e) {
      throw ("Error on add item");
    } finally {
      notifyListeners();
    }
  }

  // increace and decreace quantity
  Future<void> increace(String cartId) async {
    try {
      final index = _cartItems.indexWhere((element) => element.id == cartId);
      await _supabase
          .from("cart")
          .update({'quantity': ++_cartItems[index].quantity})
          .eq("id", cartId);
      // whene use ++ before it update the current value and sent it to supabase wooo
    } catch (e) {
      throw ("Error on increace quantity");
    } finally {
      notifyListeners();
    }
  }

  Future<void> decreace(String cartId) async {
    try {
      final index = _cartItems.indexWhere((element) => element.id == cartId);
      if (_cartItems[index].quantity == 1) return;
      await _supabase
          .from("cart")
          .update({'quantity': --_cartItems[index].quantity})
          .eq("id", cartId);
      // whene use ++ before it update the current value and sent it to supabase wooo
    } catch (e) {
      throw ("Error on decreace quantity");
    } finally {
      notifyListeners();
    }
  }
}
