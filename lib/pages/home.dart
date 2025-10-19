import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What to you won't to ate"),
        backgroundColor: Colors.white54,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: Supabase.instance.client.auth.signOut,
          child: Text("Logout"),
        ),
      ),
    );
  }
}
