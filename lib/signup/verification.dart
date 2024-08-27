

import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../values/shared_pref.dart';
import 'business_hours.dart';
import 'farm_info.dart';


class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  PlatformFile? _selectedFile;
  final TextEditingController _fileController = TextEditingController();
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();

  @override
  void dispose() {
    _fileController.dispose();
    super.dispose();
  }
  void _submit() async {
    if (_selectedFile == null) {
      Fluttertoast.showToast(msg: "Please attach a proof of registration.");
      return;
    }
    // Store the selected file's path in SharedPreferences
    await _sharedPrefManager.setRegistrationProof(_selectedFile!.path!);

    // After saving data, navigate to the next screen
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (!mounted) return; // Ensure the widget is still mounted before calling `Navigator`

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessHours()), // Replace with your next screen
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
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmInfo()),
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
              onPressed: _selectedFile != null ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.customRed,
                // Adjust the color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child:  Text(_selectedFile != null ? 'Submit' : 'Continue',
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
              'Signup 3 of 4',
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
              'Verification',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Attached proof of Department of Agriculture registrations (i.e., Florida Fresh, USDA Approved, USDA Organic)',
              style: TextStyle(fontSize: 14.0,
                color: Colors.grey,),
            ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Attach proof of registration:'),
                    //const SizedBox(width: 20.0),
                    Ink(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red[300],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_outlined,color: Colors.white),

                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg', 'png'], // Adjust allowed extensions as needed
                          );

                          if (result != null) {
                            setState(() {
                              _selectedFile = result.files.single;
                            });
                            _fileController.text = _selectedFile?.name ?? '';
                          }
                        }
                      ),
                    ),
                  ],
                ),
               const SizedBox(height: 16.0),
                _selectedFile != null
                    ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _fileController,
                            readOnly: true,
                            style: const TextStyle(fontSize: 14,),
                            decoration: InputDecoration(
                              hintText: _selectedFile?.name,
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
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.close, size: 18.0),
                                onPressed: () {
                                  setState(() {
                                    _selectedFile = null;
                                    _fileController.clear();
                                  });
                                },
                              )
                            ),
                          ),
                        ),
                      ],
                    ): Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
