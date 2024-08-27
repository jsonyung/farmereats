import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:Container(
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  Verification()),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.customRed,
                // Adjust the color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 140, vertical: 20),
              ),
              child: const Text('Got it!',style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Checkmark icon
                Image.asset('assets/right_icon.png'),
              // Title
              const SizedBox(height: 30,),
              const Text(
                'You\'re all done!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ), // De
              const SizedBox(height: 30,),// scription
              const Text(
                'Hang tight! We\'re currently reviewing your account and \n'
                    'will follow up with you in 2-3 business days. In the \n'
                    'meantime, you can set up your inventory.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12,color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}