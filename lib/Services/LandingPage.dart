import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/HomePage.dart';
import 'package:photo_rocks/Screens/Signin.dart';
import 'package:photo_rocks/Services/Auth.dart';

class LandingPage extends StatefulWidget {
  // authbase instance

  final AuthBase auth;

  LandingPage({@required this.auth});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // User class instance
  User _user;

  // init state check user method
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  // this method determines which page to show

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  // method to update user state
  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    // this part is pretty self explainatory

    if (_user == null) {
      return SignIn(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
