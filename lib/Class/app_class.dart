import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/class/center_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/class/user_class.dart';
import 'package:mon_petit_entretien/class/vehicle_class.dart';

class AppData extends ChangeNotifier {
  List<VehiculeModel> vehicles = List<VehiculeModel>.empty(growable: true);
  VehiculeModel thisVehicles = VehiculeModel(
    "Not found",
    0,
    "assets/car.jpg",
    "00-00-0000",
    "none",
    List<MaintenanceModel>.empty(growable: true),
  );
  String token = "";
  UserModel user = UserModel(
    "",
    "",
    "",
    "",
    false,
    "",
    List<CenterModel>.empty(growable: true),
  );
  List<UserModel> usersList = List<UserModel>.empty();

  void addDataVehicle(
    String newName,
    int km,
    String picturePath,
    String date,
    String id,
    List<MaintenanceModel> maintenances,
  ) {
    vehicles
        .add(VehiculeModel(newName, km, picturePath, date, id, maintenances));
    notifyListeners();
  }

  void updateDataThisVehicle(
    String newName,
    int km,
    String picturePath,
    String date,
    String id,
    List<MaintenanceModel> maintenances,
  ) {
    thisVehicles.updateName(newName);
    thisVehicles.updateKilometrage(km);
    thisVehicles.updatePicturePath(picturePath);
    thisVehicles.updateDate(date);
    thisVehicles.updateId(id);
    thisVehicles.updateMaintenance(maintenances);
    notifyListeners();
  }

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void setUser(UserModel newUser) {
    user = newUser;
    notifyListeners();
  }

  void setUsersList(List<UserModel> newList) {
    usersList = newList;
    notifyListeners();
  }
}
