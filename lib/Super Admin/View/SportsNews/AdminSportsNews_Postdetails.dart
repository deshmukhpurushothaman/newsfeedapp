import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SportsNews_PostDetails extends StatefulWidget {
  //Spo_PostDetails({Key key}) : super(key: key);

  DocumentSnapshot snapshot;

  SportsNews_PostDetails(this.snapshot);

  @override
  _SportsNews_PostDetailsState createState() => _SportsNews_PostDetailsState();
}

class _SportsNews_PostDetailsState extends State<SportsNews_PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Sports News"), backgroundColor: Colors.orange),
      backgroundColor: Colors.orange,
      body: ListView(
        children: [
          //First Container
          new Container(
            height: 250.0,
            margin: EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.snapshot["image"],
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
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
                        Text(
                          widget.snapshot["title"],
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
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
