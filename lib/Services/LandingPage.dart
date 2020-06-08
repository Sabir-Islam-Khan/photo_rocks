import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/HomePage.dart';
import 'package:photo_rocks/Screens/Signin.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // firebase user instance
  FirebaseUser _user;

  // method to update user state
  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }

  // init state check user method
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  // this method determines which page to show

  Future<void> _checkCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    // this part is pretty self explainatory

    if (_user == null) {
      return SignIn(
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
