import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_rocks/Services/Auth.dart';

class UploadImages extends StatefulWidget {
  final AuthBase auth;

  UploadImages({@required this.auth});
  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  File _image;
  final picker = ImagePicker();
  var storage = FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(
      () {
        _image = File(pickedFile.path);
      },
    );
  }

  Future<String> getUid() async {
    User user = await widget.auth.currentUser();

    return user.uid.toString();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // total Height and Width constrains

    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
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
        body: _isLoading == true
            ? Container(
                height: totalHeight * 1,
                width: totalWidth * 1,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
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
                      height: totalHeight * 0.03,
                    ),
                    // Upload button
                    RaisedButton(
                      onPressed: () async {
                        String uid = await getUid();
                        print("$uid");
                        setState(() {
                          _isLoading = true;
                        });
                        StorageTaskSnapshot snapshot = await storage
                            .ref()
                            .child("$uid/${DateTime.now()}")
                            .putFile(_image)
                            .onComplete;

                        if (snapshot.error == null) {
                          final String downloadUrl =
                              await snapshot.ref.getDownloadURL();
                          await Firestore.instance.collection("images").add({
                            "url": downloadUrl,
                            "name": _image.toString(),
                          });
                          setState(() {
                            _isLoading = false;
                          });
                          final snackBar = SnackBar(
                            content: Text('Yay! Success'),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          print(
                              'Error from image repo ${snapshot.error.toString()}');
                          throw ('This file is not an image');
                        }
                      },
                      color: Colors.indigo,
                      child: Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
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
