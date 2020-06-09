import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/HomePage.dart';
import 'package:photo_rocks/Screens/Signin.dart';
import 'package:photo_rocks/Services/Auth.dart';

class LandingPage extends StatelessWidget {
  // authbase instance

  final AuthBase auth;

  LandingPage({@required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignIn(
              auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
