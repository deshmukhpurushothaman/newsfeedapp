import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController _forgotemailontroller;

  @override
  void initState() {
    super.initState();
    _forgotemailontroller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/lock.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 40),
            Text(
              "Forgot your password?",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.orange))),
              child: TextField(
                controller: _forgotemailontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                    hintText: "Enter email address",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    print(_forgotemailontroller.text);
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _forgotemailontroller.text)
                        .then(
                          (value) => Fluttertoast.showToast(
                              msg:
                                  "Password reset link have been sent your mail!!"),
                        );
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
                      child: Text("Send Email",
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
