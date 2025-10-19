import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/pages/Auth/sign_in.dart';
import 'package:delivery_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  Supabase.initialize(
    url: dotenv.env['supabaseURL']!,
    anonKey: dotenv.env['supabaseAnnomKey']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  AuthCheck({super.key});
  final supabaae = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabaae.auth.onAuthStateChange,
      builder: (context, asyncsanpshot) {
        AppConfig.init(context);
        if (!asyncsanpshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final session = asyncsanpshot.data!.session;
        if (session != null) {
          return Home();
        } else {
          return SignIn();
        }
      },
    );
  }
}
