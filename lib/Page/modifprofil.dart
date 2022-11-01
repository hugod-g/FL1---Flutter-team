// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import '../Components/commentText.dart';
import '../Style/colors.dart';

class ModifProfilPage extends StatefulWidget {

  const ModifProfilPage({Key? key}) : super(key: key);

  @override
  _ModifProfilPage createState() => _ModifProfilPage();
}

class _ModifProfilPage extends State<ModifProfilPage> {

  String name = "";
  String email = "";
  String info = "";

  void _onNameChange(String newValue) {
    setState(() {
      name = newValue;
    });
  }

  void _onEmailChange(String newValue) {
    setState(() {
      email = newValue;
    });
  }

  void _onInfoChange(String newValue) {
    setState(() {
      info = newValue;
    });
  }

  Widget modifprofil() {
    return 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: CommonText(
                    text: "Modification du Profile",
                    fontSizeText: 25,
                    fontWeight: fontBold,
                    paddingTop: 25,
                    color: navy,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Name",
                      onChangeText: _onNameChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Email",
                      onChangeText: _onEmailChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Info",
                      onChangeText: _onInfoChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Button(
                          text: "Sauvegarder",
                          onPress: () => Navigator.pop(context),
                          secondary: true,
                        ),
                  ),
              ],
            ),
          )
        ],
      )
    ;
  }

  @override
  //Main of the Login page (Body)
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body :
        Padding(
          padding: const EdgeInsets.all(22.5),
          child: modifprofil(),
        ),
    );
  }
}