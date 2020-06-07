import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'HomePage.dart';
import '../Services/Auth.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // toal height and width contrans
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

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
                  "Create Account",
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
                          await _auth.registerWithMail(name, password);
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
                        "Sign up",
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
      ),
    );
  }
}
