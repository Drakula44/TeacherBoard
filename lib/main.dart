import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacherboardapp/pages/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacherboardapp/pages/home.dart';
import 'package:teacherboardapp/pages/login.dart';
import 'package:teacherboardapp/pages/new_post.dart';
import 'package:teacherboardapp/pages/schools.dart';
import 'package:teacherboardapp/pages/signup.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}
class User
{
  FirebaseUser userF;
  String userName;
  String userEmail;
  String uID;
  Map<String,dynamic> likes;
  DocumentReference doc;
  User(this.userF,this.userName,this.userEmail,this.uID,this.doc);
}

class MyApp extends StatelessWidget {
  User _user;
  final Color textColor = Colors.white;

  void getUser() async
  {
    FirebaseUser _userF = await _auth.currentUser();
    print("lol");
    if(_userF == null)
    {
      return;
    } 
    print("loe");
    DocumentReference userDoc = await Firestore.instance.collection('users').document(_userF.uid);
    DocumentSnapshot lol1 = await userDoc.snapshots().first;
    String _username = lol1.data['username'];
    _user = new User(_userF, _username ,_userF.email, _userF.uid,userDoc);
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return MaterialApp(
      initialRoute:  '/home' ,
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
        '/home': (context) => Home(_user),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/new-post': (context) => NewPost(_user),
      },
    );
  }
}
