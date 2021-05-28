import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:fl_fire_auth/Admin/admin_home.dart';
import 'package:fl_fire_auth/Admin/createEventspost.dart';
import 'package:fl_fire_auth/Admin/createpost.dart';
import 'package:fl_fire_auth/Admin/createlatestpost.dart';
import 'package:fl_fire_auth/Admin/createscholarshippost.dart';
import 'Admin/createGovtJobpost.dart';
import 'Admin/createWalkinpost.dart';
import 'Admin/createInternshippost.dart';
import 'Admin/createNonGovtJobpost.dart';
import 'Start.dart';
import 'package:flutter/cupertino.dart';
//import 'Admin/admin_home.dart';
import 'Super Admin/AdminHome.dart';
import 'Authentication/auth_helper.dart';
//import 'home.dart';
import 'Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'Authentication/login.dart';
import 'carousal.dart';
import 'NewPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Main.dart");
  String token123;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    print("Main.dart initstate");
    _firebaseMessaging.getToken().then((token) =>
        {token123 = token, print("Firebase Messaging token: $token")});
    //super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  runApp(MyApp());
}

//final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // @override
  String token123;
  void initState() {
    //super.initState();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) =>
        {token123 = token, print("Firebase Messaging token: $token")});
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusVita',
      theme: ThemeData(
        // fontFamily: "poppins",
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                final FirebaseMessaging _firebaseMessaging =
                    FirebaseMessaging();
                _firebaseMessaging.getToken().then(
                    (token) => {print("Firebase Messaging token: $token")});
                _firebaseMessaging.configure(
                  onMessage: (Map<String, dynamic> message) async {
                    print("onMessage: $message");
                  },
                  onLaunch: (Map<String, dynamic> message) async {
                    print("onLaunch: $message");
                  },
                  onResume: (Map<String, dynamic> message) async {
                    print("onResume: $message");
                  },
                );
                _firebaseMessaging.requestNotificationPermissions(
                    const IosNotificationSettings(
                        sound: true, badge: true, alert: true));
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if (user['role'] == '1') {
                    return createpost();
                  } else if (user['role'] == '2') {
                    print("Super admin");
                    return AdminHome();
                  } else if (user['role'] == '3') {
                    return createlatestpost();
                  } else if (user['role'] == '4') {
                    return createGovtJobpost();
                  } else if (user['role'] == '5') {
                    return createWalkinpost();
                  } else if (user['role'] == '6') {
                    return createInternshippost();
                  } else if (user['role'] == '7') {
                    return createNonGovtJobpost();
                  } else if (user['role'] == '8') {
                    return createScholarshippost();
                  } else if (user['role'] == '9') {
                    return createEventspost();
                  } else {
                    return NewPage();
                  }
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return Start();
        });
  }
}
