//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Authentication/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'users.dart';

File image;
String filename;

class createpoliticspost extends StatefulWidget {
  @override
  _createpoliticspostState createState() => _createpoliticspostState();
}

class _createpoliticspostState extends State<createpoliticspost> {
  TextEditingController _titleController;
  TextEditingController _postcontentController;

  String _categoryVal;
  String _postType;
  bool isSwitched = false;
  String imageurl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: "");
    _postcontentController = TextEditingController(text: "");
  }

  Future _getImage() async {
    var selectedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = selectedImage;
      filename = basename(image.path);
    });
  }

  Future<String> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filename);

    UploadTask uploadTask = ref.putFile(image);
    // uploadTask.then((res) {
    //   var url = res.ref.getDownloadURL();
    //   print("Download: $url");

    //   return url;
    // });

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      var x = 2;
      // return ( x);
    });

    final String url = (await taskSnapshot.ref.getDownloadURL());
    print('URL Is $url');

    // var downUrl = await (await uploadTask.whenComplete(() => {
    //   ref.getDownloadURL();
    // }));

    // var url = downUrl.toString();
    // print("Download: $url");
    imageurl = url;
    Fluttertoast.showToast(msg: imageurl);
    return url;

    // StorageReference reference = FirebaseStorage.instance.ref().child(filename);
    // reference.putFile(image);

    // return "";
  }

  Widget uploadArea() {
    return Column(
      children: <Widget>[
        Image.file(image, width: double.infinity),
        RaisedButton(
          color: Colors.orange,
          child: Text("Upload"),
          onPressed: () {
            uploadImage();
          },
        ),
      ],
    );
  }

  Widget _Titletextfield() {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
          labelText: "Title",
          hintText: "Type post title here....",
          border: OutlineInputBorder()),
    );
  }

  Widget _contenttextfield() {
    return TextField(
      controller: _postcontentController,
      decoration: InputDecoration(
          labelText: "Post content",
          hintText: "Type post content here....",
          border: OutlineInputBorder()),
      maxLines: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Create Politics Post",
            style: TextStyle(color: Colors.grey[800]),
          ),
          backgroundColor: Colors.orange,
          iconTheme: new IconThemeData(color: Colors.grey[800]),
        ),
        drawer: new Drawer(
          child: Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text(
                    "News Portal App (Admin)",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
                  ),
                  accountEmail: null,
                  decoration: new BoxDecoration(color: Colors.orangeAccent),
                ),
                // new ListTile(
                //   title: new Text(
                //     "Users",
                //     style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.of(context).push(new MaterialPageRoute(
                //         builder: (context) => UsersPage()));
                //   },
                //   leading: new Icon(Icons.person,
                //       color: Colors.grey[800], size: 20.0),
                // ),
                new ListTile(
                  title: new Text(
                    "Logout",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    AuthHelper.logOut();
                  },
                  leading: new Icon(Icons.logout,
                      color: Colors.grey[800], size: 20.0),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 5.0),
            _Titletextfield(),
            SizedBox(height: 10.0),
            SwitchListTile(
              value: isSwitched,
              activeColor: Colors.orange,
              secondary: new Icon(Icons.post_add),
              title: new Text("Politics Post"),
              onChanged: (value) {
                print("Value: $value");
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            SizedBox(height: 10.0),
            // DropdownButton(
            //   hint: _categoryVal == null
            //       ? Text('Post category')
            //       : Text(
            //           _categoryVal,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //   isExpanded: true,
            //   iconSize: 30.0,
            //   style: TextStyle(color: Colors.orange),
            //   items: [
            //     "InternationalAllNews",
            //     "PoliticsAllNews",
            //     "SportsAllNews",
            //     "LocalAllNews"
            //   ].map(
            //     (val) {
            //       return DropdownMenuItem<String>(
            //         value: val,
            //         child: Text(val),
            //       );
            //     },
            //   ).toList(),
            //   onChanged: (val) {
            //     setState(
            //       () {
            //         _categoryVal = val;
            //       },
            //     );
            //   },
            // ),
            SizedBox(height: 10.0),
            _contenttextfield(),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  image == null ? Text("Select an image") : uploadArea(),
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.orange[200],
                    child: Icon(Icons.image),
                    onPressed: _getImage,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () async {
                    if (_titleController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter title!!");
                      return;
                    }
                    if (_categoryVal == null) {
                      Fluttertoast.showToast(
                          msg: "Please select post category!!");
                      return;
                    }
                    if (_postcontentController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter post content!!");
                      return;
                    } else {
                      print(_postcontentController.text);

                      if (isSwitched == true) {
                        // ignore: deprecated_member_use
                        Firestore.instance
                            .collection("PoliticsAllNews")
                            // ignore: deprecated_member_use
                            .document()
                            // ignore: deprecated_member_use
                            .setData({
                          "content": _postcontentController.text,
                          "title": _titleController.text,
                          "image": imageurl
                        });

                        Fluttertoast.showToast(
                            msg: "Latestpost Posted Successfully!!");
                        return;
                      } else {
                        // ignore: deprecated_member_use
                        Firestore.instance
                            .collection(_categoryVal)
                            // ignore: deprecated_member_use
                            .document()
                            // ignore: deprecated_member_use
                            .setData({
                          "content": _postcontentController.text,
                          "title": _titleController.text,
                          "image": imageurl
                        });

                        Fluttertoast.showToast(
                            msg: _categoryVal + " Posted Successfully!!");
                        return;
                      }
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
