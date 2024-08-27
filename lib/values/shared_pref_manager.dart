/*
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  // Keys for SharedPreferences
  static const String fullNameKey = 'full_name';
  static const String emailKey = 'email';
  static const String phoneKey = 'phone';
  static const String passwordKey = 'password';
  static const String roleKey = 'role';
  static const String businessNameKey = 'business_name';
  static const String informalNameKey = 'informal_name';
  static const String addressKey = 'address';
  static const String cityKey = 'city';
  static const String stateKey = 'state';
  static const String zipCodeKey = 'zip_code';
  static const String registrationProofKey = 'registration_proof';
  static const String deviceTokenKey = 'device_token';
  static const String typeKey = 'type';
  static const String socialIdKey = 'social_id';

  // Save user data
  Future<void> saveUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String businessName,
    required String informalName,
    required String address,
    required String city,
    required String state,
    required int zipCode,
    required String registrationProof,
    required String deviceToken,
    required String type,
    required String socialId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(fullNameKey, fullName);
    await prefs.setString(emailKey, email);
    await prefs.setString(phoneKey, phone);
    await prefs.setString(passwordKey, password);
    await prefs.setString(roleKey, role);
    await prefs.setString(businessNameKey, businessName);
    await prefs.setString(informalNameKey, informalName);
    await prefs.setString(addressKey, address);
    await prefs.setString(cityKey, city);
    await prefs.setString(stateKey, state);
    await prefs.setInt(zipCodeKey, zipCode);
    await prefs.setString(registrationProofKey, registrationProof);
    await prefs.setString(deviceTokenKey, deviceToken);
    await prefs.setString(typeKey, type);
    await prefs.setString(socialIdKey, socialId);
  }

  // Retrieve user data
  Future<Map<String, dynamic>> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      fullNameKey: prefs.getString(fullNameKey),
      emailKey: prefs.getString(emailKey),
      phoneKey: prefs.getString(phoneKey),
      passwordKey: prefs.getString(passwordKey),
      roleKey: prefs.getString(roleKey),
      businessNameKey: prefs.getString(businessNameKey),
      informalNameKey: prefs.getString(informalNameKey),
      addressKey: prefs.getString(addressKey),
      cityKey: prefs.getString(cityKey),
      stateKey: prefs.getString(stateKey),
      zipCodeKey: prefs.getInt(zipCodeKey),
      registrationProofKey: prefs.getString(registrationProofKey),
      deviceTokenKey: prefs.getString(deviceTokenKey),
      typeKey: prefs.getString(typeKey),
      socialIdKey: prefs.getString(socialIdKey),
    };
  }

  // Clear user data
  Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(fullNameKey);
    await prefs.remove(emailKey);
    await prefs.remove(phoneKey);
    await prefs.remove(passwordKey);
    await prefs.remove(roleKey);
    await prefs.remove(businessNameKey);
    await prefs.remove(informalNameKey);
    await prefs.remove(addressKey);
    await prefs.remove(cityKey);
    await prefs.remove(stateKey);
    await prefs.remove(zipCodeKey);
    await prefs.remove(registrationProofKey);
    await prefs.remove(deviceTokenKey);
    await prefs.remove(typeKey);
    await prefs.remove(socialIdKey);
  }
}
*/
