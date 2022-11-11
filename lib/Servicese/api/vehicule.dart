import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mon_petit_entretien/class/vehicle_class.dart';
import 'package:mon_petit_entretien/config/endpoint.dart';

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
  String upload,
  Uint8List pickedFileBytes,
) async {
  final http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(vehiclesEndPoint));
  final Map<String, String> headers = <String, String>{
    "HttpHeaders.contentTypeHeader": "application/json",
    "Authorization": "Bearer $authorization",
    "Content-type": "multipart/form-data"
  };
  if (upload != "") {
    request.files.add(
      http.MultipartFile(
        'upload',
        File(upload).readAsBytes().asStream(),
        File(upload).lengthSync(),
        filename: "filename",
        contentType: MediaType('image', 'jpeg'),
      ),
    );
  } else {
    request.files.add(
      http.MultipartFile.fromBytes(
        'upload',
        pickedFileBytes,
        filename: "filename",
        contentType: MediaType('image', 'jpeg'),
      ),
    );
  }

  request.headers.addAll(headers);
  request.fields.addAll(<String, String>{
    'name': name,
    'buyDate': buyDate,
    'mileage': mileage,
  });
  final http.StreamedResponse res = await request.send();

  if (res.statusCode == 200) {
    return 200;
  } else {
    throw "le véhicule n'est pas ajouté";
  }
}
