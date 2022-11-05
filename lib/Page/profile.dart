import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Page/web/profil_web.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:provider/provider.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';

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

  String firstName = "";
  String lastName = "";
  String email = "";

    @override
  void initState() {
    super.initState();
    firstName = Provider.of<AppData>(context, listen: false).user.firstName;
    lastName = Provider.of<AppData>(context, listen: false).user.lastName;
    email = Provider.of<AppData>(context, listen: false).user.username;
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
                    const Padding(
                      padding: EdgeInsets.only(top: 17.5),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.amber,
                        backgroundImage: AssetImage('assets/avatar.jpg'),
                      ),
                    ),
                    CommonText(
                      text: "$firstName $lastName",
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
                              text: email,
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
                        onPress: () =>
                            Navigator.pushNamed(context, '/modifProfil'),
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
