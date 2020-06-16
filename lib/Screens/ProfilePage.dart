import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_rocks/Services/Auth.dart';
import 'package:photo_rocks/Widgets/CustomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final AuthBase auth;

  ProfilePage({@required this.auth});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getPpUrl();
  }

  void getPpUrl() async {
    User user = await widget.auth.currentUser();
    String uid = user.uid;
    DocumentSnapshot ds =
        await Firestore.instance.collection('Users').document('$uid').get();
    print("Profile url is $ppUrl");
    print("Uid here is  $uid");
    setState(() {
      ppUrl = ds.data['profilePic'];
    });
  }

  String ppUrl = '';
  File _image;
  final picker = ImagePicker();

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://photo-rocks.appspot.com");

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _image = File(pickedFile.path);
      },
    );
  }

  bool _isLoading = false;
  String uid;
  void uploadImage() async {
    User user = await widget.auth.currentUser();
    uid = user.uid;
    print("$uid");
    setState(() {
      _isLoading = true;
    });
    StorageTaskSnapshot snapshot = await _storage
        .ref()
        .child("$uid/${DateTime.now()}")
        .putFile(_image)
        .onComplete;
    final String profileImage = await snapshot.ref.getDownloadURL();
    await Firestore.instance.collection("Users").document('$uid').setData({
      "profilePic": profileImage,
      "name": nameController.value.text,
    });
    nameController.clear();
    setState(() {
      _isLoading = false;
    });
  }

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CustomNavBar(
          totalHeight,
          totalWidth,
          "ProfilePage",
        ),
        body: _isLoading == true
            ? Container(
                height: totalHeight * 1,
                width: totalWidth * 1,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  height: totalHeight * 1,
                  width: totalWidth * 1,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.04,
                            top: totalHeight * 0.04,
                          ),
                          child: Text(
                            "Name :",
                            style: TextStyle(
                              fontSize: totalHeight * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.02,
                            right: totalWidth * 0.02,
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Enter Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.2,
                          ),
                          child: ClipOval(
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.teal[100],
                              child: ppUrl == ''
                                  ? Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/images/avatar_placeholder.png",
                                      ),
                                    )
                                  : Container(
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(
                                          ppUrl,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.35,
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              getImage();
                            },
                            color: Colors.teal,
                            child: Text(
                              "Pick Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.4,
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              print("Uid in profile is $uid");
                              uploadImage();
                            },
                            child: Text("Save"),
                          ),
                        ),
                        SizedBox(
                          height: totalHeight * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
