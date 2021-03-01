import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:link/pages/signin.dart';
import 'package:link/pages/signup.dart';

Future<bool> signIn(SignInDB userInfo) async {
  print(userInfo);
  final response = await http.post(
    'http://localhost:3000/login',
    body: {
      'password': '${userInfo.password}',
      'username': '${userInfo.username}',
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body.runtimeType);
    return jsonDecode(response.body);
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
