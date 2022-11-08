import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/web/modifprofil_web.dart';
import 'package:mon_petit_entretien/Services/api/modif_user.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';

import '../Components/common_text.dart';
import '../Style/colors.dart';

class ModifProfilPage extends StatefulWidget {
  const ModifProfilPage({
    super.key,
    required this.firstname,
    required this.lastname,
  });

  final String firstname;
  final String lastname;

  @override
  State<ModifProfilPage> createState() => _ModifProfilPage();
}

class _ModifProfilPage extends State<ModifProfilPage> {
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
    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body: Padding(
          padding: const EdgeInsets.all(22.5),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0125,
            ),
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
                        padding: const EdgeInsets.only(top: 40),
                        child: Button(
                            text: "Sauvegarder",
                            // ignore: unrelated_type_equality_checks
                            onPress: () async => await modifProfil(data.token, firstname, lastname, data)
                            ? Navigator.pop(context)
                            : ScaffoldMessenger.of(context).showSnackBar(snackBar),
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
        ),
      );
    } else {
      return ModifProfilWebPage(
        firstname: widget.firstname,
        lastname: widget.lastname,
      );
    }
  }
}
