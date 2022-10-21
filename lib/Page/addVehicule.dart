import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/buttonSelect.dart';
import 'package:mon_petit_entretien/Components/commentText.dart';
import 'package:mon_petit_entretien/Components/photoInput.dart';
import '../Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import 'package:mon_petit_entretien/Components/text_input.dart';

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

  void _onImageChange(String newValue) async {
    setState(() {
      image = newValue;
    });
  }

  void _onDateChange(String newValue) async {
    setState(() {
      date = newValue;
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
              ),
              const CommonText(
                text: "Véhicule",
                fontSizeText: 30,
                fontWeight: fontMedium,
                paddingBot: 15,
              ),
              const CommonText(
                text: "Ajoutez un véhicule",
                fontSizeText: 20,
                fontWeight: fontLight,
                paddingBot: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
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
                  placeholder: "Date",
                  onChangeText: _onDateChange,
                ),
              ),
              const Text(
                "Image du véhicule",
                style: TextStyle(
                  color: navy,
                  fontSize: 16,
                  fontFamily: appFont,
                  fontWeight: fontLight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: PhotoInput(
                  value: image,
                  placeholder: "Image",
                  onChangeText: _onImageChange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
