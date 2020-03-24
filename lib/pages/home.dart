import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/new_post.dart';
import 'package:teacherboardapp/pages/profile.dart';
import 'package:teacherboardapp/widgets/posts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Post> posts
  void _getPosts() async {
    Firestore.instance.collection('posts').
    posts =  [
      new Post('Naslov 1', 'blah blah', 'TvojaMajka34', 23, 11, '16 Mar 2020',
          'Matematicka gimnazija', 'Analiza'),
      new Post(
          'drakula je peder',
          'i cigan i cigan i cigan i cigan i cigan i cigan i cigan i cigan i cigan i cigan ',
          'CeoSvet',
          1000,
          0,
          '11 Sep 2001',
          'Frizerska skola',
          'Brijanje dlaka na jajaima'),
      new Post('Korona nas jebe', 'korona nas loma jebe u dupe', 'AVAVAV', 27,
          2222, '32 Feb 2020', 'Skole zatvorene', 'Predemet')
    ];
  }

  List<Post> posts;

  List<Widget> navOptions;

  @override
  void initState() {
    posts = _getPosts();
    navOptions = [
      Posts(posts: posts),
      NewPost(),
      Profile(),
    ];
    super.initState();
  }

  final List<String> appBarTitles = [
    'Teacherboard',
    'Create a new post',
    'You'
  ];

  bool _state = false;
  String _userEmail;
  String _userUID;
  FirebaseUser _user;
  void _checkState() async {
    _user = await _auth.currentUser();
    if (_user != null) {
      setState(() {
        _state = true;
        _userEmail = _user.email;
      });
    } else {
      _state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkState();
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitles[selectedIndex]),
          actions: <Widget>[
            Container(
              child: _state
                  ? Text(_userEmail, style: TextStyle(color: Colors.white))
                  : FlatButton(
                      child: Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                ),
                title: Text(
                  'New Post',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text(
                  'Profile',
                )),
          ],
          currentIndex: selectedIndex,
          onTap: (i) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
        body: navOptions.elementAt(selectedIndex));
  }
}
