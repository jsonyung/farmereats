import 'dart:convert';
import 'dart:io';

import 'package:farmereats/signup/success.dart';
import 'package:farmereats/signup/verification.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';
import '../network/api_client.dart';
import '../network/api_service.dart';
import '../values/shared_pref.dart';

class BusinessHours extends StatefulWidget {
  const BusinessHours({super.key});

  @override
  State<BusinessHours> createState() => _BusinessHoursState();
}

class _BusinessHoursState extends State<BusinessHours> {
  List<bool> _selectedDays = List.filled(7, false);
  final List<List<bool>> _selectedTimeSlots = List.generate(7, (_) => List.filled(5, false));
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  void _selectDay(int index) {
    setState(() {
      _selectedDays = List.filled(7, false);
      _selectedDays[index] = true;
    });
  }
  bool hasSelectedTimeSlot(int dayIndex) => _selectedTimeSlots[dayIndex].contains(true);

  void _saveBusinessHours() async {
    // Check if at least one day has been selected
    if (!_selectedDays.contains(true)) {
      Fluttertoast.showToast(msg: "Please select at least one day.");
      return;
    }

    // Check if every selected day has at least one time slot selected
    bool allDaysHaveTimeSlots = true;
    for (int i = 0; i < _selectedDays.length; i++) {
      if (_selectedDays[i] && !_selectedTimeSlots[i].contains(true)) {
        Fluttertoast.showToast(msg: "Please select at least one time slot for each selected day.");
        allDaysHaveTimeSlots = false;
        break;
      }
    }

    if (!allDaysHaveTimeSlots) {
      return;
    }

    // Prepare business hours data for all days with selected time slots
    final businessHours = <String, List<String>>{};
    final daysOfWeek = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    for (int i = 0; i < _selectedDays.length; i++) {
      businessHours[daysOfWeek[i]] = _selectedTimeSlots[i].asMap().entries
          .where((entry) => entry.value)
          .map((entry) => getTimeSlotText(entry.key))
          .toList();
    }

    // Ensure all days are included in the map
    for (final day in daysOfWeek) {
      if (!businessHours.containsKey(day)) {
        businessHours[day] = [];  // Add empty list for days with no selected time slots
      }
    }

    try{
      final jsonBusinessHours = jsonEncode(businessHours);

      await _sharedPrefManager.setBusinessHours(businessHours);

      // Get the user data from SharedPreferences
      final user = await _sharedPrefManager.getUser();
      if (user == null) {
        Fluttertoast.showToast(msg: "Failed to retrieve user data.");
        return;
      }

      // Create a UserModel instance with retrieved data
      final userModel = UserModel(
        fullName: user[SharedPrefManager.fullNameKey] ?? '',
        email: user[SharedPrefManager.emailKey] ?? '',
        phone: user[SharedPrefManager.phoneKey] ?? '',
        password: user[SharedPrefManager.passwordKey] ?? '',
        role: user[SharedPrefManager.roleKey] ?? 'farmer',
        businessName: user[SharedPrefManager.businessNameKey] ?? '',
        informalName: user[SharedPrefManager.informalNameKey] ?? '',
        address: user[SharedPrefManager.addressKey] ?? '',
        city: user[SharedPrefManager.cityKey] ?? '',
        state: user[SharedPrefManager.stateKey] ?? '',
        zipCode: user[SharedPrefManager.zipCodeKey] ?? '',
        registrationProof: user[SharedPrefManager.registrationProofKey] ?? '',
        businessHours: businessHours,
        deviceToken: user[SharedPrefManager.deviceTokenKey] ?? '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx44',
        type: user[SharedPrefManager.typeKey] ?? 'email',
        socialId: user[SharedPrefManager.socialIdKey] ?? '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx44',
      );

      File? file = File(user[SharedPrefManager.registrationProofKey] ?? '');
      final apiService = ApiService(ApiClient("https://sowlab.com/assignment")); // Pass your ApiClient instance
      final success = await apiService.registerUser(userModel, file);
      print("alll data $userModel");

      // Convert to JSON
      // final userJson = userModel.toJson();
      // print('User JSON: $userJson');
      //
      // // Convert back from JSON
      // final userModelFromJson = UserModel.fromJson(userJson);
      // print('User Model from JSON: $userModelFromJson');
      if (success) {
        // Navigate to the success screen
        _navigateToNextScreen();
      } else {
        Fluttertoast.showToast(msg: "Signup failed. Please try again.");
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Error saving business hours: ${e.toString()}");
    }
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
        // Choose transparent or white based on preference
        elevation: 0.0,
        // Remove any shadow
        title: const Text(
          'farmereats',
          style: TextStyle(color: Colors.black), // Adjust text color if needed
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Verification()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                // Make the button transparent
                elevation: 0, // Remove the button's elevation
              ),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              label: const Text(''),
            ),
            ElevatedButton(
              onPressed: () {
                _saveBusinessHours();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.customRed,
                // Adjust the color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                'Signup',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Signup 4 of 4',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Business Hours',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose the hours your farm is open for pickups.\nThis will allow customers to order deliveries.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(7, (index) {
                      return TextButton(
                        onPressed: () => _selectDay(index),
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedDays[index]
                              ? MyColors.customRed
                              : (hasSelectedTimeSlot(index) ? MyColors.customGreyLight : Colors.transparent),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: _selectedDays[index] ? MyColors.customRed : MyColors.customGreyLight,
                            width: 1.0,
                          ),
                          minimumSize: Size(40, 40), // Set a minimum size for a square shape
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          daysOfWeek[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedDays[index] ? Colors.white :(hasSelectedTimeSlot(index) ? Colors.black : MyColors.customGreyLight),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20.0),
                if (_selectedDays.contains(true))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          int selectedDayIndex = _selectedDays.indexOf(true);
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //_selectedTimeSlots[index] = !_selectedTimeSlots[index];
                                _selectedTimeSlots[selectedDayIndex][index] = !_selectedTimeSlots[selectedDayIndex][index];
                              });
                            },
                            style: ElevatedButton.styleFrom(
                            //  primary: _selectedTimeSlots[index] ? Colors.blue : Colors.grey,
                              backgroundColor: _selectedTimeSlots[selectedDayIndex][index] ? MyColors.customOrange: MyColors.customGreyLight,
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              getTimeSlotText(index),
                              style: TextStyle(
                                fontSize: 12,
                               // color: _selectedTimeSlots[index] ? Colors.white : Colors.black,
                                color: _selectedTimeSlots[selectedDayIndex][index] ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTimeSlotText(int index) {
    switch (index) {
      case 0:
        return '8:00 AM - 10:00 AM';
      case 1:
        return '10:00 AM - 1:00 PM';
      case 2:
        return '1:00 PM - 4:00 PM';
      case 3:
        return '4:00 PM - 7:00 PM';
      case 4:
        return '7:00 PM - 10:00 PM';
      default:
        return '';
    }
  }
}
const List<String> daysOfWeek = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];











