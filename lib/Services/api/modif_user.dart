import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<bool> modifProfil(
  String authorization,
  String firstname,
  String lastname,
  AppData data,
  ) async {
  final http.Response response = await http.put(
    Uri.parse(getProfileEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization",
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
    }),
  );

  inspect(response);

  if (response.statusCode == 200) {
    data.user.updateFirstName(firstname);
    data.user.updateLastName(lastname);
    return true;
  } else {
    return false;
  }
}