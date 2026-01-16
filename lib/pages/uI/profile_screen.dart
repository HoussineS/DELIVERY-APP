import 'package:delivery_app/pages/Auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Supabase.instance.client.auth.signOut();
          Navigator.of(context).push(
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
