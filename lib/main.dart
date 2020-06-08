import 'package:flutter/material.dart';
import 'package:photo_rocks/Services/Auth.dart';
import 'package:photo_rocks/Services/LandingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // landing page to decide which page to show
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
