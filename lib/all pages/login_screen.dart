

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testdemo/all%20pages/mainpage.dart';


class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  bool _exists = false;



  void goto_chatscreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MainPage(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }

  void login_action() async {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(child: CircularProgressIndicator(color: Colors.black,),);
        });
    await SignInwithGoogle();

    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      goto_chatscreen(context);
    }



  }

  Future<void> SignInwithGoogle() async{
    //create an instance of the fire base auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn  = GoogleSignIn();
    // Triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    ////Create a new crendentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Sign in the user with the crendentials
    final UserCredential userCredential = await auth.signInWithCredential(credential);

    // add user to firestore

    final user = userCredential.user;

    final userdata = {
      'displayName': user?.displayName,
      'email': user?.email,
      'photoURL': user?.photoURL,
      'uid': user?.uid,

    };
    final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
    final d = await userRef.get();
    if(!d.exists){
      FirebaseFirestore.instance.collection('users').doc(user?.uid).set(userdata);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/kln-irp-chat-app.png"),
              ),
              SizedBox(height: 50,),
              Text(
                "Welcome to IRP Chat App",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                child: ElevatedButton.icon(
                  icon: Image.asset("assets/images/google_logo.png",
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    // SignInwithGoogle();
                    login_action();
                    // if(mounted){
                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainPage()));
                    // }

                  },
                  label: Text("Sign in",
                  style: TextStyle(color: Colors.black),),
                ),
              ),
              SizedBox(height: 300,),
              Text("KLN IRP",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)

            ],
          ),
        ),
      ),
    );
  }
}
