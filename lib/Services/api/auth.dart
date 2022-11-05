import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<int> loginCall(
  String email,
  String password,
  AppData data,
) async {
  final SharedPreferences prefs = await _prefs;

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
    final dynamic payload = jsonDecode(response.body);

    final String token = payload["token"];
    data.token = token;
    await prefs.setString('token', token);
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
  AppData data,
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
    await loginCall(email, password, data);
  } else {
    throw "Une erreur est survenu lors de votre inscription. Merci de réessayer";
  }

  return response.statusCode;
}
