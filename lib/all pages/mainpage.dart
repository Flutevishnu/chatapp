import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testdemo/all%20pages/chat_screen.dart';
import 'package:testdemo/all%20pages/chatting_screen.dart';
import 'package:testdemo/all%20pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<User> _signedInUsers = [];

  void _getSignedInUsers() {}

  @override
  void initState() {
    super.initState();
    _getSignedInUsers();
  }

  void goto_profile() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => profile_page(),
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),
          title: Text(
            "KLN IRP",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    value: "Settings",
                    child: Row(
                      children: [
                        Text("Settings"),
                        SizedBox(width: 20),
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: "profile",
                    child: Row(
                      children: [
                        Text("Profile"),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.person, color: Colors.black),
                      ],
                    ))
              ],
              onSelected: (String value) {
                if (value == "profile") {
                  goto_profile();
                }
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(width: 5,),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Information",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      elevation: 5,
                      splashFactory: InkRipple.splashFactory,
                      shadowColor: Colors.blue,
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Chats",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        elevation: 5,
                        splashFactory: InkRipple.splashFactory,
                        shadowColor: Colors.blue,
                        alignment: Alignment.center,
                        backgroundColor: Colors.grey),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => Team_chat(),
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      child:
                          Text("Teams", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          elevation: 5,
                          splashFactory: InkRipple.splashFactory,
                          shadowColor: Colors.blue,
                          alignment: Alignment.center,
                          backgroundColor: Colors.white)),

                  // SizedBox(width: 5,),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where("uid", isNotEqualTo: user!.uid)
                        .snapshots(), // [data]  data.first
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {

                      final users = snapshot.data!.docs;

                      return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {

                            final userdata = users[index].data() as Map<String, dynamic>;

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userdata["photoURL"],
                                ),
                                backgroundColor: Colors.white,
                              ),
                              title: Text("${userdata["displayName"]}"),
                              subtitle: Text("subtitle"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => chat(useruid: userdata['uid']),
                                    transitionDuration: Duration(milliseconds: 500),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              },
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
