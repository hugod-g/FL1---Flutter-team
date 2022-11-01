import 'package:flutter/cupertino.dart';

class centerModel extends ChangeNotifier {
  centerModel(this.name, this.id);
  String name = "";
  String id = "";

  void updateName(newVar) {
    name = newVar;
    notifyListeners();
  }
}
