//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'usersposts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
//import 'users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  final User user = FirebaseAuth.instance.currentUser;

  bool _isloading = false;
  double _progress;
  //final User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
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

  Widget _Nametextfield() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Your name",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _Phonetextfield() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
          labelText: "Phone",
          hintText: "Phone number",
          border: OutlineInputBorder()),
      //maxLines: 18,
    );
  }

  Widget _Emailtextfield() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
          labelText: "Email", hintText: "Email", border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Application",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 5.0),
            _Nametextfield(),
            SizedBox(height: 10.0),
            _Phonetextfield(),
            SizedBox(height: 10.0),
            _Emailtextfield(),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () async {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text);
                    if (_nameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter name!!");
                      return;
                    }
                    if (_phoneController.text.isEmpty ||
                        _phoneController.text.length != 10) {
                      Fluttertoast.showToast(
                          msg: "Please enter phone number correctly!!");
                      return;
                    }
                    if (_emailController.text.isEmpty || !emailValid) {
                      Fluttertoast.showToast(msg: "Please enter Valid Email!!");
                      return;
                    } else {
                      print(_nameController.text);

                      // ignore: deprecated_member_use
                      Firestore.instance
                          .collection('Applications')
                          // ignore: deprecated_member_use
                          .doc()
                          // ignore: deprecated_member_use
                          .set({
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "email": _emailController.text,
                        "posted_on": "${DateTime.now()}",
                        "posted_by": "${user.email}",
                      }).then((value) => Fluttertoast.showToast(
                              msg:
                                  " Thanks for registering. You will receive email regarding commencement of internship."));

                      //Fluttertoast.showToast(msg: " Posted Failure!!");
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
                          Colors.blue[500],
                          Colors.blue[200],
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
