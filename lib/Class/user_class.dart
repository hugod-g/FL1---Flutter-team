import 'package:flutter/foundation.dart';
import 'package:mon_petit_entretien/Class/center_class.dart';

class UserModel extends ChangeNotifier {
  UserModel(
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.admin,
    this.picturePath,
    this.centers,
  );

  factory UserModel.fromJson(Map<String, dynamic> data) {
    final String firstName = data['firstname'] as String;
    final String id = data['_id'] as String;
    final String lastName = data['lastname'] as String;
    final String username = data['username'] as String;
    final bool admin = data['admin'] as bool;
    final String? picturePath = data['image'] as String?;
    final List<dynamic> centersTmp = data['centers'] as List<dynamic>;

    final List<CenterModel> centers = centersTmp
        .map<CenterModel>((dynamic json) => CenterModel.fromJson(json))
        .toList();

    return UserModel(
      id,
      firstName,
      lastName,
      username,
      admin,
      picturePath ?? "",
      centers,
    );
  }

  String lastName = "";
  String firstName = "";
  String username = "";
  bool admin = false;
  String picturePath;
  String id = "";
  List<CenterModel> centers = List<CenterModel>.empty();
  Uint8List pickedFileBytes = Uint8List.fromList(<int>[0]);

  void updateLastName(String newVar) {
    lastName = newVar;
    notifyListeners();
  }

  void updateFirstName(String newVar) {
    firstName = newVar;
    notifyListeners();
  }

  void updatePicturePath(String newVar) {
    picturePath = newVar;
    notifyListeners();
  }

  void updatePicketFilesBytes(Uint8List newVar) {
    pickedFileBytes = newVar;
    notifyListeners();
  }

  void updateEmail(String newVar) {
    username = newVar;
    notifyListeners();
  }
}
