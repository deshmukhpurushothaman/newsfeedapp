import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class LatestPostDetails extends StatefulWidget {
  //LatestPostDetails({Key key}) : super(key: key);
  DocumentSnapshot snapshot;
  LatestPostDetails(this.snapshot);

  @override
  _LatestPostDetailsState createState() => _LatestPostDetailsState();
}

class _LatestPostDetailsState extends State<LatestPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest Post Details"),
        backgroundColor: Colors.orange[300],
      ),
      backgroundColor: Colors.orange,
      body: ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: new Image.network(
                widget.snapshot.data()["image"],
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SizedBox(
            height: 10.0,
          ),
          new Container(
            color: Color(0xFFffd280),
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new CircleAvatar(
                          child: Text(
                            widget.snapshot.data()["title"][0],
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          backgroundColor: Colors.blueGrey),
                      new SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: new Text(
                          widget.snapshot.data()["title"],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 10.0,
                ),
                new Text(
                  widget.snapshot.data()["content"],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
