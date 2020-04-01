import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacherboardapp/pages/details.dart';
import 'package:teacherboardapp/pages/home.dart';
import 'package:teacherboardapp/pages/login.dart';
import 'package:teacherboardapp/pages/new_post.dart';
import 'package:teacherboardapp/pages/schools.dart';
import 'package:teacherboardapp/pages/signup.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {

  final Color textColor = Colors.white;

  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        accentColor: Colors.deepOrange,
        textTheme: TextTheme(
          display1: TextStyle (
            color: textColor,
            fontSize: 12
          ),
          body1: TextStyle (
            color: textColor,
            fontFamily: 'Estaban'
          ),
          title: TextStyle(
            color: textColor,
            fontSize: 20,
            fontFamily: 'Montserrat'
          )
        ),
        fontFamily: 'Montserrat',
      ),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/new-post': (context) => NewPost(),
      },
    );
  }
}
