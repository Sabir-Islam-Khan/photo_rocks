import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_rocks/Services/Auth.dart';
import 'package:photo_rocks/Widgets/CustomNavBar.dart';

class UploadImages extends StatefulWidget {
  final AuthBase auth;

  UploadImages({@required this.auth});
  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  File _image;
  final picker = ImagePicker();
  // var storage = FirebaseStorage.instance;

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

  String test;
  Future<String> getUid() async {
    User user = await widget.auth.currentUser();
    setState(() {
      test = user.uid;
    });
    return user.uid.toString();
  }

  void uploadImage() async {
    String uid = await getUid();
    print("$uid");
    setState(() {
      _isLoading = true;
    });
    StorageTaskSnapshot snapshot = await _storage
        .ref()
        .child("$uid/${DateTime.now()}")
        .putFile(_image)
        .onComplete;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    await Firestore.instance.collection("images").add({
      "url": downloadUrl,
      "name": captionController.value.text,
    });
    captionController.clear();
    setState(() {
      _isLoading = false;
    });
  }

  final captionController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // total Height and Width constrains

    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text(
              "Upload Images",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          totalHeight,
          totalWidth,
          "UploadImages",
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
                  child: Column(
                    children: [
                      Container(
                        height: totalHeight * 0.4,
                        width: totalWidth * 1,
                        color: Colors.teal[100],
                        child: _image == null
                            ? Center(
                                child: Text(
                                  "Please select an  image",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              )
                            : Container(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.file(_image),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: totalHeight * 0.03,
                      ),
                      RaisedButton(
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

                      SizedBox(
                        height: totalHeight * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(230, 230, 236, 1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        height: totalHeight * 0.05,
                        width: totalWidth * 0.94,
                        child: TextField(
                          controller: captionController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Caption",
                            prefixIcon: Icon(
                              Icons.forum,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: totalHeight * 0.03,
                      ),
                      // Upload button
                      RaisedButton(
                        onPressed: () async {
                          uploadImage();
                        },
                        color: Colors.indigo,
                        child: Text(
                          "Upload",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
