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

  Post(this.title, this.content, this.author, this.likes, this.dislikes,
      this.timestamp, this.school, this.subject);
}

class Posts extends StatefulWidget {
  const Posts({this.posts});

  final List<Post> posts;

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> posts;

  initState() {
    posts = widget.posts;
    super.initState();
  }

/*
  Widget _buildPosts() {
    return ListView.builder(
        itemBuilder: (context, i) {
          if(i < posts.length)
            return _buildRow(posts[i]);
          if(i == posts.length)
            return Center(
              child: Text(
                "Oh, it looks like you've reached the end",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          return null;
        }
    );
  }

 */
  Widget _buildPosts() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i < posts.length) return _buildRow(posts[i]);
      if (i == posts.length)
        return Center(
          child: Text(
            "Oh, it looks like you've reached the end",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      return null;
    });
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
