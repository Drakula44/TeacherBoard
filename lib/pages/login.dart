import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}


class _LoginData {
  String email = '';
  String password = '';
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  _LoginData _data = new _LoginData();

  bool _obsecureText = true;
  IconData _passwordIcon = Icons.visibility_off;

  void _togglePassword () {
    setState(() {
      _obsecureText = !_obsecureText;
      if(_passwordIcon == Icons.visibility_off) {
        _passwordIcon = Icons.visibility;
      }
      else {
        _passwordIcon = Icons.visibility_off;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form (
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Teacherboard',
              style: TextStyle(
                fontSize: 48.0,
                fontFamily: 'Quicksand'
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Colors.deepOrange,
                  ),
                  /*enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.deepOrange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
                  ),*/
              ),
              onSaved: (String value) {
                _data.email = value;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.deepOrange,
                ),
                /*enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
                ),*/
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordIcon,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _togglePassword();
                  },
                ),
              ),
              onSaved: (String value) {
                _data.password = value;
              },
              obscureText: _obsecureText,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('${_data.email} ${_data.password}'),));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                    'Log In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepOrange,
              ),
            )
          ],
        ),
      )
    );
  }
}

