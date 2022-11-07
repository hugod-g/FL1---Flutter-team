import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class ModifProfilWebPage extends StatefulWidget {
  const ModifProfilWebPage({Key? key}) : super(key: key);

  @override
  State<ModifProfilWebPage> createState() => _ModifProfilWebPage();
}

class _ModifProfilWebPage extends State<ModifProfilWebPage> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 75, bottom: 125, left: 600, right: 600),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  const CommonText(
                    text: 'Modification du profil',
                    fontSizeText: 40,
                    fontWeight: fontMedium,
                    paddingTop: 44,
                    paddingBot: 8,
                    color: navy,
                  ),
                  const CommonText(
                    text: 'Modifier mes informations',
                    fontSizeText: 30,
                    fontWeight: fontLight,
                    paddingBot: 20,
                    color: navy,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 125),
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
                    padding: const EdgeInsets.only(top: 75),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Button(
                                text: "Retour",
                                onPress: () => Navigator.pop(context),
                                secondary: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Button(
                                text: "Sauvegarder",
                                onPress: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Mon Petit Entretient'),
        backgroundColor: blue,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: gray),
        child: const BurgerMenu(),
      ),
    );
  }
}
