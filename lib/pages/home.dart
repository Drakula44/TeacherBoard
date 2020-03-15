import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacherboard'),

      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('Log in'),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          Flexible(
              child: Posts()
          ),
        ],
      )
    );
  }
}

class _Post {
  String title;
  String content;
  int likes;
  int dislikes;

  _Post(this.title, this.content, this.likes, this.dislikes);


}


class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  List<_Post>_mockPosts = [new _Post('cock', 'and balls', 69, 96), new _Post('drakula je peder', 'i picka i picka i picka i picka i picka i picka ', 1000, 0)];

  Widget _buildPosts() {
    return ListView.builder(
        itemBuilder: (context, i) {
          if(i < _mockPosts.length)
            return _buildRow(_mockPosts[i]);
          return null;
        }
    );
  }

  Widget _buildRow (_Post post) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 30.0
                    ),
                  ),
                  Text(post.content),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column (
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        post.likes.toString(),
                      ),
                      IconButton(
                        icon: Icon (
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () {
                          Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(content: Text('like'), duration: const Duration(milliseconds: 250)));
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        post.dislikes.toString(),
                      ),
                      IconButton(
                        icon: Icon (
                          Icons.close,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(content: Text('dislike'), duration: const Duration(milliseconds: 250),));
                        },
                      )
                    ],
                  ),

                ],
              )
            )
          ],
        )
      )

    );
  }
  
  @override
  Widget build(BuildContext context) {
    return _buildPosts();
  }
}

