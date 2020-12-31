import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class InternationsNews_Gallery extends StatefulWidget {
  InternationsNews_Gallery({Key key}) : super(key: key);

  @override
  _InternationsNews_GalleryState createState() =>
      _InternationsNews_GalleryState();
}

class _InternationsNews_GalleryState extends State<InternationsNews_Gallery> {
  Future getAllImage() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap =
        await firestore.collection("ScholarshipAllNews").getDocuments();
    return snap.documents;
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getAllImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getAllImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(6.0),
                      height: 300.0,
                      child: Stack(
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                snapshot.data[index].data()["image"],
                                height: 300.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40.0,
                            left: 30.0,
                            child: Container(
                              height: 50.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFfff6e6),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Scholarship",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ));
          }
        },
      ),
    );
  }
}
