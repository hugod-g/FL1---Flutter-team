import 'package:flutter/cupertino.dart';

class centerModel extends ChangeNotifier {
  centerModel(this.name, this.id);

  factory centerModel.fromJson(Map<String, dynamic> data) {
    final String name = data['name'] as String;
    final String id = data['_id'] as String;
    return centerModel(name, id);
  }

  String name = "";
  String id = "";

  void updateName(String newVar) {
    name = newVar;
    notifyListeners();
  }
}
