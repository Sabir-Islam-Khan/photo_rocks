import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/ProfilePage.dart';
import '../Screens/HomePage.dart';
import '../Screens/NewsFeed.dart';
import '../Screens/UploadImages.dart';

class CustomNavBar extends StatefulWidget {
  final double totalheight;
  final double totalWidth;
  final String pageName;
  CustomNavBar(this.totalheight, this.totalWidth, this.pageName);
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.totalheight * 0.06,
      // Disable this decoration if you don't want the shadow
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2.0,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // container for DashBoard
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(auth: null),
                ),
              );
            },
            child: Container(
              child: widget.pageName == "HomePage"
                  ? Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/home_active.png"),
                    )
                  : Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/home_inactive.png"),
                    ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsFeed(),
                ),
              );
            },
            child: Container(
              child: widget.pageName == "NewsFeed"
                  ? Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/feed_active.png"),
                    )
                  : Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/feed_inactive.png"),
                    ),
            ),
          ),

          // Container for waller address
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadImages(auth: null),
                ),
              );
            },
            child: Container(
              child: widget.pageName == "UploadImages"
                  ? Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/upload_active.png"),
                    )
                  : Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/upload_inactive.png"),
                    ),
            ),
          ),

          // Container for Transaction List
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            child: Container(
              child: widget.pageName == "ProfilePage"
                  ? Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/profile_active.png"),
                    )
                  : Image(
                      height: widget.totalheight * 0.1,
                      width: widget.totalWidth * 0.25,
                      image: AssetImage("assets/images/profile_inactive.png"),
                    ),
            ),
          ),
          // container  for send balance
        ],
      ),
    );
  }
}
