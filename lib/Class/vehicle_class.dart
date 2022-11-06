import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/maintenance_class.dart';

class VehiculeModel extends ChangeNotifier {
  VehiculeModel(
    this.name,
    this.kilometrage,
    this.picturePath,
    this.date,
    this.id,
  );

  factory VehiculeModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final int kilometrage = data['mileage'] as int;
    final String picturePath = data['image'] as String;
    final String date = data['buyDate'] as String;
    final String id = data['_id'] as String;
    return VehiculeModel(
      name,
      kilometrage,
      picturePath,
      date,
      id,
    );
  }

  String name;
  int kilometrage;
  String picturePath;
  String id;
  String date;
  List<maintenanceModel> maintenances =
      List<maintenanceModel>.empty(growable: true);
  Uint8List pickedFileBytes = Uint8List.fromList(<int>[0]);

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

  void updatePicketFilesBytes(Uint8List newVar) {
    pickedFileBytes = newVar;
    notifyListeners();
  }

  void updateDate(String newVar) {
    date = newVar;
    notifyListeners();
  }
}
