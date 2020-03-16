import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/home.dart';

class Details extends StatefulWidget {

  Post _post;

  Details(this._post);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._post.title),
      ),
      body: PostListItem(post: widget._post),
    );
  }
}

