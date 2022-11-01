import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import '../Components/commentText.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

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

  modifprofil() {
    return(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const CommonText(
                    text: "Modification du Profile",
                    fontSizeText: 25,
                    fontWeight: fontBold,
                    paddingTop: 25,
                    paddingBot: 0,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Name",
                      secure: false,
                      onChangeText: _onNameChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Email",
                      secure: false,
                      onChangeText: _onEmailChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Info",
                      secure: false,
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
            )
          )
        ],
      )
    );
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