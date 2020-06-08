import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/CreateAccount.dart';

class SignIn extends StatefulWidget {
  final Function(FirebaseUser) onSignIn;
  SignIn({@required this.onSignIn});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signin  with mail method

  Future<void> _signInWithEmail(String mail, String password) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: mail, password: password))
          .user;
      widget.onSignIn(user);
      print("user id : ${user.uid}");
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    // text controllers

    // // firebase auth instance
    // final AuthService _auth = AuthService();

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
        body: SingleChildScrollView(
          child: Column(
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
                // sign in button
                child: GestureDetector(
                  onTap: () {
                    String mail = emailController.value.text;
                    String password = passwordController.value.text;

                    _signInWithEmail(mail, password);

                    emailController.clear();
                    passwordController.clear();
                  },
                  child: Container(
                    // container for button
                    height: totalHeight * 0.08,
                    width: totalWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.indigoAccent,
                    ),
                    child: Center(
                      child: Text(
                        // button text
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

              SizedBox(
                height: totalHeight * 0.04,
              ),
              // bottom section
              Row(
                children: [
                  SizedBox(
                    width: totalWidth * 0.2,
                  ),
                  Text(
                    "Don't have an account ?  ",
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: totalWidth * 0.04,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccount(),
                        ),
                      );
                    },
                    child: Text(
                      "Create One",
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: totalWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
