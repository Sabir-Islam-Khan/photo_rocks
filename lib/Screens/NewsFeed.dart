import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final searchController = TextEditingController();
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
        body: SingleChildScrollView(
          child: Container(
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
                        return Container(
                          width: totalWidth * 1,
                          height: totalHeight * 0.78,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: totalHeight * 0.01,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: totalWidth * 0.04),
                                    width: totalWidth * 0.93,
                                    height: totalHeight * 0.3,
                                    child: Image.network(
                                        snapshot
                                            .data.documents[index].data["url"],
                                        fit: BoxFit.fill),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: totalWidth * 0.04,
                                      top: totalHeight * 0.01,
                                    ),
                                    child: Text(
                                      "${snapshot.data.documents[index].data["name"]}",
                                      style: TextStyle(
                                        fontSize: totalHeight * 0.023,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: totalWidth * 0.04,
                                      ),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        " 5466",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: totalWidth * 0.5,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.pink[300],
                                      ),
                                      Text(
                                        " 540",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: totalHeight * 0.01,
                                  ),
                                ],
                              );
                            },
                          ),
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
      ),
    );
  }
}
