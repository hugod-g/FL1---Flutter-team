import 'package:flutter/cupertino.dart';

class userModel extends ChangeNotifier {
  String lastName = "";
  String firstName = "";
  String username = ""; // email

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
