import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../main.dart';

class NewPost extends StatelessWidget {
  final User _user;
  NewPost(this._user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new post', style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
      ),
      body: NewPostForm(),
      backgroundColor: Color(0xFF26282B),
    );
  }
}

class NewPostForm extends StatefulWidget {
  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';


  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImages() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#${Theme.of(context).accentColor.value.toRadixString(16)}',
          actionBarTitle: "Choose Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    print('#${Theme.of(context).accentColor.value.toRadixString(16)}');
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

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
                  Stack(
                    children: <Widget>[
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
                      Positioned(
                        bottom: 5,
                        child: Container(
                          height: 75,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: MediaQuery.of(context).size.width-32,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context,i) {
                              return AssetThumb(
                                asset: images[i],
                                width: 300,
                                height: 300,
                              );
                            },
                          ),
                        ),
                      )
                    ],
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
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add_photo_alternate
                ),
                onPressed: () {
                  _pickImages();
                },
              ),
            )
          ],
        )
      )
    );
  }
}



