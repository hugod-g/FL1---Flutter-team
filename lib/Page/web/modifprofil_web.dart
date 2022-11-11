import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Services/api/modif_user.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';


class ModifProfilWebPage extends StatefulWidget {
  const ModifProfilWebPage({
    super.key,
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  @override
  State<ModifProfilWebPage> createState() => _ModifProfilWebPage();
}

class _ModifProfilWebPage extends State<ModifProfilWebPage> {
  late String firstname;
  late String lastname;
  late AppData data;

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

  @override
  void initState() {
    super.initState();
    data = Provider.of<AppData>(context, listen: false);
    firstname = widget.firstname;
    lastname = widget.lastname;
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
                      value: firstname,
                      placeholder: firstname,
                      onChangeText: _onFirstNameChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: lastname,
                      placeholder: lastname,
                      onChangeText: _onLastNameChange,
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
                                text: "Sauvegarder",
                                onPress: () async => await modifProfil(data.token, firstname, lastname, data.user.picturePath, data)
                                ? Navigator.pop(context)
                                : ScaffoldMessenger.of(context).showSnackBar(snackBar),
                              ),
                            ),
                          ),
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
