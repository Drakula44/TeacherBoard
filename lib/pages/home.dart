import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/search.dart';
import 'package:teacherboardapp/pages/profile.dart';
import 'package:teacherboardapp/widgets/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;



class Home extends StatefulWidget {
  final User _user;
  Home(this._user);
  
  @override
  _HomeState createState() => _HomeState(_user);
}

class _HomeState extends State<Home> {
  User _user;
  _HomeState(this._user);
  int selectedIndex = 0;
  List<Post> posts;

  List<Widget> navOptions;


  @override
  void initState() {
    navOptions = [
      Posts(filter: new Filter(all: true, collection: "posts"),user: _user),
      Search(),
      Profile(),
    ];
    super.initState();
  }

  void _getUser() async
  {
    FirebaseUser _userF = await _auth.currentUser();
    print("lol");
    if(_userF == null)
    {
      return;
    } 
    print("loe");
    DocumentReference userDoc = Firestore.instance.collection('users').document(_userF.uid);
    print("lol3");
    DocumentSnapshot lol1 = await userDoc.snapshots().first;
    print("lol3");
    String _username = lol1.data['username'];
    print("lol3");
    _user = new User(_userF, _username ,_userF.email, _userF.uid,userDoc);
    print("lol3");
  }
  final List<String> appBarTitles = [
    'Teacherboard',
    'Search',
    'You'
  ];

  bool _state = false;
  void _checkState() async {   
    
    if (_user != null) {
      setState(() {
        _state = true;
      });
    } else {
      _getUser();
      _state = false;
    }
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void _signOut() async
  {
    _state = false;
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
                        (_user != null) ? _user.userName : 'Log In',
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
