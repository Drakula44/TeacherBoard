import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text('Log in, cunt'),
          backgroundColor: Colors.deepOrange,
        ),
      ),
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
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.deepOrange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
                  ),
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
              ),
              onSaved: (String value) {
                _data.email = value;
              },
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
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.deepOrange,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
                ),
                suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.deepPurple,
                ),
              ),
              onSaved: (String value) {
                _data.password = value;
              },
              obscureText: true,
            ),
            SizedBox(
              height: 64,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('${_data.email} ${_data.password}'),));
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

