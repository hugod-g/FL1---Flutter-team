import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mon_petit_entretien/class/vehicle_class.dart';
import 'package:mon_petit_entretien/config/endpoint.dart';

Future<VehiculeModel> getSpeVehicle(
  String token,
  String id,
  ) async {
  final http.Response response = await http.get(
    Uri.parse('$vehiclesEndPoint/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );

  inspect(response);

  if (response.statusCode == 200) {
    final dynamic payload = jsonDecode(response.body);

    final VehiculeModel thisvehicules = VehiculeModel.fromJson(payload);

    return thisvehicules;
  } else {
    throw "Pas de vehicle";
  }
}
