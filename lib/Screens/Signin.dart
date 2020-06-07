import 'package:flutter/material.dart';
import 'package:photo_rocks/Screens/CreateAccount.dart';
import 'package:photo_rocks/Screens/HomePage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Services/Auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    // text controllers

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
                child: GestureDetector(
                  onTap: () async {
                    print("Sign in button tapped !");

                    String name = emailController.value.text;
                    String password = passwordController.value.text;

                    try {
                      dynamic result =
                          await _auth.signInWithMail(name, password);
                      if (result == null) {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Error !!",
                          desc: "Info invalid. Check credentials !",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Okay",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }

                    emailController.clear();
                    passwordController.clear();
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

              SizedBox(
                height: totalHeight * 0.04,
              ),

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
