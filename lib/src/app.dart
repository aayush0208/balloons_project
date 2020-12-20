import 'package:balloons/src/screens/login_signup.dart';
import 'package:balloons/src/screens/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new LoginSignUp(),
    );
  }
}
