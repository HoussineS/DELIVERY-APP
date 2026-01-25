import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/pages/Auth/sign_in.dart';
import 'package:delivery_app/pages/uI/onbonrding_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['supabaseURL']!,
    anonKey: dotenv.env['supabaseAnnomKey']!,
  );
  runApp(ProviderScope(child: const MyApp()));
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
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);

    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.hasData
            ? snapshot.data!.session
            : supabase.auth.currentSession;
        if (session == null) {
          return const SignIn();
        } else {
          return const OnbonrdingUi();
        }
      },
    );
  }
}
