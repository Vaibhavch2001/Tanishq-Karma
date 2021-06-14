import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginUser {
  String email, password;
  LoginUser(this.email, this.password);
  Future<dynamic> postInfo() async {
    print("hello");
    print(email);
    print(password);

    http.Response response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{"email": email, "password": password},
      ),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['token']);
    } else {
      throw ("user not registered");
    }
  }
}
