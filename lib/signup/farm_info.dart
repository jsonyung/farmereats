import 'package:farmereats/signup/sign_up.dart';
import 'package:farmereats/signup/verification.dart';
import 'package:farmereats/values/my_colors.dart';
import 'package:farmereats/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../values/shared_pref.dart';

class FarmInfo extends StatefulWidget {
  const FarmInfo({super.key});

  @override
  State<FarmInfo> createState() => _FarmInfoState();
}

class _FarmInfoState extends State<FarmInfo> with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final _businessNameController = TextEditingController();
  final _informalNameController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _cityController = TextEditingController();
 // final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  String? _selectedState = indianStates.isNotEmpty ? indianStates[0] : null; // Set default if needed


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _businessNameController.dispose();
    _informalNameController.dispose();
    _streetNameController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0.0;
    });
  }
  Future<void> _saveFormData() async {
    final businessName = _businessNameController.text;
    final informalName = _informalNameController.text;
    final streetName = _streetNameController.text;
    final city = _cityController.text;
    final state = _selectedState;
    final zipcode = _zipcodeController.text;

    // Check if any required field is empty
    if (businessName.isEmpty) {
      Fluttertoast.showToast(msg: "Business Name is required");
      return;
    }
    if (informalName.isEmpty) {
      Fluttertoast.showToast(msg: "Informal Name is required");
      return;
    }
    if (streetName.isEmpty) {
      Fluttertoast.showToast(msg: "Street Name is required");
      return;
    }
    if (city.isEmpty) {
      Fluttertoast.showToast(msg: "City is required");
      return;
    }
    if (_selectedState!.isEmpty||_selectedState == null) {
      Fluttertoast.showToast(msg: "State is required");
      return;
    }
    if (zipcode.isEmpty) {
      Fluttertoast.showToast(msg: "Zipcode is required");
      return;
    }
    // Convert zipcode to number
    final int? zipCodeNumber = int.tryParse(zipcode);
    if (zipCodeNumber == null) {
      Fluttertoast.showToast(msg: "Zipcode must be a number");
      return;
    }
    // Save data if all fields are valid
    await _sharedPrefManager.saveUser(
      businessName: businessName,
      informalName: informalName,
      streetName: streetName,
      city: city,
      state: state,
      zipCode: zipCodeNumber,
    );

    // After saving data, navigate to the next screen
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (!mounted) return; // Ensure the widget is still mounted before calling `Navigator`

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Verification()), // Replace with your next screen
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Choose transparent or white based on preference
        elevation: 0.0, // Remove any shadow
        title: const Text('farmereats', style: TextStyle(color: Colors.black), // Adjust text color if needed
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:_isKeyboardVisible
          ? null
          : Container(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Make the button transparent
                  elevation: 0, // Remove the button's elevation
              ),
              icon: const Icon(Icons.arrow_back_outlined,color: Colors.black,),
              label: const Text(''),),
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
                _saveFormData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.customRed,
                // Adjust the color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 20),
              ),
              child: const Text('Continue',style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Text(
                'Signup 2 of 4',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              const Text(
                'FarmInfo',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black),
              ),
              SizedBox(height: 16),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _businessNameController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/business.png',),
                        hintText: 'Business Name',
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
                      controller: _informalNameController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/informal_name.png',
                        ),
                        hintText: 'Informal Name',
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
                      controller: _streetNameController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/street.png',
                        ),
                        hintText: 'Street Name',
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
                      controller: _cityController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/city.png',
                        ),
                        //labelText: 'Password',
                        hintText: 'City',
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
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: DropdownButtonFormField<String>(
                              value: _selectedState,
                            decoration: InputDecoration(
                              hintText: 'State',
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
                            items: indianStates.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                  overflow: TextOverflow.ellipsis,),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedState = value; // Update the selected state
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: _zipcodeController,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter Zipcode',
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
