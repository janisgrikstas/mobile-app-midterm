import 'package:chatty/services/auth.dart';
import 'package:chatty/services/database.dart';
import 'package:chatty/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthMethods _auth = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  String firstname = '';
  String lastname = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromARGB(255, 255, 246, 251),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 147, 176, 230),
              elevation: 0.0,
              title: Text('sign-up'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      SizedBox(height: 15.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "username"),
                          validator: (value) =>
                              value!.isEmpty ? 'username' : null,
                          onChanged: (value) {
                            setState(() => username = value);
                          }),
                      SizedBox(height: 15.0),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "email"),
                          validator: (value) =>
                              value!.isEmpty ? 'enter an email' : null,
                          onChanged: (value) {
                            setState(() => email = value);
                          }),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "password"),
                        validator: (value) =>
                            value!.isEmpty ? 'enter a password' : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "first name"),
                          validator: (value) =>
                              value!.isEmpty ? 'enter your first name' : null,
                          onChanged: (value) {
                            setState(() => firstname = value);
                          }),
                      SizedBox(height: 15.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "last name"),
                          validator: (value) =>
                              value!.isEmpty ? 'enter your last name' : null,
                          onChanged: (value) {
                            setState(() => lastname = value);
                          }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(169, 147, 176, 230),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerwithEmailAndPassword(email,
                                    password, username, firstname, lastname);
                            if (result == null) {
                              setState(() {
                                error = 'please supply a valid email';
                                loading = false;
                              });
                            } else {
                              
                              DatabaseMethods().addUserInfoToDB(result.uid, email,
                                  username, firstname, lastname).then(
                                    (value) {
                                    Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => Home()));
                                      },
                                    );
                              
                            }
                          }
                        },
                        child: Text('register',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ]))),
          );
  }
}
