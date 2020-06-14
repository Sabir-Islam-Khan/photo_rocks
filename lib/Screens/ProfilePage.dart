import 'package:flutter/material.dart';
import 'package:photo_rocks/Widgets/CustomNavBar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CustomNavBar(
          totalHeight,
          totalWidth,
          "ProfilePage",
        ),
        body: Container(),
      ),
    );
  }
}
