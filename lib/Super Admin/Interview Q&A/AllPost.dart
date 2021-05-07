//import './EventsNews_Postdetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './updateInterviewpost.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//import 'AdminEvents_PostDetails.dart';
import 'dart:async';
import 'AllPost_Details.dart';

class AllPost extends StatefulWidget {
  final String title;
  AllPost(this.title);

  @override
  _AllPostState createState() => _AllPostState(title);
}

class _AllPostState extends State<AllPost> {
  String title;
  _AllPostState(this.title);
  //String experience = "Both";
  Future getAllPost() async {
    //this.experience = experience;
    // ignore: deprecated_member_use
    print("React JS All Post");
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot snap =
        // ignore: deprecated_member_use
        await firestore
            .collection("$title")
            .orderBy("posted_on", descending: true)
            //.where("experience", isEqualTo: experience)
            .get();
    // ignore: deprecated_member_use
    print(snap.docs);
    return snap.docs;
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      //experience = selectedRadioTile;
      getAllPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Interview Q&A",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "Data Loading...",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: onRefresh,
              backgroundColor: Colors.green,
              color: Colors.black,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    // actions: [
                    //   IconSlideAction(
                    //     caption: 'Archive',
                    //     color: Colors.deepOrange,
                    //     icon: Icons.archive,
                    //   ),
                    // ],
                    // secondaryActions: [
                    //   IconSlideAction(
                    //     caption: 'Delete',
                    //     color: Colors.blueGrey,
                    //     icon: Icons.delete,
                    //   ),
                    // ],
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.blueGrey,
                        icon: Icons.delete,
                        onTap: () => {
                          print("Entered"),
                          //Copy to new Deleted Collection
                          FirebaseFirestore.instance
                              .collection("Deleted$title")
                              // ignore: deprecated_member_use
                              .doc()
                              // ignore: deprecated_member_use
                              .set({
                            "question": snapshot.data[index].data()['question'],
                            "answer": snapshot.data[index].data()['answer'],
                            "posted_on":
                                snapshot.data[index].data()['posted_on'],
                            "posted_by":
                                snapshot.data[index].data()['posted_by'],
                            "updated_on":
                                snapshot.data[index].data()['updated_on'],
                            "updated_by":
                                snapshot.data[index].data()['updated_by']
                          }),
                          print("Successful"),

                          //Delete
                          FirebaseFirestore.instance
                              .collection("$title")
                              .doc(snapshot.data[index].documentID)
                              .delete(),
                          print("Successful"),
                          Fluttertoast.showToast(
                              msg:
                                  "Deleted Successfully!!! Refresh the page to see the changes."),
                        },
                      ),
                    ],
                    // onDismissed: (DismissDirection) {
                    //   //snapshot.data.delete(index);
                    //   print("Entered");
                    //   FirebaseFirestore.instance
                    //       .collection("LocalAllNews")
                    //       .doc(snapshot.data[index].documentID)
                    //       .delete();
                    //   print("Successful");
                    // },

                    // dismissal: SlidableDismissal(
                    //   child: SlidableDrawerDismissal(),
                    // ),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blueAccent.shade100,
                      ),
                      margin: EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          // InkWell(
                          //   // onTap: () {
                          //   //   Navigator.of(context).push(new MaterialPageRoute(
                          //   //       builder: (context) => Events_PostDetails(
                          //   //           snapshot.data[index])));
                          //   // },
                          //   child: Container(
                          //     width: 150.0,
                          //     child: Container(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(15.0),
                          //         // child: Image.network(
                          //         //   snapshot.data[index].data()["image"],
                          //         //   height: 170.0,
                          //         //   fit: BoxFit.cover,
                          //         // ),
                          //         child: FadeInImage.assetNetwork(
                          //           image: snapshot.data[index].data()["image"],
                          //           height: 170.0,
                          //           fit: BoxFit.cover,
                          //           placeholder:
                          //               'images/${snapshot.data[index].data()["default"]}.jpg',
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // new SizedBox(
                          //   width: 5.0,
                          // ),

                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                //First Container
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].data()["question"],
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      // Text(
                                      //   snapshot.data[index].data()["content"],
                                      //   maxLines: 4,
                                      //   style: TextStyle(
                                      //     fontSize: 15.0,
                                      //     color: Colors.black,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20.0,
                                ),

                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //First Container

                                      //Second Container
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllPost_Details(snapshot
                                                          .data[index])));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Color(0xFFfff6e6),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      updateInterviewpost(
                                                          snapshot
                                                              .data[index])));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: 10.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Color(0xFFfff6e6),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Update",
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
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
