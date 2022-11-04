// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/web/modifprofil_web.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import '../Components/comment_text.dart';
import '../Style/colors.dart';

class ModifProfilPage extends StatefulWidget {
  const ModifProfilPage({Key? key}) : super(key: key);

  @override
  _ModifProfilPage createState() => _ModifProfilPage();
}

class _ModifProfilPage extends State<ModifProfilPage> {

  String firsname = "";
  String lastname = "";

  void _onNameChange(String newValue) {
    setState(() {
      firsname = newValue;
    });
  }

  void _onEmailChange(String newValue) {
    setState(() {
      lastname = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body :
          Padding(
            padding: const EdgeInsets.all(22.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'Modification',
                          fontSizeText: 30,
                          fontWeight: fontLight,
                          paddingTop: 44,
                          paddingBot: 8,
                          color: navy,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'du profil',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'Modifier mes informations',
                          fontSizeText: 20,
                          fontWeight: fontLight,
                          paddingBot: 20,
                          color: navy,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextInput(
                            value: firsname,
                            placeholder: "Name",
                            onChangeText: _onNameChange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextInput(
                            value: lastname,
                            placeholder: "Email",
                            onChangeText: _onEmailChange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Button(
                                text: "Sauvegarder",
                                onPress: () => Navigator.pop(context),
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Button(
                                text: "Retour",
                                onPress: () => Navigator.pop(context),
                                secondary: true,
                              ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
      );
    } else {
      return const ModifProfilWebPage();
    }
  }
}
