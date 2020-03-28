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
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: <Widget>[
                  ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(8),
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
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: TextFormField(
                          style: Theme.of(context).textTheme.title,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            enabledBorder: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent
                              )
                            )
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ClipRRect(
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.all(8),
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
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(
                                hintText: 'Description',
                                enabledBorder: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                )
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFF26282B),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF1B1C1D), offset: Offset(5,5), blurRadius: 11),
                        BoxShadow(color: Color(0xCC2F3136), offset: Offset(-5,-5), blurRadius: 11)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 10,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add_photo_alternate
                ),
                onPressed: () {

                },
              ),
            )
          ],
        )
      )
    );
  }
}



