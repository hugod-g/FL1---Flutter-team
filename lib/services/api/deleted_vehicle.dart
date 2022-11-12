import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/config/endpoint.dart';

Future<bool> deletedVehicle(
  String authorization,
  String id,
  ) async {
  final http.Response response = await http.delete(
    Uri.parse('$vehiclesEndPoint/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization",
    },
  );

  inspect(response);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}