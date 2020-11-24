import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUsersPage extends StatelessWidget {
  String _categoryVal;
  // setState(() {
  //     image = selectedImage;
  //     filename = basename(image.path);
  //   });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('List of Admins', style: TextStyle(color: Colors.grey[800])),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final docs = snapshot.data.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = docs[index].data();

                      if ((user['role']).toString().compareTo("0") != 0 &&
                          (user['role']).toString().compareTo("2") != 0) {
                        print(user['email']);
                        return Container(
                          child: ListTile(
                            // title: Text(user['name'] ?? user['email']),
                            title: Text(user['email'] ?? "Username undefined"),
                            subtitle: Text(user['role']),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
