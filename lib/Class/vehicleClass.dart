import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/maintenanceClass.dart';

class vehiculeModel extends ChangeNotifier {
  String name = "";
  int kilometrage = 0;
  String picturePath = "";
  String id = "";
  String date = "";
  List<maintenanceModel> maintenances = [];

  vehiculeModel(
    this.name,
    this.kilometrage,
    this.picturePath,
    this.date,
    this.id,
  );

  void updateName(newVar) {
    name = newVar;
    notifyListeners();
  }

  void updateKilometrage(newVar) {
    kilometrage = newVar;
    notifyListeners();
  }

  void updatePicturePath(newVar) {
    picturePath = newVar;
    notifyListeners();
  }

  void updateDate(newVar) {
    date = newVar;
    notifyListeners();
  }

  factory vehiculeModel.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final kilometrage = data['mileage'] as int;
    final picturePath = data['image'] as String;
    final date = data['buyDate'] as String;
    final id = data['_id'] as String;
    return vehiculeModel(name, kilometrage, picturePath, date, id);
  }
}
