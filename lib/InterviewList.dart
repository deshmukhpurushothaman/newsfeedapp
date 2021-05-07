import 'package:flutter/material.dart';
import 'InterviewPost_Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterviewList extends StatefulWidget {
  final String title;
  InterviewList(this.title);
  @override
  _InterviewListState createState() => _InterviewListState(title);
}

class _InterviewListState extends State<InterviewList> {
  String title;
  _InterviewListState(this.title);
  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore
        .collection("$title")
        .orderBy("posted_on", descending: true)
        .getDocuments();
    return snap.documents;
  }

  // List<String> Names = [
  //   'What are the supported platforms by Java Programming Language?',
  //   'What is Java Virtual Machine and how it is considered in context of Java’s platform independent feature?',
  //   'List some Java keywords(unlike C, C++ keywords)?',
  //   'According to Java Operator precedence, which operator is considered to be with highest precedence?',
  //   'Which package is used for pattern matching with regular expressions?',
  //   'What things should be kept in mind while creating your own exceptions in Java?',
  //   'What are the two ways in which Thread can be created?',
  //   'What is the difference between object oriented programming language and object based programming language?',
  //   'What are the ways in which a thread can enter the waiting state?',
  //   'Which class should you use to obtain design information about an object?',
  //   'Can you call one constructor from another if a class has multiple constructors?',
  //   'What is the difference between a break statement and a continue statement?'
  //   'If a variable is declared as private, where may the variable be accessed?',
  // ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          '$title',
          style: TextStyle(
              color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.bold),
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
      body: new Container(
        child: FutureBuilder(
          future: getData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading...."),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data[index].data()['question'],
                          maxLines: 2,
                        ),
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  InterviewPost_Details(snapshot.data[index])));
                        },
                      ),
                    );
                  });
            }
          },
        ),
        // child: new ListView.builder(
        //   reverse: false,
        //   itemBuilder: (_, int index) => EachList(this.Names[index]),
        //   itemCount: this.Names.length,
        // ),
      ),
    );
  }
}

// class EachList extends StatelessWidget {
//   final String name;
//   EachList(this.name);
//   @override
//   Widget build(BuildContext context) {
//     return new Card(
//       child: new Container(
//         padding: EdgeInsets.all(8.0),
//         child: new Row(
//           children: <Widget>[
//             new CircleAvatar(
//               backgroundColor: const Color(0xFF63a4ff),
//               radius: 18.0,
//               child: new Text(
//                 name[0],
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             new Padding(padding: EdgeInsets.only(right: 10.0)),
//             new Text(
//               name,
//               style: TextStyle(fontSize: 15.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
