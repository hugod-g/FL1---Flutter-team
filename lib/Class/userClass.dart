import 'package:flutter/cupertino.dart';
import 'package:mon_petit_entretien/Class/centerClass.dart';

class userModel extends ChangeNotifier {
  String lastName = "";
  String firstName = "";
  String username = "";
  List<centerModel> centers = []; // email

  void updateLastName(newVar) {
    lastName = newVar;
    notifyListeners();
  }

  void updateFirstName(newVar) {
    firstName = newVar;
    notifyListeners();
  }

  void updateEmail(newVar) {
    username = newVar;
    notifyListeners();
  }
}
