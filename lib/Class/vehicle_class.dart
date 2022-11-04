import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/maintenance_class.dart';

class vehiculeModel extends ChangeNotifier {
  vehiculeModel(
    this.name,
    this.kilometrage,
    this.picturePath,
    this.date,
    this.id,
  );

  factory vehiculeModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final int kilometrage = data['mileage'] as int;
    final String picturePath = data['image'] as String;
    final String date = data['buyDate'] as String;
    final String id = data['_id'] as String;
    return vehiculeModel(name, kilometrage, picturePath, date, id);
  }

  String name = "";
  int kilometrage = 0;
  String picturePath = "";
  String id = "";
  String date = "";
  List<maintenanceModel> maintenances = [];

  void updateName(String newVar) {
    name = newVar;
    notifyListeners();
  }

  void updateKilometrage(int newVar) {
    kilometrage = newVar;
    notifyListeners();
  }

  void updatePicturePath(String newVar) {
    picturePath = newVar;
    notifyListeners();
  }

  void updateDate(String newVar) {
    date = newVar;
    notifyListeners();
  }
}
