import 'dart:convert';

class UserModel {
  String fullName;
  String email;
  String phone;
  String password;
  String role;
  String businessName;
  String informalName;
  String address;
  String city;
  String state;
  int zipCode;
  String registrationProof;
  Map<String, List<String>> businessHours;
  String deviceToken;
  String type;
  String socialId;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.registrationProof,
    required this.businessHours,
    required this.deviceToken,
    required this.type,
    required this.socialId,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'business_name': businessName,
      'informal_name': informalName,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'registration_proof': registrationProof,
      'business_hours': jsonEncode(businessHours), // Ensure it's a JSON string
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      businessName: json['business_name'],
      informalName: json['informal_name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      registrationProof: json['registration_proof'],
      businessHours:
          (jsonDecode(json['business_hours']) as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
      deviceToken: json['device_token'],
      type: json['type'],
      socialId: json['social_id'],
    );
  }

  @override
  String toString() {
    return 'UserModel{fullName: $fullName, email: $email, phone: $phone, password: $password, role: $role, businessName: $businessName, informalName: $informalName, address: $address, city: $city, state: $state, zipCode: $zipCode, registrationProof: $registrationProof, businessHours: $businessHours, deviceToken: $deviceToken, type: $type, socialId: $socialId}';
  }
}
