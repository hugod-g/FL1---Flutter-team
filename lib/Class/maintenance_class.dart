import 'package:flutter/cupertino.dart';

class maintenanceModel extends ChangeNotifier {
  maintenanceModel(
    this.name,
    this.kilometrage,
    this.center,
    this.date,
    this.id,
    this.prix,
  );

  factory maintenanceModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final int kilometrage = data['mileage'] as int;
    final String center = data['center'] as String;
    final String date = data['date'] as String;
    final String id = data['_id'] as String;
    final int prix = data['price'] as int;
    return maintenanceModel(name, kilometrage, center, date, id, prix);
  }

  String name = "";
  int prix = 0;
  String center = "";
  int kilometrage = 0;
  String date = "";
  String id = "";

  void updateName(String newVar) {
    name = newVar;
    notifyListeners();
  }

  void updatePrix(int newVar) {
    prix = newVar;
    notifyListeners();
  }

  void updateDate(String newVar) {
    date = newVar;
    notifyListeners();
  }
}
