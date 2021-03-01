import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:link/components/signin.dart';
import 'package:link/pages/map.dart';
import 'package:link/pages/signup.dart';

class SignInDB {
  String name, username, password;
  SignInDB({this.username, this.password});
}

class SignIn extends StatelessWidget {
  SignInDB signin;

  @override
  Widget build(BuildContext context) {
    signin = new SignInDB();

    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Image.asset('assets/images/logo-placeholder.png'),
          TextField(
            onChanged: (v) => signin.username = v,
            decoration: InputDecoration(
              hintText: 'Username',
              prefixIcon: Icon(Icons.account_box),
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
            ),
          ),
          TextField(
            onChanged: (v) => signin.password = v,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  var data = await signIn(signin);
                  if (data['signin'] == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapPage(
                                data: data,
                              )),
                    );
                  }
                },
                child: Text('Log In'),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              print('test');
            },
            child: Text("Forgot your password"),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey[500]),
            ),
          ),
          Expanded(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account"),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[500]),
                ),
                child: Text("Create One"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
              )
            ],
          ),
        ],
      ),
    )));
  }
}
