import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Page/web/modifprofil_web.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Style/fonts.dart';

class ProfilWebPage extends StatefulWidget {
  const ProfilWebPage({Key? key}) : super(key: key);

  @override
  State<ProfilWebPage> createState() => _ProfilWebPage();
}

class _ProfilWebPage extends State<ProfilWebPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _onLogout() async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('token', '');

    if (mounted) {
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppData data = Provider.of<AppData>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 75, bottom: 125, left: 125, right: 125),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  const CommonText(
                    text: 'Mon Profil',
                    fontSizeText: 40,
                    fontWeight: fontMedium,
                    paddingTop: 24,
                    paddingBot: 8,
                    color: navy,
                  ),
                  const CommonText(
                    text: 'Mes informations',
                    fontSizeText: 30,
                    fontWeight: fontLight,
                    paddingBot: 20,
                    color: navy,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17.5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.15,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: data.user.picturePath == ""
                        ? Image.asset(
                          'assets/avatar.jpg',
                          fit: BoxFit.fill,
                        )
                        : Image.network(
                          "http://152.228.134.93:1339/${data.user.picturePath}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  CommonText(
                    text: "${data.user.firstName} ${data.user.lastName}",
                    fontSizeText: 27.5,
                    fontWeight: fontBold,
                    paddingTop: 16,
                    color: navy,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75, right: 500),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 75),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.people,
                                size: 40,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.5),
                                child: CommonText(
                                  text: "Email",
                                  fontSizeText: 27.5,
                                  fontWeight: fontBold,
                                  color: navy,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonText(
                          text: data.user.username,
                          fontSizeText: 25,
                          fontWeight: fontLight,
                          paddingTop: 10,
                          paddingLeft: 55,
                          color: navy,
                        ),
                      ],
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
                                  const EdgeInsets.only(left: 75, right: 75),
                              child: Button(
                                text: "Modifier le profil",
                                // ignore: always_specify_types
                                onPress: () => { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<ModifProfilWebPage>(
                                      builder: (BuildContext context) =>
                                          ModifProfilWebPage(
                                            firstname: data.user.firstName,
                                            lastname: data.user.lastName,
                                          ),
                                    ),
                                  )
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 75, right: 75),
                              child: Button(
                                text: "Déconnexion",
                                onPress: _onLogout,
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
