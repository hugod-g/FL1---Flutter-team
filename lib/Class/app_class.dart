import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/center_class.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Class/vehicle_class.dart';

class AppData extends ChangeNotifier {
  List<VehiculeModel> vehicles = List<VehiculeModel>.empty(growable: true);
  String token = "";
  UserModel user = UserModel("", "", "", "", false, List<CenterModel>.empty());
  List<UserModel> usersList = List<UserModel>.empty();

  void addDataVehicle(
    String newName,
    int km,
    String picturePath,
    String date,
    String id,
  ) {
    vehicles.add(VehiculeModel(newName, km, picturePath, date, id));
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
