import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/center_class.dart';

class UserModel extends ChangeNotifier {
  UserModel(
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.admin,
    this.centers,
  );

  factory UserModel.fromJson(Map<String, dynamic> data) {
    final String firstName = data['firstname'] as String;
    final String id = data['_id'] as String;
    final String lastName = data['lastname'] as String;
    final String username = data['username'] as String;
    final bool admin = data['admin'] as bool;
    final List<dynamic> centersTmp = data['centers'] as List<dynamic>;

    final List<centerModel> centers = centersTmp
        .map<centerModel>((dynamic json) => centerModel.fromJson(json))
        .toList();

    return UserModel(id, firstName, lastName, username, admin, centers);
  }

  String lastName = "";
  String firstName = "";
  String username = "";
  bool admin = false;
  String id = "";
  List<centerModel> centers = List<centerModel>.empty();

  void updateLastName(String newVar) {
    lastName = newVar;
    notifyListeners();
  }

  void updateFirstName(String newVar) {
    firstName = newVar;
    notifyListeners();
  }

  void updateEmail(String newVar) {
    username = newVar;
    notifyListeners();
  }
}