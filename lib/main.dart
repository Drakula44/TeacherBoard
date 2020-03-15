import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacherboardapp/pages/home.dart';
import 'package:teacherboardapp/pages/login.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,

        fontFamily: 'Montserrat'

      ),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}
