//import 'dart:html';

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import './createpost.dart';
import 'package:fl_fire_auth/Super%20Admin/Deleted%20News/Events/DeletedEventsAllNews.dart';
//import 'package:fl_fire_auth/Admin/Events/EventsAllNews.dart';
import 'package:fl_fire_auth/Super%20Admin/Deleted%20News/ScholarshipNews/DeletedScholarshipAllNews.dart';
import './Deleted News/Govt Job/DeletedGovtJobAllNews.dart';
import 'View/LatestNews/AdminLatestAllNews.dart';
import '../Authentication/auth_helper.dart';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_pro/carousel_pro.dart';
import './View/Govt Job/GovtJobAllNews.dart';
import 'View/LatestNews/AdminLatestAllNews.dart';
import 'View/Non Govt Job/NonGovtJobAllNews.dart';
import 'View/Walkin/WalkinAllNews.dart';
import './View/Internship/InternshipAllNews.dart';
import './View/Non Govt Job/NonGovtJobAllNews.dart';
import 'View/ScholarshipNews/AdminScholarshipAllNews.dart';
import 'View/Events/EventsAllNews.dart';
import 'AdminDetailsLatestPost.dart';
import './Deleted News/Walkin/DeletedWalkinAllNews.dart';
import './Deleted News/Internship/DeletedInternshipAllNews.dart';
import './Deleted News/Non Govt Job/DeletedNonGovtJobAllNews.dart';
import 'Deleted News/LatestNews/DeletedLatestAllNews.dart';
import 'dart:async';
import './users.dart';
import './AdminUsers.dart';
import './interviewForm.dart';
import './Interview Q&A/InterviewDashboard.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // ignore: cancel_subscriptions

  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('LatestPost');
  final User user = FirebaseAuth.instance.currentUser;

  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        // ignore: deprecated_member_use
        snapshot = datasnap.documents;
      });
    });
    super.initState();
    print("User loggedin " + user.email);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "News Portal(Super Admin)",
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
                accountEmail: new Text("Signed In as " + user.email),
                accountName: null,
                decoration: new BoxDecoration(color: Colors.orange),
              ),
              new ListTile(
                title: new Text(
                  "Create New Post",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => createpost()));
                },
                leading:
                    new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Create Interview Q&A",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => interviewForm()));
                },
                leading:
                    new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              ),

              new ListTile(
                title: new Text(
                  "Interview Q&A",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => InterviewDashboard()));
                },
                leading:
                    new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Government Job",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => GovtJob()));
                },
                leading:
                    new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Private Job",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => NonGovtJob()));
                },
                leading:
                    new Icon(Icons.security, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Internship",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => Internship()));
                },
                leading: new Icon(Icons.image, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Walkin",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Walkin()));
                },
                leading: new Icon(Icons.adb, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Scholarship",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ScholarshipNews()));
                },
                leading: new Icon(Icons.adb, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Events",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Events()));
                },
                leading: new Icon(Icons.adb, color: Colors.black, size: 20.0),
              ),
              // new ListTile(
              //   title: new Text(
              //     "User News",
              //     style: TextStyle(fontSize: 20.0, color: Colors.black),
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.of(context).push(
              //         new MaterialPageRoute(builder: (context) => UserPosts()));
              //   },
              //   leading:
              //       new Icon(Icons.next_week, color: Colors.black, size: 20.0),
              // ),
              new ListTile(
                title: new Text(
                  "Users",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => UsersPage()));
                },
                leading:
                    new Icon(Icons.person, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Admins",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AdminUsersPage()));
                },
                leading: new Icon(Icons.admin_panel_settings,
                    color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Latest News",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedLatestNews()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Government Job",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedGovtJob()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Internship",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedInternship()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Walkin",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedWalkin()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Scholarship",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedScholarshipNews()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Private Job",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedNonGovtJob()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
              ),
              new ListTile(
                title: new Text(
                  "Deleted Events",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DeletedEvents()));
                },
                leading:
                    new Icon(Icons.delete, color: Colors.black, size: 20.0),
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => LatestPostDetails(
                                            snapshot[index])));
                              },
                              child: Container(
                                width: 150.0,
                                child: new Expanded(
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
                                        builder: (context) => GovtJob()));
                              },
                              child: Text(
                                "Government Job",
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
                                        builder: (context) => NonGovtJob()));
                              },
                              child: Text(
                                "Private Job",
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
                                        builder: (context) => Walkin()));
                              },
                              child: Text(
                                "Walkin",
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
                                        builder: (context) => Internship()));
                              },
                              child: Text(
                                "Internship",
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
                                        builder: (context) =>
                                            ScholarshipNews()));
                              },
                              child: Text(
                                "Scholarship",
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
                                        builder: (context) => Events()));
                              },
                              child: Text(
                                "Events",
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
