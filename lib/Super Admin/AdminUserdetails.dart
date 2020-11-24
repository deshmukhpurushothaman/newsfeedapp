import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admindetails extends StatefulWidget {
  DocumentSnapshot snapshot;

  Admindetails(this.snapshot);

  @override
  _AdmindetailsState createState() => _AdmindetailsState();
}

class _AdmindetailsState extends State<Admindetails> {
  String _role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Admin details', style: TextStyle(color: Colors.grey[800])),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            RichText(
                text: TextSpan(
                    text: '',
                    style: TextStyle(fontSize: 23.0, color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: widget.snapshot['email'],
                      style: TextStyle(fontSize: 23.0, color: Colors.black))
                ])),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                  text: '(International news Admin)',
                  style: TextStyle(
                      fontSize: 23.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey[700])),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(7.0),
              child: DropdownButton(
                hint: _role == null
                    ? Text('Change role....',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15))
                    : Text(
                        _role,
                        style: TextStyle(color: Colors.black),
                      ),
                isExpanded: true,
                iconSize: 40.0,
                style: TextStyle(color: Colors.orange),
                items: [
                  "User",
                  "Super Admin",
                  "Latest News Admin",
                  "International News admin",
                  "Politic News admin",
                  "Sports News admin",
                  "Local News admin"
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
                      _role = val;
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 80),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () {},
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
          ],
        ),
      )),
    );
  }
}
