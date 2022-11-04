import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/camera_page.dart';
import 'package:mon_petit_entretien/Page/home.dart';
import 'package:mon_petit_entretien/Services/api/vehicule.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';

import '../Style/colors.dart';

class AddVehicule extends StatefulWidget {
  const AddVehicule({Key? key}) : super(key: key);

  @override
  State<AddVehicule> createState() => _AddVehicule();
}

class _AddVehicule extends State<AddVehicule> {
  String kilometer = "";
  String name = "";
  String date = "";
  String image = "";

  bool isThereAnImage = false;

  void _onKMChange(String newValue) async {
    setState(() {
      kilometer = newValue;
    });
  }

  void _onNameChange(String newValue) async {
    setState(() {
      name = newValue;
    });
  }

  void _onDateChange(String newValue) async {
    setState(() {
      date = newValue;
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
      data.vehicles.last.updatePicturePath(newPath);
      return 401;
    } else {
      newPath = file.path;
      data.vehicles.last.updatePicturePath(newPath);
      return 200;
    }
  }

  void _onAddVehicule() {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);

    _onAddVehiculeAsync(data).then((int response) {
      if (response == 200) {
        data.vehicles.removeLast();
        setState(() {
          isThereAnImage = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Home>(
            builder: (BuildContext context) => const Home(),
          ),
          (Route route) => false,
        );
      } else {
        const SnackBar snackBar = SnackBar(
          content: Text('Le véhicule n\'a pas pu être ajouté'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Future<int> _onAddVehiculeAsync(AppData data) async {
    final int response = await createVehicle(
      data.token,
      name,
      date,
      kilometer,
      data.vehicles.last.picturePath,
    );

    if (response == 200) {
      return 200;
    } else {}
    return 500;
  }

  void isThereImage() {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.vehicles.isNotEmpty) {
      if (appData.vehicles.last.picturePath != "") {
        setState(() {
          isThereAnImage = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppData>(context, listen: false).addDataVehicle(
        "tmp",
        0,
        "",
        DateTime.now().toString(),
        '0',
      );
      isThereImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlue,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CommonText(
                text: "Nouveau",
                fontSizeText: 30,
                fontWeight: fontLight,
                paddingTop: 20,
                paddingBot: 8,
                color: navy,
              ),
              const CommonText(
                text: "Véhicule",
                fontSizeText: 30,
                fontWeight: fontMedium,
                paddingBot: 15,
                color: navy,
              ),
              const CommonText(
                text: "Ajoutez un véhicule",
                fontSizeText: 20,
                fontWeight: fontLight,
                paddingBot: 20,
                color: navy,
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
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            await availableCameras().then(
                                              (List<CameraDescription> value) =>
                                                  Navigator.push(
                                                context,
                                                // ignore: always_specify_types
                                                MaterialPageRoute(
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
                                                if (data.vehicles.last
                                                        .picturePath !=
                                                    "") {
                                                  setState(() {
                                                    isThereAnImage = true;
                                                  });
                                                }
                                              }),
                                            );
                                          },
                                          child: Ink(
                                            child: Row(
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.camera_alt,
                                                  size: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: CommonText(
                                                    text: "Camera",
                                                    fontSizeText: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    EdgeInsets.only(left: 10),
                                                child: CommonText(
                                                  text: "Galerie",
                                                  fontSizeText: 20,
                                                  fontWeight: FontWeight.normal,
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
                          child: Image.file(
                            File(
                              Provider.of<AppData>(context, listen: false)
                                  .vehicles
                                  .last
                                  .picturePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Align(
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.25,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: const BoxDecoration(
                            color: navy,
                            shape: BoxShape.circle,
                          ),
                          child: const Align(
                            child: Text(
                              "Ajoutez une image",
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
                padding: const EdgeInsets.only(top: 20, bottom: 16),
                child: TextInput(
                  value: name,
                  placeholder: "Nom",
                  onChangeText: _onNameChange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextInput(
                  value: kilometer,
                  placeholder: "Kilométrage",
                  onChangeText: _onKMChange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextInput(
                  value: date,
                  placeholder: "Date d'achat",
                  onChangeText: _onDateChange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Button(
                  text: "Ajoutez le véhicule",
                  onPress: _onAddVehicule,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
