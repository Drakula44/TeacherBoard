import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacherboardapp/pages/details.dart';
import 'package:teacherboardapp/pages/home.dart';
import 'package:teacherboardapp/pages/login.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      theme: ThemeData(
          primaryColor: Colors.deepOrange,
          fontFamily: 'Montserrat',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}
