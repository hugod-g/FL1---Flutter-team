import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/config/endpoint.dart';

Future<bool> updateKilometrage(
  String authorization,
  String mileage,
  String vehicleId,
  ) async {
  final http.Response response = await http.put(
    Uri.parse(updatekm),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization",
    },
    body: jsonEncode(<String, String>{
      'mileage': mileage,
      'id': vehicleId,
    }),
  );

  inspect(response);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}