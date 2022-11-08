import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<List<dynamic>> addMaintenance(
  String authorization,
  String mileage,
  String date,
  String price,
  String name,
  String center,
  String vehicleId,
  ) async {
  final http.Response response = await http.post(
    Uri.parse(maintenance),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    },
    body: jsonEncode(<String, String>{
      'mileage': mileage,
      'date': date,
      'price': price,
      'name': name,
      'vehicleId': vehicleId,
      'center': center,
    }),
  );

  inspect(response);

  if (response.statusCode == 200) {
    return [];
  } else {
    throw "Il manque des données";
  }
}