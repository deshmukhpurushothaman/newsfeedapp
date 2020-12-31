import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Authentication/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
//import 'users.dart';
//import 'InternationalNews/InternationalAllNews.dart';

class updatelocalpost extends StatefulWidget {
  DocumentSnapshot snapshot;
  updatelocalpost(this.snapshot);
  @override
  _updatelocalpostState createState() => _updatelocalpostState();
}

class _updatelocalpostState extends State<updatelocalpost> {
  TextEditingController _titleController;
  TextEditingController _postcontentController;

  String _categoryVal;
  String _postType;
  String imageurl;
  File image;
  String filename;
  bool _isloading = false;
  double _progress;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.snapshot['title']);
    _postcontentController =
        TextEditingController(text: widget.snapshot['content']);
    //image = File(widget.snapshot['image']);
    imageurl = widget.snapshot['image'];
  }

  getImage(source) async {
    var selectedimage = await ImagePicker.pickImage(
      source: source,
    );
    File croppedFile =
        await ImageCropper.cropImage(sourcePath: selectedimage.path);

    setState(() {
      image = croppedFile;
      filename = basename(image.path);
    });
  }

  // Future _getImage() async {
  //   var selectedImage =
  //       await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     image = selectedImage;
  //     filename = basename(image.path);
  //   });
  // }

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

  Future<String> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filename);

    UploadTask uploadTask = ref.putFile(image);

    Fluttertoast.showToast(msg: "Wait for image upload success message.");

    uploadTask.events.listen((event) {
      setState(() {
        _isloading = true;
        _progress = event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble();
        print(_progress);
      });
    });

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      var x = 2;
    });

    final String url = (await taskSnapshot.ref.getDownloadURL());
    print('URL Is $url');

    imageurl = url;
    Fluttertoast.showToast(
        msg: "Image uploaded successfully. Now you can submit the post");
    return url;
  }

  Widget uploadArea() {
    return Column(
      children: <Widget>[
        Image.file(image, width: double.infinity),
        //Padding(padding: EdgeInsets.all(8)),
        FlatButton.icon(
          onPressed: () {
            uploadImage();
            print(filename);
          },
          icon: Icon(Icons.cloud_upload),
          label: Text("Upload"),
        ),
        SizedBox(height: 20.0),
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
            "Create Post",
            style: TextStyle(color: Colors.grey[800]),
          ),
          backgroundColor: Colors.orange,
          iconTheme: new IconThemeData(color: Colors.grey[800]),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 5.0),
            _Titletextfield(),
            SizedBox(height: 10.0),
            DropdownButton(
              hint: _categoryVal == null
                  ? Text('Post category')
                  : Text(
                      _categoryVal,
                      style: TextStyle(color: Colors.black),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.orange),
              items: [
                "LatestPost",
                "InternationalAllNews",
                "PoliticsAllNews",
                "SportsAllNews",
                "LocalAllNews",
                "ScholarshipAllNews"
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
                    _categoryVal = val;
                  },
                );
              },
            ),
            SizedBox(height: 10.0),
            _contenttextfield(),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  image == null
                      ? Image.network(widget.snapshot['image'])
                      : uploadArea(),
                  Container(
                    child: Row(
                      children: [
                        FlatButton.icon(
                            onPressed: () => getImage(ImageSource.camera),
                            padding: EdgeInsets.only(right: 110),
                            icon: Icon(Icons.camera),
                            label: Text('Camera')),
                        FlatButton.icon(
                            onPressed: () => getImage(ImageSource.gallery),
                            icon: Icon(Icons.photo_library),
                            label: Text('Gallery')),
                      ],
                    ),
                  )
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

                      // ignore: deprecated_member_use
                      Firestore.instance
                          .collection(_categoryVal)
                          // ignore: deprecated_member_use
                          .document(widget.snapshot.id)
                          // ignore: deprecated_member_use
                          .updateData({
                        "content": _postcontentController.text,
                        "title": _titleController.text,
                        "image": imageurl
                      });

                      Fluttertoast.showToast(
                          msg: _categoryVal + " Posted Successfully!!");
                      Navigator.pop(context);
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
                    child: InkWell(
                      // onTap: () {
                      //   FirebaseFirestore.instance
                      //       .collection("InternationalAnnNews")
                      //       //.where("email", isEqualTo: widget.snapshot['email'])
                      //       // ignore: deprecated_member_use
                      //       .document(widget.snapshot.id)

                      //       // ignore: deprecated_member_use
                      //       .updateData({
                      //     "title": _titleController,
                      //     "content": _postcontentController,
                      //     "iamge": image
                      //   });
                      // },
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Text("Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
