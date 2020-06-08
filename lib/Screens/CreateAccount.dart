import 'package:flutter/material.dart';
import 'package:photo_rocks/Services/Auth.dart';
import 'package:photo_rocks/Services/LandingPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateAccount extends StatefulWidget {
  final AuthBase auth;

  CreateAccount({@required this.auth});
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

    return MaterialApp(
      home: Scaffold(
        // appbar
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text("Photo Rocks"),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
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
                // sign up button
                child: GestureDetector(
                  onTap: () async {
                    print("Sign up button tapped !");
                    String mail = emailController.value.text;
                    String password = passwordController.value.text;

                    try {
                      dynamic result = await widget.auth
                          .createAccountWithEmail(mail, password);
                      if (result == null) {
                        // alert if info is invalid
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
                        // goes to landing page after succesful
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // here landing page takes user to homepage
                            builder: (context) => LandingPage(
                              auth: widget.auth,
                            ),
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
                    // container for the button
                    height: totalHeight * 0.08,
                    width: totalWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.indigoAccent,
                    ),
                    child: Center(
                      // button text
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
