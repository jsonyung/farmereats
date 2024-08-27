import 'package:farmereats/login/login.dart';
import 'package:farmereats/login/verify_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/services.dart';

import '../network/api_client.dart';
import '../network/api_service.dart';
import '../values/shared_pref.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneController = TextEditingController();
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final ApiService _apiService = ApiService(ApiClient('https://sowlab.com/assignment'));
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
                'Forgot Password?',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()), // Replace with your next screen
                          );
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
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/phone.png',
                        ),
                        hintText: 'Phone Number',
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
                        String phoneNumber = _phoneController.text;
                        _sharedPrefManager.setString(SharedPrefManager.phoneOtpKey, phoneNumber);
                        bool success = await _apiService.forgotPassword(phoneNumber);
                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VerifyOtp()),
                          );
                        } else {
                          // Show an error message
                          print('Failed to send forgot password code');
                        }
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
                        'Send Code',
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
