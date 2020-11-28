import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AdminUsers.dart';

class Admindetails extends StatefulWidget {
  DocumentSnapshot snapshot;

  Admindetails(this.snapshot);

  @override
  _AdmindetailsState createState() => _AdmindetailsState();
}

class _AdmindetailsState extends State<Admindetails> {
  String _role;
  String dbRole;

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
                  text: "Role: " + widget.snapshot['role'],
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
                  "Admin",
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
                    child: InkWell(
                      onTap: () => {
                        if (_role == "User")
                          {
                            dbRole = "0",
                          }
                        else if (_role == "Super Admin")
                          {
                            dbRole = "2",
                          }
                        else if (_role == "Latest News Admin")
                          {
                            dbRole = "3",
                          }
                        else if (_role == "International News admin")
                          {
                            dbRole = "4",
                          }
                        else if (_role == "Politic News admin")
                          {
                            dbRole = "5",
                          }
                        else if (_role == "Sports News admin")
                          {
                            dbRole = "6",
                          }
                        else
                          {
                            dbRole = "7",
                          },
                        print("Condition Done" + dbRole),
                        FirebaseFirestore.instance
                            .collection("users")
                            //.where("email", isEqualTo: widget.snapshot['email'])
                            // ignore: deprecated_member_use
                            .document(widget.snapshot.id)

                            // ignore: deprecated_member_use
                            .updateData({
                          "role": dbRole,
                        }),
                        print("Successful"),
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => AdminUsersPage())),
                      },
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
        ),
      )),
    );
  }
}
