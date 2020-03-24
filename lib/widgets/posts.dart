import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/details.dart';

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
  const Posts({this.filter});
  final Filter filter;
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Filter filter;

  initState() {
    filter = widget.filter;
    super.initState();
  }

  Widget _buildPosts() {
    return StreamBuilder<QuerySnapshot>(
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
                /*document['content']*/ document.documentID,
                document['user_name'],
                document['likes'],
                document['dislikes'],
                /*document['time']*/ '',
                document['school_name'],
                document['subject_name'],
                document.documentID);
            return _buildRow(post);
          },
        );
      },
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

  Color _likeTextColor = Colors.black;
  Color _dislikeTextColor = Colors.black;

  int maxLines;

  void _toggleLike(int newLikeState) {
    if (_likeState == newLikeState) {
      newLikeState = 0;
    }

    switch (newLikeState) {
      case 1:
        {
          setState(() {
            _likeTextColor = Colors.green;
            _dislikeTextColor = Colors.black;

            _post.likes++;

            if (_likeState == -1) _post.dislikes--;

            //TODO: Server side
          });
        }
        break;

      case 0:
        {
          setState(() {
            _likeTextColor = Colors.black;
            _dislikeTextColor = Colors.black;

            if (_likeState == -1) _post.dislikes--;
            if (_likeState == 1) _post.likes--;

            //TODO: Server side
          });
        }
        break;

      case -1:
        {
          setState(() {
            _likeTextColor = Colors.black;
            _dislikeTextColor = Colors.red;

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
    return Card(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _post.timestamp,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _post.school,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _post.subject,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
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
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Text(
                            _post.content,
                            maxLines: maxLines,
                            overflow: TextOverflow.ellipsis,
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
                                    color: _likeTextColor,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
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
                                    color: _dislikeTextColor,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
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
                Divider(
                  thickness: 1,
                ),
                Text(
                  'By ${_post.author}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )));
  }
}
