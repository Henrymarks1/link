import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:link/pages/signup.dart';

Future<void> postUser(UserInfo userInfo) async {
  print(userInfo.name);
  print(userInfo.password);
  print(userInfo.username);
  return http.post(
    'http://localhost:3000/signup',
    body: {
      'password': '${userInfo.password}',
      'username': '${userInfo.username}',
      'name': '${userInfo.name}'
    },
  );
}
