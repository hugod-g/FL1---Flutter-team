import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mon_petit_entretien/Class/vehicle_class.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<List<VehiculeModel>> getVehicles(String authorization) async {
  final http.Response response = await http.get(
    Uri.parse(vehiclesEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    },
  );

  if (response.statusCode == 200) {
    final dynamic payload = jsonDecode(response.body);
    final List<dynamic> rest = payload as List<dynamic>;
    final List<VehiculeModel> tmpListVehicule = rest
        .map<VehiculeModel>((dynamic json) => VehiculeModel.fromJson(json))
        .toList();

    return tmpListVehicule;
  } else {
    throw "les véhicules ne sont pas chargés";
  }
}

Future<int> createVehicle(
  String authorization,
  String name,
  String buyDate,
  String mileage,
  File upload,
) async {
  final http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(vehiclesEndPoint));
  final Map<String, String> headers = {
    "Authorization": "Bearer $authorization",
    "Content-type": "multipart/form-data"
  };
  request.files.add(
    http.MultipartFile(
      'upload',
      upload.readAsBytes().asStream(),
      upload.lengthSync(),
      filename: "filename",
      contentType: MediaType('image', 'jpeg'),
    ),
  );
  request.headers.addAll(headers);
  request.fields.addAll(<String, String>{
    'name': name,
    'buyDate': buyDate,
    'mileage': mileage,
  });
  final http.StreamedResponse res = await request.send();
  /*final http.Response response = await http.post(
    Uri.parse(vehiclesEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'buyDate': buyDate,
      'mileage': mileage,
      'upload': upload,
    }),
  );*/

  if (res.statusCode == 200) {
    print(
      "le res est ${res.stream} et le status code ${res.statusCode}",
    );
  } else {
    print(
      "l'erreur est ${res.stream} et le status code ${res.statusCode}",
    );
    throw "le véhicule n'est pas ajouté";
  }

  return res.statusCode;
}
