import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mon_petit_entretien/Class/vehicleClass.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<List<vehiculeModel>> getVehicles(String authorization) async {
  print("le token est $authorization");
  final http.Response response = await http.get(
    Uri.parse(vehiclesEndPoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    },
  );

  if (response.statusCode == 200) {
    // ignore: always_specify_types
    final payload = jsonDecode(response.body);
    var rest = payload as List;
    print("le body est $payload");
    List<vehiculeModel> tmpListVehicule = rest
        .map<vehiculeModel>((json) => vehiculeModel.fromJson(json))
        .toList();
    print("la liste est $tmpListVehicule");
    return tmpListVehicule;
  } else {
    print(
      "l'erreur est ${response.body} et le status code ${response.statusCode}",
    );
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
  print(
    "les arguments sont naùe $name, la date $buyDate, le km $mileage et l'image $upload",
  );

  var request = http.MultipartRequest('POST', Uri.parse(vehiclesEndPoint));
  Map<String, String> headers = {
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
  request.fields.addAll({
    'name': name,
    'buyDate': buyDate,
    'mileage': mileage,
  });
  print("request: " + request.toString());
  var res = await request.send();
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
