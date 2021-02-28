import 'package:flutter/material.dart';
import 'package:link/components/themetextfeild.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                text: 'First Name',
                onChanged: (v) => null,
              ),
              ThemedTextField(
                text: 'Last Name',
                onChanged: (v) => null,
              ),
              Divider(),
              ThemedTextField(
                text: 'Username',
                onChanged: (v) => null,
              ),
              ThemedTextField(
                text: 'Password',
                onChanged: (v) => null,
              ),
              ThemedTextField(
                text: 'Confirm Password',
                onChanged: (v) => null,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("sign up"),
                      onPressed: null,
                    )),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
