import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllNews_Details extends StatefulWidget {
  //AllNews_Details({Key key}) : super(key: key);

  DocumentSnapshot snapshot;

  AllNews_Details(this.snapshot);

  @override
  _AllNews_DetailsState createState() => _AllNews_DetailsState();
}

class _AllNews_DetailsState extends State<AllNews_Details> {
  @override
  Widget build(BuildContext context) {
    String title = widget.snapshot["default"];
    int length = title.length;
    String titleBar = title.substring(0, length - 1);
    return Scaffold(
      appBar: AppBar(title: Text("${titleBar}"), backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          //First Container
          new Container(
            height: 250.0,
            margin: EdgeInsets.all(6.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                // child: Image.network(
                //   widget.snapshot["image"],
                //   height: 250.0,
                //   fit: BoxFit.cover,
                // ),
                child: FadeInImage.assetNetwork(
                  image: widget.snapshot["image"],
                  height: 250.0,
                  fit: BoxFit.cover,
                  placeholder: 'images/${title}.jpg',
                )),
          ),

          SizedBox(height: 7.0),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color(0xFFffd280),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Card(
              color: Color(0xFFffd280),
              elevation: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new CircleAvatar(
                          child: Text(widget.snapshot["title"][0]),
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Flexible(
                          child: Text(
                            widget.snapshot["title"],
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    child: Text(
                      widget.snapshot["content"],
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
