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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_radio_button/group_radio_button.dart';

//import 'users.dart';
//import 'InternationalNews/InternationalAllNews.dart';

class updateGovtJobpost extends StatefulWidget {
  DocumentSnapshot snapshot;
  updateGovtJobpost(this.snapshot);
  @override
  _updateGovtJobpostState createState() => _updateGovtJobpostState();
}

class _updateGovtJobpostState extends State<updateGovtJobpost> {
  TextEditingController _titleController;
  TextEditingController _postcontentController;
  TextEditingController _urlController;

  String _categoryVal;
  String _postType;
  String _url;
  String imageurl;
  File image;
  String filename;
  bool _isloading = false;
  double _progress;
  String _singleValue;
  final User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.snapshot['title']);
    _postcontentController =
        TextEditingController(text: widget.snapshot['content']);
    _singleValue = widget.snapshot['experience'];
    //image = File(widget.snapshot['image']);
    imageurl = widget.snapshot['image'];
    _urlController = TextEditingController(text: widget.snapshot['url']);
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
      print("Progress Entered");
      return Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: loading,
            backgroundColor: Colors.red,
          ),
          Text('${(loading * 100).toStringAsFixed(2)} %'),
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
        progress(_progress);
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

  Widget _urltextfield() {
    return TextField(
      controller: _urlController,
      decoration: InputDecoration(
          labelText: "Url",
          hintText: "Enter or paste url here...",
          border: OutlineInputBorder()),
    );
  }

  Widget _radiobuttonfield() {
    return Container(
      width: 150,
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                RadioButton(
                    description: "Both",
                    value: "Both",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
                RadioButton(
                    description: "Experienced",
                    value: "Experienced",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
                RadioButton(
                    description: "Fresher",
                    value: "Fresher",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
              ],
            ),
          ),
        ],
      ),
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
                "Government Job",
                "Internship",
                "Non-Government Job",
                "Walkin",
                "Scholarship",
                "Events"
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
            _urltextfield(),
            SizedBox(height: 10.0),
            _contenttextfield(),
            SizedBox(height: 10.0),
            _radiobuttonfield(),
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
                        "image": imageurl,
                        "default": "${_categoryVal}1",
                        "updated_on": "${DateTime.now()}",
                        "updated_by": "${user.email}",
                        "experience": "${_singleValue}"
                      });

                      Fluttertoast.showToast(
                          msg: _categoryVal + " Updated Successfully!!");
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
                      //
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
