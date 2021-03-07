import 'dart:convert';

import 'package:http/http.dart';

class User {
  String name;
  String username;
  bool available;
  String id;
  User(this.name, this.username, this.available, this.id);
}

class Friend {
  final client = Client();
  Future<List<User>> fetchSuggestions(String input) async {
    final response = await client.post(
      'http://localhost:3000/getusersbyname',
      body: {
        'name': '$input',
      },
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      List<User> res = result['user']
          .map<User>(
              (p) => User(p['name'], p['username'], p['available'], p['id']))
          .toList();

      return res;
    } else {
      print(response.statusCode);
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
