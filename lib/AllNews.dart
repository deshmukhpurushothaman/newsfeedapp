import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './AllNewsDetails.dart';
//import './modal.dart';
import 'dart:async';

class AllNews extends StatefulWidget {
  final String title;
  AllNews(this.title);

  @override
  _AllNewsState createState() => _AllNewsState(title);
}

class _AllNewsState extends State<AllNews> {
  String title;
  _AllNewsState(this.title);
  String experience = "Nil";

  Future getAllPost(String experience) async {
    // ignore: deprecated_member_use

    this.experience = experience;

    if ((experience == 'Experienced') ||
        (experience == 'Fresher') ||
        (experience == 'Both')) {
      //print("Experience askbkabfkbfasdf");
      var firestore = Firestore.instance;
      QuerySnapshot snap =
          // ignore: deprecated_member_use
          await firestore
              .collection("$title")
              .orderBy("posted_on", descending: true)
              .where("experience", isEqualTo: experience)
              .getDocuments();
      // ignore: deprecated_member_use
      return snap.documents;
    } else {
      var firestore = Firestore.instance;
      QuerySnapshot snap =
          // ignore: deprecated_member_use
          await firestore
              .collection("$title")
              .orderBy("posted_on", descending: true)
              //.where("experience", isEqualTo: experience)
              .getDocuments();
      // ignore: deprecated_member_use
      return snap.documents;
    }
  }

  int selectedRadio = 0;
  String selectedRadioTile = "Nil";

  //selectedRadio = 0;
  //selectedRadioTile = 0;

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
      experience = val;
    });
    getAllPost(experience);
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      experience = selectedRadioTile;
      getAllPost(experience);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "${title}",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          if ((title == "Government Job") ||
              (title == "Private Job") ||
              (title == "Internship") ||
              (title == "Walkin"))
            IconButton(
                icon: const Icon(EvaIcons.funnelOutline),
                tooltip: 'Filter',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text('Filter'),
                              content: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RadioListTile<String>(
                                    value: "Experienced",
                                    groupValue: selectedRadioTile,
                                    title: Text("Experienced"),
                                    onChanged: (val) {
                                      print("Radio Tile pressed $val");
                                      Navigator.pop(context);
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.red,
                                    //selected: false,
                                  ),
                                  RadioListTile<String>(
                                    value: "Fresher",
                                    groupValue: selectedRadioTile,
                                    title: Text("Fresher"),
                                    onChanged: (val) {
                                      print("Radio Tile pressed $val");
                                      Navigator.pop(context);
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.red,
                                    //selected: false,
                                  ),
                                  RadioListTile<String>(
                                    value: "Both",
                                    groupValue: selectedRadioTile,
                                    title: Text("Both"),
                                    onChanged: (val) {
                                      print("Radio Tile pressed $val");
                                      Navigator.pop(context);
                                      setSelectedRadioTile(val);
                                    },
                                    activeColor: Colors.red,
                                    //selected: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            String reset = "Nil";
                                            print("Radio Tile pressed $reset");
                                            Navigator.pop(context);
                                            setSelectedRadioTile(reset);
                                          },
                                          color: Colors.blue,
                                          height: 45,
                                          child: Text("Reset",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      });
                })
        ],
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getAllPost(experience),
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
              backgroundColor: Colors.white,
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

                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                    child: Container(
                      height: 170.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        //color: Color(0xFFffd280),
                        color: Colors.blue.shade100,
                      ),
                      margin: EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) =>
                                      AllNews_Details(snapshot.data[index])));
                            },
                            child: Container(
                              width: 150.0,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // child: Image.network(
                                  //   snapshot.data[index].data()["image"],
                                  //   height: 170.0,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  child: FadeInImage.assetNetwork(
                                    image: snapshot.data[index].data()["image"],
                                    height: 170.0,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        'images/${snapshot.data[index].data()["default"]}.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                        snapshot.data[index].data()["title"],
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        snapshot.data[index].data()["content"],
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 5.0,
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
                                                      AllNews_Details(snapshot
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
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontSize: 15.0,
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
