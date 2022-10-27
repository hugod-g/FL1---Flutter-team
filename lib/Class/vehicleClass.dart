import 'package:flutter/cupertino.dart';

class vehicleData extends ChangeNotifier {
  Map data = {
    'name': 'Lambor',
    'kilometrage': 90250,
    'picturePath': '/assets/car.jpg',
    'date': '01/10/2022'
  };

  vehicleData(this.data);

  void updateName(newVar) {
    data['name'] = newVar;
    notifyListeners();
  }

  void updateKilometrage(newVar) {
    data['kilometrage'] = newVar;
    notifyListeners();
  }

  void updatePicturePath(newVar) {
    data['picturePath'] = newVar;
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
