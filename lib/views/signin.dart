import 'package:chatty/helper/constants.dart';
import 'package:chatty/views/home.dart';
import 'package:chatty/views/register.dart';
import 'package:flutter/material.dart';
import 'package:chatty/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthMethods auth = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 147, 176, 230),
          title: Text(
            "chatty",
            style: TextStyle(
              fontFamily: 'type',
            ),
          ),
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/appbackground.jpeg"),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (value) =>
                          value!.isEmpty ? 'enter an email' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'password'),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'enter a password' : null,
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 88, 139, 233),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await auth.signInwithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'could not sign in with those credentials';
                            loading = false;
                          });
                        } else {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                        }
                      }
                    },
                    child:
                        Text('sign in', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(211, 110, 149, 223),
                    ),
                    onPressed: () async {
                      AuthMethods().signInWithGoogle(context);
                    },
                    child: Text('sign in with google',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 12.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(151, 147, 176, 230),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text('need to register?',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ]))));
  }
}
