import 'dart:convert';
import 'dart:io';

import '../model/user_model.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  Future<bool> registerUser(UserModel user, File? registrationProof) async {
    try {
      final response = await _apiClient.post('/user/register', user.toJson(), file: registrationProof);

      if (response.statusCode == 200) {
        // Handle success (e.g., parse the response, save data, etc.)
        print('Erroreeeee: ${response.statusCode}, ${response.body}');
        return true;
      } else {
        // Handle different status codes as needed
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final response = await _apiClient.post(
        '/user/login', // Adjust this endpoint to match your API
        {
          'email': email,
          'password': password,
          "role": "farmer",
          "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx44",
          "type": "email",
          "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx44"
        },
      );

      if (response.statusCode == 200) {
        // Handle success (e.g., parse the response, save data, etc.)
        print('Login success: ${response.statusCode}, ${response.body}');
        return true;
      } else {
        // Handle different status codes as needed
        print('Login error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Login exception: $e');
      return false;
    }
  }
  Future<bool> forgotPassword(String phoneNumber) async {
    try {
      final response = await _apiClient.post(
        '/user/forgot-password',
        {'phone': phoneNumber},
      );

      if (response.statusCode == 200) {
        // Handle success, for example, navigate to the OTP screen
        print('Forgot Password success: ${response.statusCode}, ${response.body}');
        return true;
      } else {
        // Handle different status codes as needed
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {


      final response = await _apiClient.post('/user/verify-otp',
        {
          'otp': otp, // Adjust the fields as per your API requirements
        },
      );

      if (response.statusCode == 200) {
        // OTP verified successfully
        print('OTP Verified: ${response.statusCode}, ${response.body}');
        return true;
      } else {
        // Handle failure cases
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String token, String password, String cpassword) async {
    try {
      final response = await _apiClient.post('/user/reset-password', {
        'token': token,
        'password': password,
        'cpassword': cpassword,
      });

      if (response.statusCode == 200) {
        // Password reset successfully
        print('Password Reset: ${response.statusCode}, ${response.body}');
        return true;
      } else {
        // Handle failure cases
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Exception: $e');
      return false;
    }
  }

}

