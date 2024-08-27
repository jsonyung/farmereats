/*
import 'dart:convert'; // For JSON encoding/decoding
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
  static const String businessHoursKey = 'business_hours';
  static const String deviceTokenKey = 'device_token';
  static const String typeKey = 'type';
  static const String socialIdKey = 'social_id';

  // Save methods
  Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> setBusinessHours(Map<String, List<String>> businessHours) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(businessHoursKey, jsonEncode(businessHours));
  }

  Future<void> setRegistrationProof(String registrationProof) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(registrationProofKey, registrationProof);
  }

  // Get methods
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<Map<String, List<String>>> getBusinessHours() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final businessHoursJson = prefs.getString(businessHoursKey);
    if (businessHoursJson != null) {
      final Map<String, dynamic> businessHoursMap = jsonDecode(businessHoursJson);
      return businessHoursMap.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
      );
    }
    return {};
  }

  Future<String?> getRegistrationProof() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(registrationProofKey);
  }

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
    required String registrationProof, // Path or URL of the PDF
    required Map<String, List<String>> businessHours, // Business hours as a map
    required String deviceToken,
    required String type,
    required String socialId,
  }) async {
    await setString(fullNameKey, fullName);
    await setString(emailKey, email);
    await setString(phoneKey, phone);
    await setString(passwordKey, password);
    await setString(roleKey, role);
    await setString(businessNameKey, businessName);
    await setString(informalNameKey, informalName);
    await setString(addressKey, address);
    await setString(cityKey, city);
    await setString(stateKey, state);
    await setInt(zipCodeKey, zipCode);
    await setRegistrationProof(registrationProof);
    await setBusinessHours(businessHours);
    await setString(deviceTokenKey, deviceToken);
    await setString(typeKey, type);
    await setString(socialIdKey, socialId);
  }

  // Retrieve user data
  Future<Map<String, dynamic>> getUser() async {
    return {
      fullNameKey: await getString(fullNameKey),
      emailKey: await getString(emailKey),
      phoneKey: await getString(phoneKey),
      passwordKey: await getString(passwordKey),
      roleKey: await getString(roleKey),
      businessNameKey: await getString(businessNameKey),
      informalNameKey: await getString(informalNameKey),
      addressKey: await getString(addressKey),
      cityKey: await getString(cityKey),
      stateKey: await getString(stateKey),
      zipCodeKey: await getInt(zipCodeKey),
      registrationProofKey: await getRegistrationProof(),
      businessHoursKey: await getBusinessHours(),
      deviceTokenKey: await getString(deviceTokenKey),
      typeKey: await getString(typeKey),
      socialIdKey: await getString(socialIdKey),
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
    await prefs.remove(businessHoursKey);
    await prefs.remove(deviceTokenKey);
    await prefs.remove(typeKey);
    await prefs.remove(socialIdKey);
  }
}
*/
import 'dart:convert'; // For JSON encoding/decoding
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
  static const String streetKey = 'street_name';
  static const String cityKey = 'city';
  static const String stateKey = 'state';
  static const String zipCodeKey = 'zip_code';
  static const String registrationProofKey = 'registration_proof';
  static const String businessHoursKey = 'business_hours';
  static const String deviceTokenKey = 'device_token';
  static const String typeKey = 'type';
  static const String socialIdKey = 'social_id';
  static const String phoneOtpKey = 'phone_otp_key';
  static const String otpTokenKey = 'otp_token_key';

  // Save methods
  Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> setBusinessHours(Map<String, List<String>> businessHours) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(businessHoursKey, jsonEncode(businessHours));
  }

  Future<void> setRegistrationProof(String registrationProof) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(registrationProofKey, registrationProof);
  }

  // Get methods
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<Map<String, List<String>>> getBusinessHours() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final businessHoursJson = prefs.getString(businessHoursKey);
    if (businessHoursJson != null) {
      final Map<String, dynamic> businessHoursMap = jsonDecode(businessHoursJson);
      return businessHoursMap.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
      );
    }
    return {};
  }

  Future<String?> getRegistrationProof() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(registrationProofKey);
  }

  // Save user data with optional fields
  Future<void> saveUser({
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? role,
    String? businessName,
    String? informalName,
    String? streetName,
    String? address,
    String? city,
    String? state,
    int? zipCode,
    String? registrationProof,
    Map<String, List<String>>? businessHours,
    String? deviceToken,
    String? type,
    String? socialId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fullName != null) await prefs.setString(fullNameKey, fullName);
    if (email != null) await prefs.setString(emailKey, email);
    if (phone != null) await prefs.setString(phoneKey, phone);
    if (password != null) await prefs.setString(passwordKey, password);
    if (role != null) await prefs.setString(roleKey, role);
    if (businessName != null) await prefs.setString(businessNameKey, businessName);
    if (informalName != null) await prefs.setString(informalNameKey, informalName);
    if (streetName != null) await prefs.setString(informalNameKey, streetName);
    if (address != null) await prefs.setString(addressKey, address);
    if (city != null) await prefs.setString(cityKey, city);
    if (state != null) await prefs.setString(stateKey, state);
    if (zipCode != null) await prefs.setInt(zipCodeKey, zipCode);
    if (registrationProof != null) await setRegistrationProof(registrationProof);
    if (businessHours != null) await setBusinessHours(businessHours);
    if (deviceToken != null) await prefs.setString(deviceTokenKey, deviceToken);
    if (type != null) await prefs.setString(typeKey, type);
    if (socialId != null) await prefs.setString(socialIdKey, socialId);
  }

  // Retrieve user data with optional fields
  Future<Map<String, dynamic>> getUser() async {
    return {
      fullNameKey: await getString(fullNameKey),
      emailKey: await getString(emailKey),
      phoneKey: await getString(phoneKey),
      passwordKey: await getString(passwordKey),
      roleKey: await getString(roleKey),
      businessNameKey: await getString(businessNameKey),
      informalNameKey: await getString(informalNameKey),
      addressKey: await getString(addressKey),
      streetKey: await getString(streetKey),
      cityKey: await getString(cityKey),
      stateKey: await getString(stateKey),
      zipCodeKey: await getInt(zipCodeKey),
      registrationProofKey: await getRegistrationProof(),
      businessHoursKey: await getBusinessHours(),
      deviceTokenKey: await getString(deviceTokenKey),
      typeKey: await getString(typeKey),
      socialIdKey: await getString(socialIdKey),
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
    await prefs.remove(streetKey);
    await prefs.remove(cityKey);
    await prefs.remove(stateKey);
    await prefs.remove(zipCodeKey);
    await prefs.remove(registrationProofKey);
    await prefs.remove(businessHoursKey);
    await prefs.remove(deviceTokenKey);
    await prefs.remove(typeKey);
    await prefs.remove(socialIdKey);
  }
}
