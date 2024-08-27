import 'package:farmereats/login/social_login.dart';
import 'package:farmereats/signup/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../network/api_client.dart';
import '../network/api_service.dart';
import '../signup/farm_info.dart';
import '../signup/success.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService(ApiClient('https://sowlab.com/assignment')); // Replace with your base URL
  final SocialLogin _socialLogin = SocialLogin();

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // Assuming your login API endpoint is '/user/login'
      final response = await _apiService.loginUser(email, password);

      if (response) {
        // Handle successful login (e.g., navigate to another page)
        //Navigator.pushReplacementNamed(context, '/home');
        _navigateToNextScreen();// Update with your route
      } else {
        // Handle failed login
        Fluttertoast.showToast(msg: "Login failed. Please try again.");
      }
    } else {
      // Handle empty fields
      Fluttertoast.showToast(msg: "Please enter both email and password.");

    }
    // After saving data, navigate to the next screen

  }

  void _navigateToNextScreen() {
    if (!mounted) return; // Ensure the widget is still mounted before calling `Navigator`

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()), // Replace with your next screen
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'farmereats',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Welcome back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black),
              ),

              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: 'New here? ', // Regular text
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Create account', // Clickable text
                      style:  TextStyle(color: MyColors.customRed, fontSize: 14), // Red color
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Form(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/email.png',
                        ),
                        hintText: 'Email Address',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/pwd_icon.png',
                        ),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // Handle the tap event for "forgot?"
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                            child: Text(
                              'Forgot?',
                              style: TextStyle(
                                color: MyColors.customRed, // Adjust the color as needed
                                fontSize: 14, // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.customRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 20),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'or signup with',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      child: IconButton(
                        onPressed: () async {
                          bool success = await _socialLogin.signInWithGoogle();
                          if (success) {
                            // Navigate to the success page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SuccessPage()),
                            );
                          } else {
                            // Optionally handle sign-in failure
                            Fluttertoast.showToast(msg: "Sign in failed. Please try again.");
                          }
                        },
                        icon: Image.asset('assets/google_icon.png'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/fb_icon.png'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/apple_icon.png'),
                      ),
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
