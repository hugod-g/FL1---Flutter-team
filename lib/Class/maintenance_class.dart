import 'package:flutter/cupertino.dart';

class maintenanceModel extends ChangeNotifier {
  maintenanceModel(
      this.name, this.kilometrage, this.center, this.date, this.id);
  String name = "";
  String prix = "";
  String center = "";
  String kilometrage = "";
  String date = "";
  String id = "";

  void updateName(newVar) {
    name = newVar;
    notifyListeners();
  }

  void updatePrix(newVar) {
    prix = newVar;
    notifyListeners();
  }

  void updateDate(newVar) {
    date = newVar;
    notifyListeners();
  }
}
