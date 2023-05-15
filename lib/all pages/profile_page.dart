import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  Future<void> logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    SystemNavigator.pop();
  }

  void logout_action() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 15, left: 15),
            contentPadding:
                EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 20),
            actionsPadding: EdgeInsets.symmetric(vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Sign out',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            content: Text(
              'Do you want to signout?',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        await logout();
                        Navigator.pop(context);
                      },
                      child: Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "logout",
            splashRadius: 20,
            onPressed: logout_action,
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("uid", isEqualTo: user.uid)
                  .snapshots(), // [data]  data.first
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {

                  final userfirestore = snapshot.data!.docs.first.data() as Map<String, dynamic>;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(userfirestore["photoURL"],

                      ),),
                      SizedBox(height: 20,),
                      Text(
                        userfirestore["displayName"],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      Text(userfirestore["email"],
                        style: TextStyle(fontSize: 18),)
                    ],
                  );

              })),
    );
  }
}
