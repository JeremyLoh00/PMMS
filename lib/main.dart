import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';

import 'screens/sign_in/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Nurse Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}
