import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    // total Height and Width constrains

    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    Future<QuerySnapshot> getImages() {
      return Firestore.instance.collection("images").getDocuments();
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: totalHeight * 1,
          width: totalWidth * 1,
          // safe area ** you know why ** :3
          child: SafeArea(
            // column for the whole body
            child: Column(
              children: [
                // padding for title
                Padding(
                  padding: EdgeInsets.only(
                    top: totalHeight * 0.02,
                  ),
                  // row containing title and drop down
                  child: Row(
                    children: [
                      SizedBox(
                        width: totalWidth * 0.04,
                      ),
                      // title
                      Text(
                        "Popular",
                        style: TextStyle(
                          fontSize: totalHeight * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: totalWidth * 0.01,
                      ),
                      // drop down
                      Padding(
                        padding: EdgeInsets.only(
                          top: totalHeight * 0.008,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: totalHeight * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
                // search box
                SizedBox(
                  height: totalHeight * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: totalHeight * 0.05,
                  width: totalWidth * 0.94,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Keywords",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: getImages(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: totalHeight * 0.01,
                              ),
                              Container(
                                width: totalWidth * 0.93,
                                height: totalHeight * 0.35,
                                child: Image.network(
                                    snapshot.data.documents[index].data["url"],
                                    fit: BoxFit.fill),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Text("No data");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
