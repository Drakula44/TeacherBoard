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
  String _userName;
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
        backgroundColor: Color(0xFF26282B),
        appBar: AppBar(
          title: Text(appBarTitles[selectedIndex], style: TextStyle(color:Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            Container(
              child: FlatButton(
                      child: Text(
                        _state ? _userEmail : 'Log In',
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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: navOptions.elementAt(selectedIndex)
        )
    );
  }
}
