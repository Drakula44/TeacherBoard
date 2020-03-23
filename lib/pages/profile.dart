import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/home.dart';

class Profile extends StatelessWidget {
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
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image(
                    image: AssetImage('images/defaultProfile.jpg'),
                    height: 150,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Mudja',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text('Certified bakar stealer', style: TextStyle(fontStyle: FontStyle.italic),),
                  SizedBox(height: 8,),
                  Text('9000', style: TextStyle(fontSize: 40),)
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
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(child: Posts()),
      ],
    );
  }
}
