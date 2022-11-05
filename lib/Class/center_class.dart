import 'package:flutter/cupertino.dart';

class CenterModel extends ChangeNotifier {
  CenterModel(this.name, this.id);

  factory CenterModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final String id = data['_id'] as String;
    return CenterModel(name, id);
  }

  String name = "";
  String id = "";

  void updateName(newVar) {
    name = newVar;
    notifyListeners();
  }
}
