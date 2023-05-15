import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:testdemo/page2.dart';
import 'package:testdemo/all%20pages/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? newUser){
      setState(() {
        user = newUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRP Chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(user: user),
    );
  }
}
