import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  final useruid;
  const chat({super.key, required this.useruid});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where("uid", isEqualTo: widget.useruid)
                .snapshots(), // [data]  data.first
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {

              final userfirestore = snapshot.data!.docs.first.data() as Map<String, dynamic>;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userfirestore["photoURL"]),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${userfirestore["displayName"]}", textAlign: TextAlign.left,),
                      Text("${userfirestore["email"]}", textAlign: TextAlign.left, style: TextStyle(fontSize: 15),)
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
