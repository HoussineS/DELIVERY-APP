import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/widget/my_button.dart';
import 'package:delivery_app/pages/Auth/sign_up.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(
              "assets/sign_in.jpg",
              fit: BoxFit.cover,
              height: AppConfig.screenHeight * 0.5,
            ),
            SizedBox(height: 10),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',

                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite,
                    child: MyButton(
                      onTap: () {},
                      buttonText: 'Sign UP',
                      buttomColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have a account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 9),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignUp()),
                          );
                        },
                        child: Text(
                          "SGIN UP HERE",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
