import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:mon_petit_entretien/Components/photo_input.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
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

  void _onAddVehicule() async {
    await createVehicle(
      Provider.of<AppData>(context, listen: false).token,
      name,
      date,
      kilometer,
      File(
        Provider.of<AppData>(context, listen: false).vehicles.last.picturePath,
      ),
    );

    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (Route route) => false,
    );
    //Navigator.pop(context);
  }

  void isThereImage() {
    if (Provider.of<AppData>(context, listen: false).vehicles.isNotEmpty) {
      if (Provider.of<AppData>(context, listen: false)
                  .vehicles
                  .last
                  .picturePath !=
              '/assets/car.jpg' ||
          Provider.of<AppData>(context, listen: false)
                  .vehicles
                  .last
                  .picturePath !=
              '') {
        setState(() {
          isThereAnImage = true;
        });
      }
    }
    print("is there an image?");
  }

  @override
  void initState() {
    isThereImage();
    // TODO: implement initState
    super.initState();
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
                      return Container(
                        height: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              PhotoInput(
                                value: image,
                                placeholder: "Image",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: isThereAnImage
                    ? Center(
                        child: Container(
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
