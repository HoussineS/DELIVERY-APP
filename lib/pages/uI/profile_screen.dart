import 'package:delivery_app/core/Provider/cart_provider.dart';
import 'package:delivery_app/core/Provider/favorite_provider.dart';
import 'package:delivery_app/pages/Auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await Supabase.instance.client.auth.signOut();
          ref.read(favotiteProvider).rest();
          ref.read(cartProvider).rest();

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
              pageBuilder: (context, animation, secondaryAnimation) {
                return SignIn();
              },
            ),
          );
        },
        child: Center(
          child: Container(
            height: 50,
            width: 100,
            color: Colors.blueAccent,
            child: Text("Sign Out", textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
