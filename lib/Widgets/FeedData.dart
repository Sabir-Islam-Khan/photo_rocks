import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  bool _imageLoading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.totalWidth * 1,
      height: widget.totalHeight * 0.86,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: false,
          height: MediaQuery.of(context).size.height,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
          initialPage: 0,
          scrollDirection: Axis.vertical,
        ),
        itemCount: widget.snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) {
          var image = widget.snapshot.data.documents[index].data["url"];
          print(image);
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

                  await Firestore.instance
                      .collection("images")
                      .document(docRef)
                      .updateData(
                    {
                      "reacts": "$result",
                    },
                  );
                  setState(() {
                    result = "${int.parse(initialValue) + 1}";
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: widget.totalWidth * 0.01,
                    right: widget.totalWidth * 0.01,
                  ),
                  width: widget.totalWidth * 0.99,
                  height: widget.totalHeight * 0.7,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/gifs/progress.gif',
                    image: widget.snapshot.data.documents[index].data['url'],
                  ),
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
                    color: Colors.pink[500],
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
