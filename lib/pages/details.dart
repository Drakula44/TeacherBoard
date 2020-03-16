import 'package:flutter/material.dart';
import 'package:teacherboardapp/pages/home.dart';

class Comment {
  String content;
  String author;
  String timestamp;

  Comment(this.content, this.author, this.timestamp);

}

class Details extends StatefulWidget {

  final Post _post;

  Details(this._post);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  List<Comment> comments = [new Comment('epic', 'drakula44', '31 Feb 1994'), new Comment('komentar', 'stex', '19 Apr 2002')];

  final _commentFormKey = GlobalKey<FormState>();

  String _currentComment;
  TextEditingController _commentTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._post.title),
      ),
      body: Column(
        children: <Widget>[
          PostListItem(post: widget._post),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, i) {
                  if(i < comments.length)
                    return Card (
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              comments[i].content,
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    'By ${comments[i].author}',
                                  style: TextStyle(
                                    fontSize: 10
                                  ),
                                ),
                                Text
                                  (comments[i].timestamp,
                                  style: TextStyle(
                                      fontSize: 10
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ),
                    );
                  return null;
                }
            ),
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
                        border: Border.all(
                          color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100,
                          maxWidth: 250
                        ),
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: _commentTextEditingController,
                            validator: (String value) {
                              if(value.isEmpty)
                                return 'Comment can\'t be empty';
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
                  FlatButton(
                    child: Text(
                      'Comment',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if(_commentFormKey.currentState.validate()) {
                        _commentFormKey.currentState.save();
                        setState(() {
                            comments.add(
                                new Comment(_currentComment, 'author',
                                    'right now'));
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

