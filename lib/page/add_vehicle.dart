import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/common_text.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/page/camera_page.dart';
import 'package:mon_petit_entretien/services/api/vehicule.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';

import '../style/colors.dart';

class AddVehicule extends StatefulWidget {
  const AddVehicule({Key? key}) : super(key: key);

  @override
  State<AddVehicule> createState() => _AddVehicule();
}

class _AddVehicule extends State<AddVehicule> {
  String kilometer = "";
  String name = "";
  String date = "";
  TextEditingController dateinput = TextEditingController();
  String image = "";

  bool isLoadingCreate = false;
  bool isLoadedImage = false;
  bool isLoadedVehicule = false;
  bool isThereAnImage = false;
  bool? isSecondary;

  void _onKMChange(String newValue) {
    setState(() {
      kilometer = newValue;
    });
  }

  void _onNameChange(String newValue) {
    setState(() {
      name = newValue;
    });
  }

  void _onDateChange(String newValue) {
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
      if (kIsWeb) {
        final Uint8List pickedFileBytes = await file.readAsBytes();
        data.vehicles.last.updatePicketFilesBytes(pickedFileBytes);
      } else {
        newPath = file.path;
        data.vehicles.last.updatePicturePath(newPath);
      }
      return 200;
    }
  }

  void _onAddVehicule() {
    if (isLoadedVehicule) {
      return;
    }

    AppData data;
    data = Provider.of<AppData>(context, listen: false);

    if (kIsWeb) {
      if (data.token == "" ||
          name == "" ||
          date == "" ||
          kilometer == "" ||
          data.vehicles.last.pickedFileBytes == Uint8List.fromList(<int>[0])) {
        final SnackBar snackBar = SnackBar(
          content: const Text(
            "Tout les champs ne sont pas remplis !",
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Ok',
            textColor: white,
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          isLoadedVehicule = true;
        });

        _onAddVehiculeAsync(data).then((int response) {
          if (response == 200) {
            data.vehicles.removeLast();
            setState(() {
              isThereAnImage = false;
            });

            Navigator.pop(context);
          } else {
            const SnackBar snackBar = SnackBar(
              content: Text('Le véhicule n\'a pas pu être ajouté'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          setState(() {
            isLoadedVehicule = false;
            isSecondary = null;
          });
        });
      }
    } else {
      if (data.token == "" ||
          name == "" ||
          date == "" ||
          kilometer == "" ||
          data.vehicles.last.picturePath == "") {
        final SnackBar snackBar = SnackBar(
          content: const Text(
            "Tout les champs ne sont pas remplis !",
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Ok',
            textColor: white,
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          isLoadedVehicule = true;
        });

        _onAddVehiculeAsync(data).then((int response) {
          if (response == 200) {
            data.vehicles.removeLast();
            setState(() {
              isThereAnImage = false;
            });
            Navigator.pop(context);
          } else {
            const SnackBar snackBar = SnackBar(
              content: Text('Le véhicule n\'a pas pu être ajouté'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          setState(() {
            isLoadedVehicule = false;
            isSecondary = null;
          });
        });
      }
    }
  }

  Future<int> _onAddVehiculeAsync(AppData data) async {
    final int response = await createVehicle(
      data.token,
      name,
      date,
      kilometer,
      data.vehicles.last.picturePath,
      data.vehicles.last.pickedFileBytes,
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

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    dateinput.text = "";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppData>(context, listen: false).addDataVehicle(
        "tmp",
        0,
        "",
        DateTime.now().toString(),
        '0',
        List<MaintenanceModel>.empty(growable: true),
      );
      isThereImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Material(
          color: lightBlue,
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {
                          if (Provider.of<AppData>(context, listen: false)
                                      .vehicles
                                      .last
                                      .name ==
                                  "tmp" &&
                              Provider.of<AppData>(context, listen: false)
                                      .vehicles
                                      .last
                                      .kilometrage ==
                                  0) {
                            Provider.of<AppData>(context, listen: false)
                                .vehicles
                                .removeLast();
                          }
                          Navigator.pop(context);
                        },
                        color: navy,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const CommonText(
                        text: "Nouveau",
                        fontSizeText: 30,
                        fontWeight: fontLight,
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
                        text: "Ajouter un véhicule",
                        fontSizeText: 20,
                        fontWeight: fontLight,
                        paddingBot: 20,
                        color: navy,
                      ),
                      GestureDetector(
                        key: const Key("add_image_button"),
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                child: InkWell(
                                                  key: const Key(
                                                    "camera_button",
                                                  ),
                                                  onTap: () async {
                                                    await availableCameras()
                                                        .then(
                                                      (
                                                        List<CameraDescription>
                                                            value,
                                                      ) =>
                                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute<
                                                            CameraPage>(
                                                          builder: (_) =>
                                                              CameraPage(
                                                            cameras: value,
                                                          ),
                                                        ),
                                                      ).then((_) {
                                                        AppData data;
                                                        data = Provider.of<
                                                            AppData>(
                                                          context,
                                                          listen: false,
                                                        );
                                                        if (data.vehicles.last
                                                                .picturePath !=
                                                            "") {
                                                          setState(() {
                                                            isThereAnImage =
                                                                true;
                                                          });
                                                        }
                                                        Navigator.pop(context);
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
                                                              EdgeInsets.only(
                                                            left: 10,
                                                          ),
                                                          child: CommonText(
                                                            text: "Camera",
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
                                          ).vehicles.last.pickedFileBytes,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(
                                            Provider.of<AppData>(
                                              context,
                                              listen: false,
                                            ).vehicles.last.picturePath,
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
                      if (kIsWeb)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 16),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: TextInput(
                                value: name,
                                placeholder: "Nom",
                                onChangeText: _onNameChange,
                                keyTest: "add_vehicule_input_name",
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 16),
                          child: TextInput(
                            value: name,
                            placeholder: "Nom",
                            onChangeText: _onNameChange,
                            keyTest: "add_vehicule_input_name",
                          ),
                        ),
                      if (kIsWeb)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 16),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: TextInput(
                                value: kilometer,
                                placeholder: "Kilométrage (en km)",
                                onChangeText: _onKMChange,
                                keyTest: "add_vehicule_input_km",
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          child: TextInput(
                            value: kilometer,
                            placeholder: "Kilométrage (en km)",
                            onChangeText: _onKMChange,
                            textinput: TextInputType.number,
                            keyTest: "add_vehicule_input_km",
                          ),
                        ),
                      if (kIsWeb)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 16),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: Container(
                                height: 54,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(blurRadius: 16, color: lightGray)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 2,
                                    ),
                                    child: Center(
                                      child: TextField(
                                        key: const Key(
                                          "add_vehicule_input_date",
                                        ),
                                        controller: dateinput,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          iconColor: navy,
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "Date d'achat",
                                          labelStyle: TextStyle(color: navy),
                                          hintStyle: TextStyle(
                                            color: lightGray,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontFamily: appFont,
                                          fontWeight: fontRegular,
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          final DateTime? pickedDate =
                                              await showDatePicker(
                                            initialEntryMode:
                                                DatePickerEntryMode.input,
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                              2000,
                                            ),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null) {
                                            final String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);

                                            setState(() {
                                              dateinput.text = formattedDate;
                                              _onDateChange(dateinput.text);
                                            });
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          child: Container(
                            height: 54,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(blurRadius: 16, color: lightGray)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 2,
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: dateinput,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      iconColor: navy,
                                      icon: Icon(Icons.calendar_today),
                                      labelText: "Date d'achat",
                                      labelStyle: TextStyle(color: navy),
                                      hintStyle: TextStyle(
                                        color: lightGray,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: appFont,
                                      fontWeight: fontRegular,
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                          2000,
                                        ),
                                        lastDate: DateTime(2101),
                                      );

                                      if (pickedDate != null) {
                                        final String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        setState(() {
                                          dateinput.text = formattedDate;
                                          _onDateChange(dateinput.text);
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (kIsWeb)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: Container(
                                width: double.infinity,
                                height: 54,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  color: navy,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(blurRadius: 16, color: lightGray)
                                  ],
                                ),
                                child: Button(
                                  text: "Ajouter véhicule",
                                  onPress: _onAddVehicule,
                                  isLoading: isLoadedVehicule,
                                  keyTest: "add_vehicule_button",
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: navy,
                              boxShadow: <BoxShadow>[
                                BoxShadow(blurRadius: 16, color: lightGray)
                              ],
                            ),
                            child: Button(
                              text: "Ajouter véhicule",
                              onPress: _onAddVehicule,
                              isLoading: isLoadedVehicule,
                              keyTest: "add_vehicule_button",
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
