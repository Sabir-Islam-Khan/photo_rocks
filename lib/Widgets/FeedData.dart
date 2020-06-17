import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedData extends StatefulWidget {
  final double totalHeight;
  final double totalWidth;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  FeedData(
    this.totalHeight,
    this.totalWidth,
    this.snapshot,
  );
  @override
  _FeedDataState createState() => _FeedDataState();
}

class _FeedDataState extends State<FeedData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.totalWidth * 1,
      height: widget.totalHeight * 0.72,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: widget.totalHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.totalWidth * 0.04,
                  bottom: widget.totalHeight * 0.005,
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.network(
                          widget.snapshot.data.documents[index]
                              .data["profilePic"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget.totalWidth * 0.02,
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.snapshot.data.documents[index].data["uploader"]}",
                          style: TextStyle(
                            fontSize: widget.totalHeight * 0.023,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " On ${widget.snapshot.data.documents[index].data["uploadingTime"]}",
                          style: TextStyle(
                            fontSize: widget.totalHeight * 0.023,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onDoubleTap: () async {
                  String initialValue =
                      widget.snapshot.data.documents[index].data["reacts"];
                  String docRef =
                      widget.snapshot.data.documents[index].documentID;
                  print(docRef);
                  String result;
                  setState(() {
                    result = "${int.parse(initialValue) + 1}";
                  });
                  await Firestore.instance
                      .collection("images")
                      .document(docRef)
                      .updateData(
                    {
                      "reacts": "$result",
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: widget.totalWidth * 0.04),
                  width: widget.totalWidth * 0.93,
                  height: widget.totalHeight * 0.3,
                  child: Image.network(
                      widget.snapshot.data.documents[index].data["url"],
                      fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.totalWidth * 0.04,
                  top: widget.totalHeight * 0.01,
                ),
                child: Text(
                  "${widget.snapshot.data.documents[index].data["caption"]}",
                  style: TextStyle(
                    fontSize: widget.totalHeight * 0.023,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: widget.totalWidth * 0.04,
                  ),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  Text(
                    " ${widget.snapshot.data.documents[index].data["views"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: widget.totalWidth * 0.5,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.pink[300],
                  ),
                  Text(
                    " ${widget.snapshot.data.documents[index].data["reacts"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
