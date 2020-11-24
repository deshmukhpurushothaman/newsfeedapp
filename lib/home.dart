import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fl_fire_auth/Admin/createpost.dart';

import 'Authentication/auth_helper.dart';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'Controller/InternationalNews.dart';
import 'Controller/LocalNews.dart';
import 'Controller/SportsNews.dart';
import 'Controller/PoliticsNews.dart';
import 'DetailsLatestPost.dart';
import 'createpost.dart';
import 'dart:async';

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('LatestPost');

  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        // ignore: deprecated_member_use
        snapshot = datasnap.documents;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "News Portal",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: new Drawer(
        child: Container(
          color: Color(0xffffd280),
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  "News Portal App",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: null,
                decoration: new BoxDecoration(color: Colors.orange),
              ),
              new ListTile(
                title: new Text(
                  "International News",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => InternationalNews()));
                },
                leading:
                    new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Sports News",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => SportsNews()));
                },
                leading:
                    new Icon(Icons.security, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Local News",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => LocalNews()));
                },
                leading: new Icon(Icons.image, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Political News",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => PoliticsNews()));
                },
                leading: new Icon(Icons.adb, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Logout",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  AuthHelper.logOut();
                },
                leading:
                    new Icon(Icons.logout, color: Colors.black, size: 20.0),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.orange,
      body: new ListView(
        children: <Widget>[
          //First Container Start

          new Container(
            height: 230,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Latest Post",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                new SizedBox(
                  height: 5.0,
                ),
                new Container(
                  height: 165.0,
                  margin: EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300.0,
                        color: Color(0xFFffd280),
                        margin: EdgeInsets.only(left: 10.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: new Image.network(
                                  snapshot[index].data()["image"],
                                  fit: BoxFit.cover,
                                  height: 165.0,
                                ),
                              ),
                            ),
                            new SizedBox(
                              width: 10.0,
                            ),
                            new Expanded(
                              flex: 2,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  LatestPostDetails(
                                                      snapshot[index])));
                                    },
                                    child: new Text(
                                      snapshot[index].data()["title"],
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 8.0,
                                  ),
                                  new Text(
                                    snapshot[index].data()["content"],
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                  ),
                                  new SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          new SizedBox(
            height: 7.0,
          ),

          //Carousal Slider

          new SizedBox(
            height: 7.0,
          ),
          //Third Container
          Container(
            margin: EdgeInsets.all(10.0),
            height: 300.0,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd280),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            InternationalNews()));
                              },
                              child: Text(
                                "International News",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd280),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => SportsNews()));
                              },
                              child: Text(
                                "Sports News",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd280),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => LocalNews()));
                              },
                              child: Text(
                                "Local News",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd280),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => PoliticsNews()));
                              },
                              child: Text(
                                "Politics News",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Sign Out
                    ],
                  ),
                ),
                new SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFffd280),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => createpost()));
                              },
                              child: Text(
                                "Need to Create a Post?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Sign Out
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
