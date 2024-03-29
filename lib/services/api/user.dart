import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/class/user_class.dart';
import 'package:mon_petit_entretien/config/endpoint.dart';

Future<UserModel> getProfileCall(String token) async {
  final http.Response response = await http.get(
    Uri.parse(getProfileEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );

  if (response.statusCode == 200) {
    final dynamic payload = jsonDecode(response.body);

    final UserModel profile = UserModel.fromJson(payload);

    return profile;
  } else {
    throw "Une erreur est survenu lors de votre inscription. Merci de réessayer";
  }
}
