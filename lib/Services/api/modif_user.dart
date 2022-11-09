import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Config/endpoint.dart';

Future<bool> modifProfil(
  String authorization,
  String firstname,
  String lastname,
  String image,
  AppData data,
) async {
  final http.MultipartRequest request =
      http.MultipartRequest('PUT', Uri.parse(getProfileEndPoint));
  final Map<String, String> headers = <String, String>{
    "HttpHeaders.contentTypeHeader": "application/json",
    "Authorization": "Bearer $authorization",
    "Content-type": "multipart/form-data"
  };
  request.files.add(
    http.MultipartFile(
      'upload',
      File(image).readAsBytes().asStream(),
      File(image).lengthSync(),
      filename: "filename",
      contentType: MediaType('image', 'jpeg'),
    ),
  );
  request.headers.addAll(headers);
  request.fields.addAll(<String, String>{
    'firstname': firstname,
    'lastname': lastname,
  });
  final http.StreamedResponse response = await request.send();

  inspect(response);

  if (response.statusCode == 200) {
    data.user.updateFirstName(firstname);
    data.user.updateLastName(lastname);
    return true;
  } else {
    return false;
  }
}