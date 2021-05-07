//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Authentication/auth_helper.dart';
import './View/LatestNews/AdminLatestAllNews.dart';
import './View/Govt Job/GovtJobAllNews.dart';
import './View/Walkin/WalkinAllNews.dart';
import './View/Internship/InternshipAllNews.dart';
import './View/Non Govt Job/NonGovtJobAllNews.dart';
import './View/ScholarshipNews/AdminScholarshipAllNews.dart';
import './View/Events/EventsAllNews.dart';
//import 'usersposts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_radio_button/group_radio_button.dart';

class interviewForm extends StatefulWidget {
  @override
  _interviewFormState createState() => _interviewFormState();
}

class _interviewFormState extends State<interviewForm> {
  TextEditingController _questionController;
  TextEditingController _answerController;
  TextEditingController _urlController;

  String _domainVal;
  String _postType;
  String _url;

  bool _isloading = false;
  double _progress;
  final User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: "");
    _answerController = TextEditingController(text: "");
    _urlController = TextEditingController(text: "");
  }

  progress(loading) {
    if (loading) {
      return Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.red,
          ),
          Text('${(_progress * 100).toStringAsFixed(2)} %'),
        ],
      );
    } else {
      return Text('Nothing');
    }
  }

  Widget _Questiontextfield() {
    return TextField(
      controller: _questionController,
      decoration: InputDecoration(
          labelText: "Question",
          hintText: "Enter the question here...",
          border: OutlineInputBorder()),
    );
  }

  Widget _Answertextfield() {
    return TextField(
      controller: _answerController,
      decoration: InputDecoration(
          labelText: "Answer",
          hintText: "Enter the answer here...",
          border: OutlineInputBorder()),
      maxLines: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Interview Post",
            style: TextStyle(color: Colors.grey[800]),
          ),
          backgroundColor: Colors.orange,
          iconTheme: new IconThemeData(color: Colors.grey[800]),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 5.0),
            _Questiontextfield(),
            SizedBox(height: 10.0),
            DropdownButton(
              hint: _domainVal == null
                  ? Text('Domain category')
                  : Text(
                      _domainVal,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.orange),
              items: [
                "Software Testing",
                "Dot Net",
                "Python",
                "Java",
                "React JS",
                "C++",
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _domainVal = val;
                  },
                );
              },
            ),
            SizedBox(height: 10.0),
            _Answertextfield(),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () async {
                    if (_questionController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter the Question!!!");
                      return;
                    }
                    if (_domainVal == null) {
                      Fluttertoast.showToast(
                          msg: "Please select the domain!!!");
                      return;
                    }
                    // if (_urlController.text.isEmpty) {
                    //   Fluttertoast.showToast(
                    //       msg: "Please enter or paste url!!");
                    //   return;
                    // }
                    if (_answerController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter answer!!!");
                      return;
                    } else {
                      print(_answerController.text);

                      // ignore: deprecated_member_use
                      Firestore.instance
                          .collection(_domainVal)
                          // ignore: deprecated_member_use
                          .document()
                          // ignore: deprecated_member_use
                          .setData({
                        "question": _questionController.text,
                        "answer": _answerController.text,
                        "posted_on": "${DateTime.now()}",
                        "posted_by": "${user.email}",
                      });

                      Fluttertoast.showToast(
                          msg: _domainVal + " Q&A posted Successfully!!");
                      //Navigator.pop(context);
                      return;
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange[500],
                          Colors.orange[200],
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: Text("SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
