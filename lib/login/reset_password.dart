import 'package:farmereats/login/login.dart';
import 'package:farmereats/login/verify_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../network/api_client.dart';
import '../network/api_service.dart';
import '../values/shared_pref.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ApiService _apiService = ApiService(ApiClient('https://sowlab.com/assignment'));


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'farmereats',
            style: TextStyle(color: Colors.black),
          ),
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
                'Reset Password?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black),
              ),

              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: 'Remember your password? ', // Regular text
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Login', // Clickable text
                      style:  TextStyle(color: MyColors.customRed, fontSize: 14), // Red color
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap event for "create account"
                          print('Create Account tapped!');
                          // Navigate or perform any other action here
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
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/pwd_icon.png',
                        ),
                        hintText: 'Enter your password',
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
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/pwd_icon.png',
                        ),
                        hintText: 'Re-enter your password',
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
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String password = _passwordController.text;
                        String confirmPassword = _confirmPasswordController.text;

                        if (password.isEmpty || confirmPassword.isEmpty) {
                          // Show error message
                          print('Password fields cannot be empty');
                          Fluttertoast.showToast(msg: "Password fields cannot be empty");
                          return;
                        }
                        else if (password != confirmPassword) {
                          // Show error message
                          Fluttertoast.showToast(msg: "Password not matched");
                          return;
                        } else {
                          // Assuming you have the token stored or passed to this screen
                          String token = (await _sharedPrefManager.getString(SharedPrefManager.otpTokenKey)) ?? ""; // Replace with actual token

                          bool success = await _apiService.resetPassword(token, password, confirmPassword);

                          if (success) {
                            Fluttertoast.showToast(msg: "Password reset successfull");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          } else {
                            Fluttertoast.showToast(msg: "Password reset failed");
                          }
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.customRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 20),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
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
