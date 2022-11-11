import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<bool> deletedMaintenences(
  String authorization,
  String maintenanceId,
  ) async {
  final http.Response response = await http.delete(
    Uri.parse('$deletedmaintenences/$maintenanceId'),
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