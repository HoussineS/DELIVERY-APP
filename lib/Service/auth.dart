import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supabase = Supabase.instance.client;
  Future<String?> signUp(String password, String email) async {
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: email,
      );
      if (response.user != null) {
        return null;
      }
      return "An unknow error accorded";
    } on AuthApiException catch (e) {
      return e.message;
    } catch (e) {
      return "Error ${e.toString()}";
    }
  }

  Future<String?> login(String password, String email) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user != null) {
        return null;
      }
      return "Email or Password incorrect";
    } on AuthApiException catch (e) {
      return e.message;
    } catch (e) {
      return "Error ${e.toString()}";
    }
  }
}
