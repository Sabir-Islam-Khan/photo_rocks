import 'package:flutter/material.dart';
import '../Services/Auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    // text controllers

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // firebase auth instance
    final AuthService _auth = AuthService();

    return MaterialApp(
      home: Scaffold(
        // appbar
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text("Photo Rocks"),
          ),
        ),
        // main body
        backgroundColor: Colors.grey[200],
        // TODO: this is just core functionality. Have to change UI later
        body: Column(
          children: <Widget>[
            SizedBox(
              height: totalHeight * 0.15,
            ),
            // sign in button
            Center(
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: totalHeight * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: totalHeight * 0.02,
            ),
            // textfiled for email
            Container(
              width: totalWidth * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
            ),

            SizedBox(
              height: totalHeight * 0.01,
            ),
            // textfield for password
            Container(
              width: totalWidth * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: totalHeight * 0.03,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  print("Sign in button tapped !");
                  String name = emailController.value.text;
                  print("mail is $name");
                  print("password is $passwordController");
                  // dynamic result = await _auth.registerWithMail(
                  //   emailController.value.text,
                  //   passwordController.value.text,
                  // );
                },
                child: Container(
                  height: totalHeight * 0.08,
                  width: totalWidth * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.indigoAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
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
