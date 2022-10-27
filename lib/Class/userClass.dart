import 'package:flutter/cupertino.dart';

class userData extends ChangeNotifier {
  Map data = {'name': 'Marie True', 'email': "email@gmail.com"};

  void updateName(newVar) {
    data['name'] = newVar;
    notifyListeners();
  }

  void updateEmail(newVar) {
    data['email'] = newVar;
    notifyListeners();
  }

  void updateAccount(input) {
    data = input;
    notifyListeners();
  }
}
