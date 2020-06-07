import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text("Provider test"),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.15,
            ),
            Center(
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Center(
              child: Card(
                elevation: 20.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: height * 0.09,
                    width: width * 0.8,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        print("Google tapped !");
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20.0),
                          Image(
                            image: AssetImage("assets/images/googleLogo.png"),
                          ),
                          SizedBox(
                            width: width * 0.12,
                          ),
                          Center(
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Card(
                elevation: 20.0,
                child: Container(
                  height: height * 0.09,
                  width: width * 0.8,
                  color: Color.fromRGBO(66, 103, 178, 1),
                  child: GestureDetector(
                    onTap: () {
                      print("Facebook Tapped !");
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          color: Colors.white,
                          child: Image(
                            image: AssetImage(
                              "assets/images/facebookLogo.png",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.1,
                        ),
                        Text(
                          "Sign in with Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  print("Email Auth");
                },
                child: Card(
                  elevation: 20.0,
                  child: Container(
                    height: height * 0.09,
                    width: width * 0.8,
                    color: Color.fromRGBO(0, 108, 94, 1),
                    child: Center(
                      child: Text(
                        "Sign in with Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Or",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  print("Anonymous !");
                },
                child: Card(
                  elevation: 20.0,
                  child: Container(
                    height: height * 0.09,
                    width: width * 0.8,
                    color: Color.fromRGBO(214, 225, 106, 1),
                    child: Center(
                      child: Text(
                        "Go Anonymous",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
