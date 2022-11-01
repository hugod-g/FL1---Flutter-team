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
    final dynamic payload = jsonDecode(response.body);
    final List<dynamic> rest = payload as List<dynamic>;
    final List<UserModel> userList = rest
        .map<UserModel>((dynamic json) => UserModel.fromJson(json))
        .toList();

    return userList;
  } else {
    throw "Une erreur est survenu lors la récupération des utilisateurs. Merci de réessayer";
  }
}

Future<int> upgradeUserAdminCall(
  String token,
  String userId,
) async {
  final http.Response response = await http.put(
    Uri.parse(promoteUserEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, String>{
      'userId': userId,
    }),
  );

  return response.statusCode;
}

Future<int> deleteUserAdminCall(
  String token,
  String userId,
) async {
  final http.Response response = await http.delete(
    Uri.parse(deleteUserEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, String>{
      'userId': userId,
    }),
  );

  return response.statusCode;
}
