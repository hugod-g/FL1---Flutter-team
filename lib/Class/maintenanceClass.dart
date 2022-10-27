import 'package:flutter/cupertino.dart';

class maintenanceData extends ChangeNotifier {
  Map data = {'name': 'Courrois', 'prix': 120, 'date': '01/10/2022'};

  void updateName(newVar) {
    data['name'] = newVar;
    notifyListeners();
  }

  void updatePrix(newVar) {
    data['prix'] = newVar;
    notifyListeners();
  }

  void updateDate(newVar) {
    data['date'] = newVar;
    notifyListeners();
  }

  void updateAccount(input) {
    data = input;
    notifyListeners();
  }
}
