import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class _SignUpData {
  String email = '';
  String username = '';
  String password = '';
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF26282B),
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

  void _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _data.email,
      password: _data.password,
    ))
        .user;
    if (user != null) {
      print("Success");
      Firestore.instance.document('users/'+user.uid).setData(<String,dynamic>{
                                    'email': user.email,
                                    'username': _data.username,});

      Navigator.pop(context);
    } else {
      print("error");
    }
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
                    return 'E-mail can\'t be provera';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'E-mailaa',
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
                      color: Theme.of(context).primaryColor,
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
                  color: Color(0xFF26282B),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF1B1C1D),
                        offset: Offset(5, 5),
                        blurRadius: 11),
                    BoxShadow(
                        color: Color(0xCC2F3136),
                        offset: Offset(-5, -5),
                        blurRadius: 11)
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(_data.email);
                      print(_data.password);
                      _register();
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
