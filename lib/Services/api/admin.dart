import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<List<UserModel>> getUserListCall(String token) async {
  final http.Response response = await http.get(
    Uri.parse(getUserListEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );

  if (response.statusCode == 200) {
    // ignore: always_specify_types
    final payload = jsonDecode(response.body);
    final rest = payload as List;
    final List<UserModel> userList =
        rest.map<UserModel>((json) => UserModel.fromJson(json)).toList();

    print(payload);
    return userList;
  } else {
    throw "Une erreur est survenu lors la récupération des utilisateurs. Merci de réessayer";
  }
}
