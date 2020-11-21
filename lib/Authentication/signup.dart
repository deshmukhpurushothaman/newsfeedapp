import 'auth_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../FadeAnimation.dart';
import 'social.dart';
import '../Home.dart';

bool isHiddenPassword = true;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 330,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 350,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/background-signup1.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 350,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/background-signup2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromRGBO(40, 39, 7, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange[50],
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.grey),
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.length < 6)
                                    return 'Provide Minimum 6 Character';
                                },

                                controller: _passwordController,
                                obscureText: isHiddenPassword,
                                // onSaved: (input) => _password = input,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.grey),
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(isHiddenPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isHiddenPassword = !isHiddenPassword;
                                        });
                                      },
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 25),

                  FadeAnimation(
                    1.9,
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Fields cannot be empty!!");
                              print("Email and password cannot be empty");
                              return;
                            }
                            if (_nameController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Username cannot be empty");
                              print("Username cannot be empty");
                              return;
                            }
                            try {
                              final user = await AuthHelper.signUpWithEmail(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              if (user != null) {
                                Fluttertoast.showToast(
                                    msg: "Signup successful");
                                print("Signup successful");
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(40, 25, 7, 1),
                                  Colors.brown,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      36.0), // min sizes for Material buttons
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
                  ),
                  //color: Color.fromRGBO(105, 66, 9, 1),
                  SizedBox(height: 15),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        iconSrc: "images/google.png",
                        press: () async {
                          try {
                            await AuthHelper.signInWithGoogle();
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          buildDivider(),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
