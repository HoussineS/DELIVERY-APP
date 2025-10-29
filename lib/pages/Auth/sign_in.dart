import 'package:delivery_app/Service/auth.dart';
import 'package:delivery_app/core/app_confic.dart';
import 'package:delivery_app/core/widget/my_button.dart';
import 'package:delivery_app/pages/Auth/sign_up.dart';
import 'package:delivery_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final _authService = Auth();
  final _fromKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isPasswordHidden = true;
  Future<void> _login() async {
    bool isValidate = _fromKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _fromKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    String? respone = await _authService.login(password!, email!);
    setState(() {
      isLoading = false;
    });
    if (respone != null) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, respone, Colors.redAccent);
      return;
    }
    // ignore: use_build_context_synchronously
    showSnackBar(context, "Succesfuly login", Colors.lightGreen);
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
                "assets/sign_in.jpg",
                fit: BoxFit.cover,
                height: AppConfig.screenHeight * 0.5,
              ),
              SizedBox(height: 10),
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
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
                          borderRadius: BorderRadius.circular(10),
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
                              onTap: _login,
                              buttonText: 'Sign IN',
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
                            "SIGN UP HERE",
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
