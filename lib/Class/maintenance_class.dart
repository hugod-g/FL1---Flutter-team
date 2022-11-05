import 'package:flutter/cupertino.dart';

class MaintenanceModel extends ChangeNotifier {
  MaintenanceModel(
      this.name, this.kilometrage, this.center, this.date, this.id);
  String name = "";
  String prix = "";
  String center = "";
  String kilometrage = "";
  String date = "";
  String id = "";

  void updateName(String newVar) {
    name = newVar;
    notifyListeners();
  }

  void updatePrix(String newVar) {
    prix = newVar;
    notifyListeners();
  }

  void updateDate(String newVar) {
    date = newVar;
    notifyListeners();
  }
}
