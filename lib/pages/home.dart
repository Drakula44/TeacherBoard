import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/search.dart';
import 'package:teacherboardapp/pages/profile.dart';
import 'package:teacherboardapp/widgets/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  /*void _getPosts() async {
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

   */

  List<Post> posts;

  List<Widget> navOptions;

  @override
  void initState() {
    navOptions = [
      Posts(filter: new Filter(all: true, collection: "posts")),
      Search(),
      Profile(),
    ];
    super.initState();
  }

  final List<String> appBarTitles = [
    'Teacherboard',
    'Search',
    'You'
  ];

  bool _state = false;
  String _userEmail;
  String _userName;

  String _userUID;
  FirebaseUser _user;
  void _checkState() async {
    _user = await _auth.currentUser();
    
    if (_user != null) {
      DocumentSnapshot lol1 = await Firestore.instance.collection('users').document(_user.uid).snapshots().first;
      String _username = lol1.data['username'];
      setState(() {
        _state = true;
        _userEmail = _user.email;
        _userName = _username;
      });
    } else {
      _state = false;
    }
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void _signOut() async
  {
    await _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    _checkState();
    return Scaffold(
        backgroundColor: Color(0xFF26282B),
        appBar: AppBar(
          title: Text(appBarTitles[selectedIndex], style: TextStyle(color:Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            Container(
              child: FlatButton(
                      child: Text(
                        _state ? _userName : 'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _state ? _signOut() : Navigator.pushNamed(context, '/login');
                      },
                    ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF26282B),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey,
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
                  Icons.search,
                ),
                title: Text(
                  'Search',
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
              _pageController.animateToPage(i, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (i) {
            setState(() {
              selectedIndex = i;
            });
          },
          children: navOptions
        )
    );
  }
}
