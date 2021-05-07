import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'InterviewList.dart';
import 'AllPost.dart';

class InterviewDashboard extends StatelessWidget {
  List<String> domains = [
    "Software Testing",
    "Dot Net",
    "Python",
    "Java",
    "React JS",
    "C++",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Interview Preparation',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF83eaf1),
                  const Color(0xFF63a4ff),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              const Color(0xFFd7e1ec),
              const Color(0xFFffffff),
            ]),
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage("images/python.png"), fit: BoxFit.cover),
          // ),
          child: Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: domains.map((title) {
                return GestureDetector(
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: getCardByTitle(title),
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: title + " click",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllPost('$title')),
                    );
                  },
                );
              }).toList(),
            ),
          )),
    );
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Python")
      img = "images/python.png";
    else if (title == "Java")
      img = "images/java.png";
    else if (title == "Software Testing")
      img = "images/softwaretesting.png";
    else if (title == "React JS")
      img = "images/react.png";
    else if (title == "C++")
      img = "images/cplus.png";
    else if (title == "Dot Net")
      img = "images/dotnet.png";
    else
      img = "images/java.png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: new Stack(
            children: <Widget>[
              new Image.asset(
                img,
                width: 80.0,
                height: 80.0,
              )
            ],
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
