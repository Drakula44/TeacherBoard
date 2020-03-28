import 'dart:ui';

import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewPostForm();
  }
}

class NewPostForm extends StatefulWidget {
  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 4,
                              color: Color(0xCC2F3136)
                            ),
                            right: BorderSide(
                                width: 4,
                                color: Color(0xCC2F3136)
                            ),
                            top: BorderSide(
                                width: 4,
                                color: Color(0xCC1B1C1D)
                            ),
                            left: BorderSide(
                                width: 4,
                                color: Color(0xCC1B1C1D)
                            ),
                          )
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            ),
                          )
                        ),
                      ),
                      /*Container(
                        width: 350,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                              color: Colors.white
                            )
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
            FloatingActionButton(
              child: Icon(
                Icons.add_photo_alternate
              ),
              onPressed: () {

              },
            )
          ],
        )
      )
    );
  }
}



