import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/page/camera_page.dart';
import 'package:mon_petit_entretien/services/api/modif_user.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';

import '../components/common_text.dart';
import '../style/colors.dart';

class ModifProfilePage extends StatefulWidget {
  const ModifProfilePage({Key? key}) : super(key: key);

  @override
  State<ModifProfilePage> createState() => _ModifProfilePage();
}

class _ModifProfilePage extends State<ModifProfilePage> {
  late String firstname;
  late String lastname;
  late AppData data;
  String image = "";

  bool isLoadingCreate = false;
  bool isLoadedImage = false;
  bool isLoadedVehicule = false;
  bool isThereAnImage = false;
  bool? isSecondary;

  final SnackBar snackBar = SnackBar(
    content: const Text(
      "Tous les champs ne sont pas remplis !",
    ),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Ok',
      textColor: white,
      onPressed: () {},
    ),
  );

  @override
  void initState() {
    super.initState();
    data = Provider.of<AppData>(context, listen: false);
    firstname = data.user.firstName;
    lastname = data.user.lastName;
  }

  void _onFirstNameChange(String newValue) {
    setState(() {
      firstname = newValue;
    });
  }

  void _onLastNameChange(String newValue) {
    setState(() {
      lastname = newValue;
    });
  }

  Future<int> takePictureGaleryLoaded() {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    return takePictureGalery(data);
  }

  Future<int> takePictureGalery(AppData data) async {
    String newPath = '/assets/car.jpg';
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      data.user.updatePicturePath(newPath);
      return 401;
    } else {
      if (kIsWeb) {
        final Uint8List pickedFileBytes = await file.readAsBytes();
        data.user.updatePicketFilesBytes(pickedFileBytes);
        setState(() {
          isThereAnImage = true;
        });
      } else {
        newPath = file.path;
        data.user.updatePicturePath(newPath);
        setState(() {
          isThereAnImage = true;
        });
      }
      return 200;
    }
  }

  void _callApi() async {
    final bool response = await modifProfil(
      data.token,
      firstname,
      lastname,
      data.user.picturePath,
      data.user.pickedFileBytes,
      isThereAnImage,
      data,
    );

    if (response == true) {
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _camera() async {
    await availableCameras().then(
      (
        List<CameraDescription> value,
      ) =>
          Navigator.push(
        context,
        MaterialPageRoute<CameraPage>(
          builder: (_) => CameraPage(
            cameras: value,
          ),
        ),
      ).then((_) {
        AppData data;
        data = Provider.of<AppData>(
          context,
          listen: false,
        );
        if (data.user.picturePath != "") {
          setState(() {
            isThereAnImage = true;
          });
        }
        Navigator.pop(context);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      if (kIsWeb)
                        const CommonText(
                          text: 'Modification du profil',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        )
                      else
                        Column(
                          children: const <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonText(
                                text: 'Modification',
                                fontSizeText: 30,
                                fontWeight: fontLight,
                                paddingTop: 24,
                                paddingBot: 8,
                                color: navy,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonText(
                                text: 'du profil',
                                fontSizeText: 30,
                                fontWeight: fontMedium,
                                paddingBot: 15,
                                color: navy,
                              ),
                            ),
                          ],
                        ),
                      const Align(
                        alignment:
                            kIsWeb ? Alignment.center : Alignment.topLeft,
                        child: CommonText(
                          text: 'Modifier mes informations',
                          fontSizeText: 20,
                          fontWeight: fontLight,
                          paddingBot: 20,
                          color: navy,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 24,
                                            right: 24,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              if (!kIsWeb)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: InkWell(
                                                    onTap: _camera,
                                                    child: Ink(
                                                      child: Row(
                                                        children: const <
                                                            Widget>[
                                                          Icon(
                                                            Icons.camera_alt,
                                                            size: 30,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 10,
                                                            ),
                                                            child: CommonText(
                                                              text: "Caméra",
                                                              fontSizeText: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: navy,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              InkWell(
                                                onTap: () {
                                                  takePictureGaleryLoaded()
                                                      .then((int value) {
                                                    if (value == 200) {}
                                                    setState(() {
                                                      isThereAnImage = true;
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Ink(
                                                  child: Row(
                                                    children: const <Widget>[
                                                      Icon(
                                                        Icons.photo,
                                                        size: 30,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        child: CommonText(
                                                          text: "Galerie",
                                                          fontSizeText: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: navy,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: isThereAnImage
                            ? Center(
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: kIsWeb
                                      ? Image.memory(
                                          Provider.of<AppData>(
                                            context,
                                            listen: false,
                                          ).user.pickedFileBytes,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(
                                            Provider.of<AppData>(
                                              context,
                                              listen: false,
                                            ).user.picturePath,
                                          ),
                                          fit: BoxFit.cover,
                                          frameBuilder: (
                                            BuildContext context,
                                            Widget child,
                                            int? frame,
                                            bool wasSynchronouslyLoaded,
                                          ) {
                                            if (wasSynchronouslyLoaded) {
                                              return const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: navy,
                                                ),
                                              );
                                            }
                                            return child;
                                          },
                                        ),
                                ),
                              )
                            : Align(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  decoration: const BoxDecoration(
                                    color: navy,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Align(
                                    child: Text(
                                      "Ajouter une image",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontFamily: appFont,
                                        fontWeight: fontLight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: firstname,
                            placeholder: firstname,
                            onChangeText: _onFirstNameChange,
                            keyTest: "modif_profile_input_first_name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: lastname,
                            placeholder: lastname,
                            onChangeText: _onLastNameChange,
                            keyTest: "modif_profile_input_last_name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: Button(
                            text: "Sauvegarder",
                            onPress: _callApi,
                            keyTest: "modif_profile_save_button",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: Button(
                            text: "Retour",
                            onPress: () => Navigator.pop(context),
                            secondary: true,
                            keyTest: "modif_profile_come_back_button",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
