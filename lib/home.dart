import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import 'Authentication/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './View/Campus Drive/CampusDriveAllNews.dart';
import './View/Walkin/WalkinAllNews.dart';
import './View/Off Campus Drive/OffCampusDriveAllNews.dart';
import './View/Internship/InternshipAllNews.dart';
import 'View/Scholarship/ScholarshipAllNews.dart';
import 'DetailsLatestPost.dart';
import 'createpost.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('LatestPost');
  // ignore: deprecated_member_use
  //final FirebaseUser user = FirebaseAuth.instance.currentUser;
  final User user = FirebaseAuth.instance.currentUser;

  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        snapshot = datasnap.documents;
      });
    });
    super.initState();
  }

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Newsfeed",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
      ),
      drawerEdgeDragWidth: 0,
      // drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16),
              ),
              accountEmail: new Text(
                user.email,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              accountName: Text(
                "Welcome!!",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image(
                  image: AssetImage("images/avatar.png"),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Home"),
              leading: Icon(EvaIcons.homeOutline),
              onTap: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Create post"),
              leading: Icon(EvaIcons.edit2Outline),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => createpost()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Logout"),
              leading: Icon(EvaIcons.logOutOutline),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.pop(context);
                AuthHelper.logOut();
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Latest News",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return new Builder(
                  builder: (BuildContext context) {
                    return new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            snapshot[i].data()["image"],
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  LatestPostDetails(snapshot[i])));
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      child: Image.asset(
                        "images/global.png",
                        width: 180,
                        height: 130,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => CampusDriveNews()));
                    },
                  ),
                  InkWell(
                    child: Container(
                      child: Image.asset(
                        "images/sports.png",
                        width: 180,
                        height: 130,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => OffCampusDriveNews()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 33.0),
                      child: Text('Campus Drive',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold))),
                  Container(
                    padding: EdgeInsets.only(left: 80),
                    child: Text(
                      'Off Campus Drive',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      child: Image.asset(
                        "images/politics.png",
                        width: 180,
                        height: 130,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => InternshipNews()));
                    },
                  ),
                  InkWell(
                    child: Container(
                      child: Image.asset(
                        "images/local.png",
                        width: 180,
                        height: 130,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => WalkinNews()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 57.0),
                      child: Text('Internship',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold))),
                  Container(
                    padding: EdgeInsets.only(left: 140.0),
                    child: Text(
                      'Walkin',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      child: Image.asset(
                        "images/politics.png",
                        width: 180,
                        height: 130,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ScholarshipNews()));
                    },
                  ),
                  // InkWell(
                  //   child: Container(
                  //     child: Image.asset(
                  //       "images/local.png",
                  //       width: 180,
                  //       height: 130,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.of(context).push(new MaterialPageRoute(
                  //         builder: (context) => LocalNews()));
                  //   },
                  // ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 57.0),
                      child: Text('Scholarship',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold))),
                  // Container(
                  //   padding: EdgeInsets.only(left: 140.0),
                  //   child: Text(
                  //     'Local',
                  //     style: TextStyle(
                  //         color: Colors.grey,
                  //         fontSize: 17.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
