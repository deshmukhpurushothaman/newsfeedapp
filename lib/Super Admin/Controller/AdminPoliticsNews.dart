import 'package:flutter/material.dart';
import '../View/PoliticsNews/AdminPoliticsAllNews.dart' as allnews;
import '../View/PoliticsNews/AdminPoliticsNews_Gallery.dart' as gallery;

class PoliticsNews extends StatefulWidget {
  PoliticsNews({Key key}) : super(key: key);

  @override
  _PoliticsNewsState createState() => _PoliticsNewsState();
}

class _PoliticsNewsState extends State<PoliticsNews>
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
          "Politics News",
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
              text: "Politics News",
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
          allnews.PoliticsNews(),
          gallery.PoliticsNews_Gallery(),
        ],
      ),
    );
  }
}
