import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/NewsFeed.dart';
import 'package:photo_rocks/Screens/UploadImages.dart';
import 'package:photo_rocks/Services/Auth.dart';
import 'package:photo_rocks/Widgets/CustomNavBar.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.auth});

  // authbase instance

  final AuthBase auth;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    setState(() {
      print("Rebuilds app");
    });
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

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
        bottomNavigationBar: CustomNavBar(
          totalHeight,
          totalWidth,
          "HomePage",
        ),
        backgroundColor: Colors.grey[300],
        body: Container(
          height: totalHeight * 1,
          width: totalWidth * 1,
          child: Column(
            children: [
              SizedBox(
                height: totalHeight * 0.35,
              ),
              RaisedButton(
                color: Colors.teal,
                onPressed: () {
                  print("Upload images button tapped !");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadImages(
                        auth: widget.auth,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Upload images",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: totalHeight * 0.04,
              ),
              RaisedButton(
                onPressed: () {
                  print("View images button tapped");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsFeed(
                        auth: Auth(),
                      ),
                    ),
                  );
                },
                color: Colors.green,
                child: Text(
                  "View Images",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
