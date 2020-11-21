import 'package:flutter/material.dart';
import '../View/InternationalNews/AdminInternationalAllNews.dart' as allnews;
import '../View/InternationalNews/AdminInternationalNews_Gallery.dart'
    as gallery;

class InternationalNews extends StatefulWidget {
  InternationalNews({Key key}) : super(key: key);

  @override
  _InternationalNewsState createState() => _InternationalNewsState();
}

class _InternationalNewsState extends State<InternationalNews>
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
          "International News",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.blueGrey,
          indicatorWeight: 5.0,
          labelColor: Colors.black,
          tabs: <Widget>[
            new Tab(
              icon: Icon(Icons.view_headline),
              text: "International News",
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
          allnews.InternationalNews(),
          gallery.InternationsNews_Gallery(),
        ],
      ),
    );
  }
}
