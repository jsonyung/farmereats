import 'package:farmereats/login/login.dart';
import 'package:farmereats/login/reset_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import '../network/api_client.dart';
import '../network/api_service.dart';
import '../values/shared_pref.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final apiService = ApiService(ApiClient("https://sowlab.com/assignment"));
  final TextEditingController _otpController = TextEditingController();
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: MyColors.customGreyLight,
      border: Border.all(color: MyColors.customGreyLight),
    ),
  );

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
                'Verify OTP?',
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
                      style: TextStyle(color: MyColors.customRed, fontSize: 14), // Red color
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap event for "create account"
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()), // Replace with your next screen
                          );
                          print('Login tapped!');
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Pinput(
                          length: 5,
                          controller: _otpController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColors.customOrange),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.customOrange,
                            ),
                          ),
                          onCompleted: (pin) async {
                            try {
                              // Log the OTP and URL before verification
                              print('Verifying OTP: $pin');
                              _sharedPrefManager.setString(SharedPrefManager.otpTokenKey, pin);
                              bool success = await apiService.verifyOtp(pin);
                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()),
                                );
                              } else {
                                // Show an error message
                                print('OTP verification failed');
                                Fluttertoast.showToast(msg: "OTP verification failed");
                              }
                            } catch (e) {
                              // Log the exception for debugging
                              print('Exception during OTP verification: $e');
                              Fluttertoast.showToast(msg: "OTP verification failed");
                            }
                          },
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
                        try {
                          String otp = _otpController.text;
                          // Log the OTP and URL before verification
                          _sharedPrefManager.setString(SharedPrefManager.otpTokenKey, otp);
                          print('Verifying OTP: $otp');
                          bool success = await apiService.verifyOtp(otp);
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()),
                            );
                          } else {
                            // Show an error message
                            print('OTP verification failed');
                            Fluttertoast.showToast(msg: "OTP verification failed");
                          }
                        } catch (e) {
                          // Log the exception for debugging
                          print('Exception during OTP verification: $e');
                          Fluttertoast.showToast(msg: "OTP verification failed");
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
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Resend code',
                    style: const TextStyle(
                      color: Colors.black, // Adjust color as needed
                      fontSize: 16, // Adjust font size as needed
                      decoration: TextDecoration.underline, // Adds underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {

                        print('Resend code tapped!');
                        try {
                         String phoneNumber = (await _sharedPrefManager.getString(SharedPrefManager.phoneOtpKey)) ?? "";
                          bool success = await apiService.forgotPassword(phoneNumber);
                          if (success) {
                            Fluttertoast.showToast(msg: "OTP sent successfully");
                          } else {
                            Fluttertoast.showToast(msg: "Unable to sent OTP, try after sometime!");
                          }
                        } catch (e) {
                          // Log the exception for debugging
                          print('Exception during resend OTP : $e');
                          Fluttertoast.showToast(msg: "Unable to sent OTP, try after sometime!");
                        }
                      },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
