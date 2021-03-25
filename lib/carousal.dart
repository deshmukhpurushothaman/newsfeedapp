import 'package:firebase_auth/firebase_auth.dart';

import './Detail.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import './View/Campus Drive/CampusDriveAllNews.dart';
import './View/Walkin/WalkinAllNews.dart';
import './View/Off Campus Drive/OffCampusDriveAllNews.dart';
import './View/Internship/InternshipAllNews.dart';
import 'View/Scholarship/ScholarshipAllNews.dart';
import "View/Events/EventsAllNews.dart";
import 'contactUs.dart';
import 'AllNews.dart';
import 'Authentication/auth_helper.dart';

final imagesList = [
  "images/campus drive.jpg",
  "images/off campus drive.png",
  "images/internship.png",
  "images/walkin.png",
  "images/scholarship.png",
  "images/local.png",
];

final colorList = [
  Colors.greenAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.yellowAccent.shade50,
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.amber.shade50
];

class CityExplorerPage extends StatefulWidget {
  @override
  _CityExplorerPageState createState() => _CityExplorerPageState();
}

class _CityExplorerPageState extends State<CityExplorerPage> {
  int currentPage = 0;
  PageController _pageController;
  final User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CampusVita",
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
              // onTap: () {
              //   Navigator.of(context)
              //       .push(new MaterialPageRoute(builder: (context) => Home()));
              // },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Campus Drive"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.grade_outlined, size: 20.0),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => CampusDriveNews()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Off Campus Drive"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.local_post_office_outlined, size: 20.0),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => OffCampusDriveNews()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Internship"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.work_outline, size: 20.0),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => InternshipNews()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Walk-in"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.directions_walk_outlined, size: 20.0),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => WalkinNews()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Scholarship"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.school_outlined, size: 20.0),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => ScholarshipNews()));
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Events"),
              //leading: Icon(EvaIcons.edit2Outline),
              leading: new Icon(Icons.event_available_outlined, size: 20.0),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => EventsNews()));
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
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: colorList[currentPage],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return itemBuilder(index);
                  },
                  controller: _pageController,
                  pageSnapping: true,
                  onPageChanged: _onPageChanged,
                  itemCount: 6,
                  physics: ClampingScrollPhysics(),
                ),
              ),
              _detailsBuilder(currentPage),
            ],
          )
        ],
      ),
    );
  }

  Widget _detailsBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }

        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 100 + (-value * 100)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      detailsList[index].title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      detailsList[index].description,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 80.0,
                      height: 5.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    // ignore: missing_required_param
                    FlatButton(
                      child: Text(
                        "Read More",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                AllNews(detailsList[index].title)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                height: Curves.easeIn.transform(value) * 600,
                child: child,
              ));
        } else {
          return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                height:
                    Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                        600,
                child: child,
              ));
        }
      },
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            child: InkWell(
              child: Container(
                width: 500.0,
                child: Image.asset(
                  imagesList[index],
                  fit: BoxFit.fitHeight,
                  height: 400.0,
                  width: 1000.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => AllNews(detailsList[index].title)));
              },
            ),
          ),
        ),
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      print(index);
      currentPage = index;
      print("Page $currentPage");
    });
  }
}
