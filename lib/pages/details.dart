import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teacherboardapp/widgets/posts.dart';

import '../main.dart';

class Comment {
  String content;
  String author;
  String timestamp;
  String commentID;

  Comment(this.content, this.author, this.timestamp, {this.commentID = ''});
}

class Details extends StatefulWidget {
  final Post _post;
  final User _user;

  Details(this._post,this._user);

  @override
  _DetailsState createState() => _DetailsState(_user);
}

class _DetailsState extends State<Details> {
  final User _user;
  String postID;
  _DetailsState(this._user);
  List<Comment> comments = [
    new Comment('epic', 'drakula44', '31 Feb 1994'),
    new Comment('komentar', 'stex', '19 Apr 2002')
  ];

  final _commentFormKey = GlobalKey<FormState>();

  String _currentComment;
  TextEditingController _commentTextEditingController =
      new TextEditingController();
  @override
  void initState() {
    postID = widget._post.post_id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(new Filter(
                      collection: "commment",
                      par1name: "post_id",
                      par1equal: postID)
                  .results());
    return Scaffold(
      backgroundColor: Color(0xFF26282B),
      appBar: AppBar(
        title: Text(widget._post.title, style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
      ),
      body: Column(
        children: <Widget>[
          PostListItem(
            _user,
            post: widget._post,
            maxLines: 30,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: new Filter(
                      collection: "commment",
                      par1name: "post_id",
                      par1equal: postID)
                  .results(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                final int messageCount = snapshot.data.documents.length;
                return ListView.builder(
                  itemCount: messageCount,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot document =
                        snapshot.data.documents[index];
                    return Card(
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                document['content'],
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'By ${document['user_name']}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    '',
                                    /*document['time']*/
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  },
                );
              },
            )
            /*
            ListView.builder(
                itemBuilder: (context, i) {
                  if(i < comments.length)
                    return
                    ;

                  return null;
                }
            )*/
            ,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _commentFormKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF26282B),
                        boxShadow: [
                          BoxShadow(color: Color(0xFF1B1C1D), offset: Offset(5,5), blurRadius: 11),
                          BoxShadow(color: Color(0xCC2F3136), offset: Offset(-5,-5), blurRadius: 11)
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 100, maxWidth: 250),
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: _commentTextEditingController,
                            validator: (String value) {
                              if (value.isEmpty)
                                return '';
                              return null;
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Leave a comment',
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorStyle: TextStyle(
                                fontSize: 0,
                                height: 0
                              )
                            ),
                            onSaved: (value) {
                              _currentComment = value;
                              _commentTextEditingController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF26282B),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF1B1C1D), offset: Offset(5,5), blurRadius: 11),
                        BoxShadow(color: Color(0xCC2F3136), offset: Offset(-5,-5), blurRadius: 11)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Comment',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        if (_commentFormKey.currentState.validate()) {
                          _commentFormKey.currentState.save();
                          setState(() {
                            comments.add(new Comment(
                                _currentComment, 'author', 'right now'));
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
