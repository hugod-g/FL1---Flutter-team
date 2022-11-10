import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Page/modifprofil.dart';
import 'package:mon_petit_entretien/Services/api/auth.dart';
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

  bool isLoadingDelete = false;

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

  void _onDeleteAccount() async {
    setState(() {
      isLoadingDelete = true;
    });

    final AppData data = Provider.of<AppData>(context, listen: false);
    final int response = await deleteAccountCall(data.token);

    setState(() {
      isLoadingDelete = false;
    });

    if (response == 200) {
      _onLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppData data = Provider.of<AppData>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      appBar: kIsWeb ? 
      AppBar(
        title: const Text('Mon Petit Entretient'),
        backgroundColor: blue,
      )
      : null,
      drawer: kIsWeb ?
      Theme(
        data: Theme.of(context).copyWith(canvasColor: gray),
        child: const BurgerMenu(),
      )
      :
      null,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      if(kIsWeb)
                        const CommonText(
                          text: 'Mon Profil',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        )
                      else
                        Column(
                          children: const <Widget> [
                            Align(
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonText(
                                text: 'Profil',
                                fontSizeText: 30,
                                fontWeight: fontMedium,
                                paddingBot: 15,
                                color: navy,
                              ),
                            ),
                          ],
                        ),
                      const Align(
                        alignment: kIsWeb ? Alignment.center : Alignment.topLeft,
                        child: CommonText(
                          text: 'Mes informations',
                          fontSizeText: 20,
                          fontWeight: fontLight,
                          paddingBot: 20,
                          color: navy,
                        ),
                      ),
                      if(kIsWeb)
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
                        )
                      else
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
                        padding: const EdgeInsets.only(top: 30, left: kIsWeb ? 500 : 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.people,
                                  size: kIsWeb ? 40 : 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.5),
                                  child: CommonText(
                                    text: "Email",
                                    fontSizeText: kIsWeb ? 25 : 18,
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
                                fontSizeText: kIsWeb ? 23 : 16,
                                fontWeight: fontLight,
                                paddingTop: 10,
                                color: navy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(kIsWeb)
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 40, right: 40),
                                    child: Button(
                                      text: "Modifier le profil",
                                      onPress: () => Navigator.pushNamed(context, '/modif_profil'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 40, right: 40),
                                    child: Button(
                                      text: "Déconnexion",
                                      onPress: _onLogout,
                                      secondary: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 40, right: 40),
                                    child: Button(
                                      text: "Supprimer mon compte",
                                      onPress: _onDeleteAccount,
                                      important: true,
                                      isLoading: isLoadingDelete,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Column(
                          children: <Widget> [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Button(
                                text: "Modifier le profil",
                                onPress: () => <Future<ModifProfilPage?>>{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<ModifProfilPage>(
                                      builder: (BuildContext context) =>
                                          const ModifProfilPage(),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Button(
                                text: "Supprimer mon compte",
                                onPress: _onDeleteAccount,
                                important: true,
                                isLoading: isLoadingDelete,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
