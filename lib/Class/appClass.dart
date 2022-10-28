import 'package:mon_petit_entretien/Class/userClass.dart';
import 'package:mon_petit_entretien/Class/vehicleClass.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  List<vehiculeModel> vehicles = [];
  String token = "";
  userModel user = userModel();

  void addDataVehicle(
    String newName,
    int km,
    String picturePath,
    String date,
    String id,
  ) {
    vehicles.add(vehiculeModel(newName, km, picturePath, date, id));
    notifyListeners();
  }
}
