import 'package:flutter/material.dart';
import '../View/SportsNews/AdminSportsAllNews.dart' as allnews;
import '../View/SportsNews/AdminSportsNews_Gallery.dart' as gallery;

class SportsNews extends StatefulWidget {
  SportsNews({Key key}) : super(key: key);

  @override
  _SportsNewsState createState() => _SportsNewsState();
}

class _SportsNewsState extends State<SportsNews>
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
          "Sports News",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        iconTheme: new IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.blueGrey,
          indicatorWeight: 5.0,
          labelColor: Colors.black,
          tabs: <Widget>[
            new Tab(
              icon: Icon(Icons.view_headline),
              text: "Sports News",
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
          allnews.SportsNews(),
          gallery.SportsNews_Gallery(),
        ],
      ),
    );
  }
}
