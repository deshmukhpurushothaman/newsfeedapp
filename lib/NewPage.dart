import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'AllNews.dart';
import './InterviewDashboard.dart';
import 'Application.dart';
import 'contactUs.dart';
import 'Authentication/auth_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final User user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Scaffold(
        key: drawerKey,
        appBar: new AppBar(
          title: new Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black),
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
                  color: Colors.blue.shade100,
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
                // onTap: () {
                //   Navigator.of(context)
                //       .push(new MaterialPageRoute(builder: (context) => Home()));
                // },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Need Internship?"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.computer_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => Application()));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Interview Q&A"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.person_outline, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => InterviewDashboard()));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Government Job"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.grade_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Government Job")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Private Job"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.local_post_office_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Private Job")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Internship"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.work_outline, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Internship")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Walkin"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.directions_walk_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Walkin")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Scholarship"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.school_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Scholarship")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Events"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.event_available_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AllNews("Events")));
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text("Contact Us"),
                //leading: Icon(EvaIcons.edit2Outline),
                leading: new Icon(Icons.contact_phone_outlined, size: 20.0),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => contactus()));
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.tealAccent.shade100,
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.75,
                top: 216,
                child: Container(
                  width: 91,
                  height: 96,
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => AllNews("Scholarship")));
                        },
                        child: Container(
                          width: 91,
                          height: 96,
                          child: Image.asset(
                            "images/scholarship.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                top: 216,
                child: Container(
                  width: 91,
                  height: 96,
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => AllNews("Internship")));
                        },
                        child: Container(
                          width: 91,
                          height: 96,
                          child: Image.asset(
                            "images/internship.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                top: 393,
                child: Container(
                  width: 91,
                  height: 96,
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => Application()));
                        },
                        child: Container(
                          width: 91,
                          height: 96,
                          child: Image.asset(
                            "images/global.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 154,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => InterviewDashboard()));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 39,
                    child: Text(
                      "Interview Q&A",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.38,
                top: 154,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Government Job")));
                  },
                  child: SizedBox(
                    width: 111,
                    height: 39,
                    child: Text(
                      "Government Job",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.75,
                top: 154,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Private Job")));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 39,
                    child: Text(
                      "Private Job",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 322,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Walkin")));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 29,
                    child: Text(
                      "Walkin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.75,
                top: 322,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Scholarship")));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 49,
                    child: Text(
                      "Scholarship",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 500,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Events")));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 29,
                    child: Text(
                      "Events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.38,
                top: 505,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => Application()));
                  },
                  child: SizedBox(
                    width: 111,
                    height: 46,
                    child: Text(
                      "Need Internship?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                top: 322,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Internship")));
                  },
                  child: SizedBox(
                    width: 90,
                    height: 39,
                    child: Text(
                      "Internship",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 43,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => InterviewDashboard()));
                  },
                  child: Container(
                    width: 91,
                    height: 96,
                    child: Image.asset(
                      "images/interview q&a.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                top: 43,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Government Job")));
                  },
                  child: Container(
                    width: 91,
                    height: 96,
                    child: Image.asset(
                      "images/campus drive.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.75,
                top: 43,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Private Job")));
                  },
                  child: Container(
                    width: 91,
                    height: 96,
                    child: Image.asset(
                      "images/off campus drive.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 216,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Walkin")));
                  },
                  child: Container(
                    width: 91,
                    height: 96,
                    child: Image.asset(
                      "images/walkin.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 393,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AllNews("Events")));
                  },
                  child: Container(
                    width: 91,
                    height: 96,
                    child: Image.asset(
                      "images/local.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
