import 'dart:convert';

import 'package:front_end_flutter/Config/endpoint.dart';
import 'package:http/http.dart' as http;

Future<int> loginCall(String email, String password) async {
  final http.Response response = await http.post(
    Uri.parse(loginEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final payload = jsonDecode(response.body);

    // String token = payload["token"];
    // String refreshToken = payload["refresh"];
  } else {
    throw "Email ou mot de passe incorrect";
  }

  return response.statusCode;
}

void registerCall(
    String email, String password, String firstname, String lastname) async {
  print("$email $password $firstname $lastname");
  final http.Response response = await http.post(
    Uri.parse(loginEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname
    }),
  );

  print(jsonDecode(response.body));

  // print(response.);

  // if (response.statusCode == 200) {
  // } else {
  //   throw Exception("Email ou mot de passe incorrect");
  // }
}
