import 'package:flutter/material.dart';

class _SignUpData {
  String email = '';
  String username = '';
  String password = '';
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F2F6),
      body: SignUpForm(),
    );
  }
}


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();

  _SignUpData _data = new _SignUpData();

  bool _obsecureText = true;
  IconData _passwordIcon = Icons.visibility_off;

  void _togglePassword() {
    setState(() {
      _obsecureText = !_obsecureText;
      if (_passwordIcon == Icons.visibility_off) {
        _passwordIcon = Icons.visibility;
      } else {
        _passwordIcon = Icons.visibility_off;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'E-mail can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
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
                  if (value.isEmpty) {
                    return 'Username can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  /*enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.deepOrange),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
              ),*/
                ),
                onSaved: (String value) {
                  _data.username = value;
                },
                obscureText: _obsecureText,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
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
                decoration: BoxDecoration(
                  color: Color(0xFFF1F2F6),
                  boxShadow: [
                    BoxShadow(color: Color(0xFFDADFF0), offset: Offset(5,3), blurRadius: 4),
                    BoxShadow(color: Colors.white, offset: Offset(-5,-3), blurRadius: 4)
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
