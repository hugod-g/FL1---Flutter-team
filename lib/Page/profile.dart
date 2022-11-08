import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Page/modifprofil.dart';
import 'package:mon_petit_entretien/Page/web/profil_web.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/common_text.dart';
import '../Style/colors.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
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
    final double currentWith = MediaQuery.of(context).size.width;
    final AppData data = Provider.of<AppData>(context, listen: false);

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body: Padding(
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
                        text: 'Mon',
                        fontSizeText: 30,
                        fontWeight: fontLight,
                        paddingTop: 24,
                        paddingBot: 8,
                        color: navy,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: CommonText(
                        text: 'Profil',
                        fontSizeText: 30,
                        fontWeight: fontMedium,
                        paddingBot: 15,
                        color: navy,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: CommonText(
                        text: 'Mes informations',
                        fontSizeText: 20,
                        fontWeight: fontLight,
                        paddingBot: 20,
                        color: navy,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.275,
                        width: MediaQuery.of(context).size.width * 0.275,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
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
                      fontSizeText: 22,
                      fontWeight: fontBold,
                      paddingTop: 16,
                      color: navy,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              Icon(Icons.people),
                              Padding(
                                padding: EdgeInsets.only(left: 12.5),
                                child: CommonText(
                                  text: "Email",
                                  fontSizeText: 18,
                                  fontWeight: fontBold,
                                  color: navy,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: CommonText(
                              text: data.user.username,
                              fontSizeText: 16,
                              fontWeight: fontLight,
                              paddingTop: 10,
                              color: navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Button(
                        text: "Modifier le profil",
                        // ignore: always_specify_types
                        onPress: () => { 
                          Navigator.push(
                            context,
                            MaterialPageRoute<ModifProfilPage>(
                              builder: (BuildContext context) =>
                                  ModifProfilPage(
                                    firstname: data.user.firstName,
                                    lastname: data.user.lastName,
                                  ),
                            ),
                          )
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Button(
                        text: "Déconnexion",
                        onPress: _onLogout,
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
      return const ProfilWebPage();
    }
  }
}
