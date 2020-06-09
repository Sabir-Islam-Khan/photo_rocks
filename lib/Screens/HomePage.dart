import 'package:flutter/material.dart';
import 'package:photo_rocks/Services/Auth.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.auth});

  // authbase instance

  final AuthBase auth;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appbar
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text(
              "Home Page",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          actions: [
            // button for logging out
            FlatButton(
              onPressed: _signOut,
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
