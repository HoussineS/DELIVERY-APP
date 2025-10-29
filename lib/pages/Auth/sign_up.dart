// ignore_for_file: use_build_context_synchronously

import 'package:delivery_app/Service/auth.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/widget/my_button.dart';
import 'package:delivery_app/pages/Auth/sign_in.dart';
import 'package:delivery_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _authService = Auth();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  bool isPasswordHidden = true;
  Future<void> _signUP() async {
    bool isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    String? response = await _authService.signUp(password!, email!);
    setState(() {
      isLoading = false;
    });
    if (response != null) {
      showSnackBar(context, response, Colors.redAccent);
      return;
    }

    showSnackBar(context, "Sing Up Succesfuly,Now login", Colors.lightGreen);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/login.jpg",
                fit: BoxFit.cover,
                height: AppConfig.screenHeight * 0.5,
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Colors.blue,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (newEmail) {
                        email = newEmail;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: isPasswordHidden
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = false;
                                  });
                                },
                                icon: Icon(Icons.visibility),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = true;
                                  });
                                },
                                icon: Icon(Icons.visibility_off),
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: isPasswordHidden,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (newPassword) {
                        password = newPassword;
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : MyButton(
                              onTap: _signUP,
                              buttonText: 'Sign UP',
                              buttomColor: Colors.blueAccent,
                            ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alreday have a account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 9),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => SignIn()),
                            );
                          },
                          child: Text(
                            "SGIN IN HERE",
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
      ),
    );
  }
}
