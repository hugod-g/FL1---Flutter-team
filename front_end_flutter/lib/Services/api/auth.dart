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

Future<int> registerCall(
  String email,
  String password,
  String firstname,
  String lastname,
) async {
  final http.Response response = await http.post(
    Uri.parse(registerEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    }),
  );

  if (response.statusCode == 200) {
    final payload = jsonDecode(response.body);

    // String token = payload["token"];
    // String refreshToken = payload["refresh"];
  } else {
    throw "Une erreur est survenu lors de votre inscription. Merci de réessayer";
  }

  return response.statusCode;
}
