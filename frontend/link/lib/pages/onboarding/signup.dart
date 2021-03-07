import 'package:flutter/material.dart';
import 'package:link/components/themetextfeild.dart';
import 'package:link/models/postuser.dart';

class UserInfo {
  String name, username, password;
  UserInfo({this.name, this.username, this.password});
}

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  UserInfo userInfo;
  String password2;
  @override
  Widget build(BuildContext context) {
    userInfo = new UserInfo();

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/logo-placeholder.png',
                  ),
                ),
              ),
              ThemedTextField(
                text: 'Full Name',
                onChanged: (v) => userInfo.name = v,
              ),
              Divider(),
              ThemedTextField(
                text: 'Username',
                onChanged: (v) => userInfo.username = v,
              ),
              ThemedTextField(
                text: 'Password',
                onChanged: (v) => userInfo.password = v,
              ),
              ThemedTextField(
                text: 'Confirm Password',
                onChanged: (v) => password2 = v,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("sign up"),
                      onPressed: () async {
                        print(userInfo.password);
                        print(password2);
                        if (userInfo.password == password2) {
                          await postUser(userInfo);
                          Navigator.pop(context);
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
