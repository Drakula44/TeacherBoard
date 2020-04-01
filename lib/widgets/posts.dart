import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/details.dart';
import 'package:teacherboardapp/pages/schools.dart';

class Post {
  String title = '';
  String content = '';
  String author = '';
  int likes = 0;
  int dislikes = 0;
  String timestamp = '';
  String school = '';
  String subject = '';
  String post_id = '';

  Post(this.title, this.content, this.author, this.likes, this.dislikes,
      this.timestamp, this.school, this.subject, this.post_id);
}

class Filter {
  bool all;
  String collection;
  String user;
  String par1name;
  String par1equal;
  Filter(
      {this.all = false,
      this.par1equal = "",
      this.par1name = '',
      this.collection = 'posts',
      this.user = ''});
  Stream<QuerySnapshot> results() {
    if (all) {
      return Firestore.instance.collection(collection).snapshots();
    } else {
      if (user != "") {
        return Firestore.instance
            .collection(collection)
            .where('user_name', isEqualTo: user)
            .snapshots();
      } else {
        return Firestore.instance
            .collection(collection)
            .where(par1name, isEqualTo: par1equal)
            .snapshots();
      }
    }
  }
}

class Posts extends StatefulWidget {
  const Posts({this.filter, this.showNewPostButton=true, this.showSchoolSelect=true});
  final Filter filter;
  final bool showNewPostButton;
  final bool showSchoolSelect;
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Filter filter;
  bool showNewPostButton;
  bool showSchoolSelect;


  String _currentSchool = 'Choose school';

  _pickSchool(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SchoolList())
    );

    setState(() {
      if(result!=null)
      _currentSchool = result;
    });
  }

  initState() {
    filter = widget.filter;
    showNewPostButton = widget.showNewPostButton;
    showSchoolSelect = widget.showSchoolSelect;
    super.initState();
  }

  Widget _buildPosts() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor, width: 0.5)
              ),
              margin: EdgeInsets.fromLTRB(16,8,16,0),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  _pickSchool(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_currentSchool, style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),),
                    Icon(
                      Icons.expand_more,
                      color: Theme.of(context).accentColor,
                      size: 32,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: filter.results(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  final int messageCount = snapshot.data.documents.length;
                  return ListView.builder(
                    itemCount: messageCount,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot document = snapshot.data.documents[index];
                      // TODO popraviti time da radi
                      Post post = new Post(
                          document['title'],
                          document['content'],
                          document['user_name'],
                          document['likes'],
                          document['dislikes'],
                          document['time'],
                          document['school_name'],
                          document['subject_name'],
                          document.documentID);
                      return _buildRow(post);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: showNewPostButton,
          child: Positioned(
            bottom: 10,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new-post');
              },
              child: Icon(
                Icons.add
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRow(Post post) {
    return InkWell(
        onTap: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new Details(post),
          );
          Navigator.of(context).push(route);
        },
        child: PostListItem(post: post));
  }

  @override
  Widget build(BuildContext context) {
    return _buildPosts();
  }
}

class PostListItem extends StatefulWidget {
  const PostListItem({this.post, this.maxLines});

  final Post post;
  final int maxLines;

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  Post _post;

  int _likeState = 0;

  FontWeight _likeFontWeight = FontWeight.normal;
  FontWeight _dislikeFontWeight = FontWeight.normal;

  int maxLines;

  void _toggleLike(int newLikeState) {
    if (_likeState == newLikeState) {
      newLikeState = 0;
    }

    switch (newLikeState) {
      case 1:
        {
          setState(() {
            _likeFontWeight = FontWeight.bold;
            _dislikeFontWeight = FontWeight.normal;

            _likeButtonColor = Theme.of(context).accentColor;
            _dislikeButtonColor = Theme.of(context).primaryColor;

            _post.likes++;

            if (_likeState == -1) _post.dislikes--;

            //TODO: Server side
          });
        }
        break;

      case 0:
        {
          setState(() {
            _likeFontWeight = FontWeight.normal;
            _dislikeFontWeight = FontWeight.normal;

            _likeButtonColor = Theme.of(context).primaryColor;
            _dislikeButtonColor = Theme.of(context).primaryColor;

            if (_likeState == -1) _post.dislikes--;
            if (_likeState == 1) _post.likes--;

            //TODO: Server side
          });
        }
        break;

      case -1:
        {
          setState(() {
            _likeFontWeight = FontWeight.normal;
            _dislikeFontWeight = FontWeight.bold;

            _likeButtonColor = Theme.of(context).primaryColor;
            _dislikeButtonColor = Theme.of(context).accentColor;

            _post.dislikes++;

            if (_likeState == 1) _post.likes--;
          });
        }
        break;

      default:
        {
          print("lol");
        }
    }
    _likeState = newLikeState;
  }

  Color _likeButtonColor;
  Color _dislikeButtonColor;

  @override
  void initState() {
    _post = widget.post;
    if (widget.maxLines != null)
      maxLines = widget.maxLines;
    else
      maxLines = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF26282B),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Color(0xCC1B1C1D), offset: Offset(5,5), blurRadius: 5),
            BoxShadow(color: Color(0xCC2F3136), offset: Offset(-5,-5), blurRadius: 5)

          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _post.school,
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  _post.subject,
                  style: Theme.of(context).textTheme.display1,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _post.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _post.content,
                        maxLines: maxLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              _post.likes.toString(),
                              style: TextStyle(
                                color: _likeButtonColor,
                                fontWeight: _likeFontWeight,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.check,
                                color: _likeButtonColor,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _toggleLike(1);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              _post.dislikes.toString(),
                              style: TextStyle(
                                color: _dislikeButtonColor,
                                fontWeight: _dislikeFontWeight,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: _dislikeButtonColor,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _toggleLike(-1);
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'By ${_post.author}',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  _post.timestamp,
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ],
        ));
  }
}
