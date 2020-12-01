import 'package:flutter/material.dart';
import '../View/LocalNews/LocalAllNews.dart' as allnews;
import '../View/LocalNews/LocalNews_Gallery.dart' as gallery;

class LocalNews extends StatefulWidget {
  LocalNews({Key key}) : super(key: key);

  @override
  _LocalNewsState createState() => _LocalNewsState();
}

class _LocalNewsState extends State<LocalNews>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Local News",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.blueGrey,
          indicatorWeight: 5.0,
          labelColor: Colors.black,
          tabs: <Widget>[
            new Tab(
              icon: Icon(Icons.view_headline),
              text: "Local News",
            ),
            new Tab(
              icon: Icon(Icons.image),
              text: "Gallery",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          allnews.LocalNews(),
          gallery.LocalNews_Gallery(),
        ],
      ),
    );
  }
}
