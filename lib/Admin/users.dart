import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'AdminUserdetails.dart';
import 'dart:async';

class UsersPage extends StatefulWidget {
  UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Future getAllPost() async {
    // ignore: deprecated_member_use
    var firestore = Firestore.instance;
    QuerySnapshot snap =
        // ignore: deprecated_member_use
        await firestore.collection("users").getDocuments();
    // ignore: deprecated_member_use
    return snap.documents;
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getAllPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Users",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.orange,
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
                    // ]
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.blueGrey,
                        icon: Icons.delete,
                        onTap: () => {
                          print("Entered"),
                          //Copy to new Deleted Collection
                          FirebaseFirestore.instance
                              .collection("Deletedusers")
                              // ignore: deprecated_member_use
                              .document()
                              // ignore: deprecated_member_use
                              .setData({
                            "content": snapshot.data[index].data()['content'],
                            "title": snapshot.data[index].data()['title'],
                            "image": snapshot.data[index].data()['image'],
                            "category": "InternationalAllNews",
                          }),
                          print("Successful"),

                          //Delete
                          FirebaseFirestore.instance
                              .collection("users")
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
                    //       .collection("users")
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
                        color: Color(0xFFffd280),
                      ),
                      margin: EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          // Expanded(
                          //   flex: 1,
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(15.0),
                          //     child: Image.network(
                          //       snapshot.data[index].data()["image"],
                          //       height: 170.0,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          new SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                //First Container
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].data()["email"],
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
                                      InkWell(
                                        // onTap: () {
                                        //   Navigator.of(context).push(
                                        //       new MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               Admindetails(snapshot
                                        //                   .data[index])));
                                        // },
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
                                                "View User",
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
