import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/home.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('images/defaultProfile.jpg'),
                height: 200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                      'Username',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text('Certified cock sucker', style: TextStyle(fontStyle: FontStyle.italic),)
                ],
              )
            ],
          ),
        ),
        Expanded(child: Posts())
      ],
    );
  }
}
