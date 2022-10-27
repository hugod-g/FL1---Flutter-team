import 'package:mon_petit_entretien/Class/vehicleClass.dart';
import 'package:flutter/cupertino.dart';

class appData extends ChangeNotifier {
  List<vehicleData> vehicles = [];

  void addDataVehicle(String newName, int km, String picturePath, String date) {
    vehicles.add(vehicleData({
      'name': newName,
      'kilometrage': km,
      'picturePath': picturePath,
      'date': date
    }));
    notifyListeners();
  }
}
