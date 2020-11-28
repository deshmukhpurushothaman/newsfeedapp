import 'package:fl_fire_auth/Admin/createlatestpost.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'updateuserpost.dart';
import 'dart:async';

class UserPostDetails extends StatefulWidget {
  //LatestPostDetails({Key key}) : super(key: key);
  DocumentSnapshot snapshot;
  UserPostDetails(this.snapshot);

  @override
  _UserPostDetailsState createState() => _UserPostDetailsState();
}

class _UserPostDetailsState extends State<UserPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User News"),
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
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //First Container
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("AdminApproval")
                              .doc(widget.snapshot.documentID)
                              .delete();
                          print("Successful");
                          Fluttertoast.showToast(
                              msg:
                                  "Deleted Successfully!!! Refresh the page to see the changes.");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFfff6e6),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Second Container(Delete Post)
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("SuperAdminApproval")
                              // ignore: deprecated_member_use
                              .document()
                              // ignore: deprecated_member_use
                              .setData({
                            "content": widget.snapshot.data()['content'],
                            "title": widget.snapshot.data()['title'],
                            "image": widget.snapshot.data()['image'],
                            "categoryval": widget.snapshot.data()['categoryval']
                          });
                          print("Successful");

                          //Delete
                          FirebaseFirestore.instance
                              .collection("AdminApproval")
                              .doc(widget.snapshot.documentID)
                              .delete();
                          print("Successful");
                          Fluttertoast.showToast(
                              msg: "News approved for Super Admin View");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFfff6e6),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Approve",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Third Container
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("RejectedNews")
                              // ignore: deprecated_member_use
                              .document()
                              // ignore: deprecated_member_use
                              .setData({
                            "content": widget.snapshot.data()['content'],
                            "title": widget.snapshot.data()['title'],
                            "image": widget.snapshot.data()['image'],
                            "categoryval": widget.snapshot.data()['categoryval']
                          });
                          print("Successful");

                          //Delete
                          FirebaseFirestore.instance
                              .collection("AdminApproval")
                              .doc(widget.snapshot.documentID)
                              .delete();
                          print("Successful");
                          Fluttertoast.showToast(msg: "News Rejected");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFfff6e6),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
