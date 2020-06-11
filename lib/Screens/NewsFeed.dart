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
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text(
              "News Feed",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Container(
          height: totalHeight * 1,
          width: totalWidth * 1,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: FutureBuilder(
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
                              Image.network(
                                  snapshot.data.documents[index].data["url"],
                                  fit: BoxFit.fill),
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
              ),

              /// code here
            ],
          ),
        ),
      ),
    );
  }
}
