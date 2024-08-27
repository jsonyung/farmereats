import 'package:farmereats/values/my_colors.dart';
import 'package:flutter/material.dart';
import 'onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ignore_for_file: public_member_api_docs
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'farmereats',
      theme: ThemeData(primarySwatch: MyColors.customRed),
      home: const OnboardingScreen(),
    );
  }
}
