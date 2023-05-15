import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:testdemo/all%20pages/login_screen.dart';
import 'package:testdemo/all%20pages/mainpage.dart';

class SplashScreen extends StatefulWidget {
  final User? user;
  const SplashScreen({super.key, required this.user});

  @override
  State<SplashScreen> createState() => _SplashScreenState(user);
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  _SplashScreenState(User? userv) {
    user = userv;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splash();
  }

  void _splash() async {
    await Future.delayed(Duration(seconds: 2));
    if(user != null){
      goto_mainpage(context);
      log("\n\n\n\n\n\n\nthe User signed in");
    }
    else{
      goto_loginpage(context);
      log("\n\n\n\n\nUser is currently signed out");
      print(user?.displayName);
    }

  }

  void goto_loginpage(BuildContext context){
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => login_screen(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }

  void goto_mainpage(BuildContext context){
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MainPage(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("VISHNU",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),),
      ),
    );
  }
}
