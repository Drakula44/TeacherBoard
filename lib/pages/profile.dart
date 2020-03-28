import 'package:flutter/material.dart';
import 'package:teacherboardapp/widgets/posts.dart';

class Profile extends StatefulWidget {
  final String userUID = "";
  final String username = "ognjen";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userUID;
  String username;
  @override
  void initState() {
    username = widget.username;
    userUID = widget.userUID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                ),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B1C1D), Color(0xCC2F3136)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0xFF1B1C1D), offset: Offset(5,5), blurRadius: 11),
                      BoxShadow(color: Color(0xCC2F3136), offset: Offset(-5,-5), blurRadius: 11)
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image(
                      image: AssetImage('images/defaultProfile.jpg'),
                      height: 150,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    'Certified bakar stealer',
                    style: TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Montserrat'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '9000',
                    style: TextStyle(fontSize: 40),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(child: Posts(filter: new Filter(user: username))),
      ],
    );
  }
}
