import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/user_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/web/burger_menu.dart';
import 'package:mon_petit_entretien/config/constants.dart';
import 'package:mon_petit_entretien/services/api/auth.dart';
import 'package:mon_petit_entretien/services/api/user.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/common_text.dart';
import '../style/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isLoadingDelete = false;
  bool isLoaded = true;

  void _onLogout() async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('token', '');

    if (mounted) {
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
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

  void getUserProfile() async {
    final AppData data = Provider.of<AppData>(context, listen: false);

    final UserModel profile = await getProfileCall(data.token);

    data.user = profile;

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppData data = Provider.of<AppData>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      appBar: kIsWeb
          ? AppBar(
              title: const Text('Mon Petit Entretien'),
              backgroundColor: blue,
            )
          : null,
      drawer: kIsWeb
          ? Theme(
              data: Theme.of(context).copyWith(canvasColor: gray),
              child: const BurgerMenu(),
            )
          : null,
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
                      if (kIsWeb)
                        const CommonText(
                          text: 'Mon Profil',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        )
                      else
                        Column(
                          children: const <Widget>[
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
                        alignment:
                            kIsWeb ? Alignment.center : Alignment.topLeft,
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
                          height: kIsWeb ? 250 : 125,
                          width: kIsWeb ? 250 : 125,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kIsWeb ? 150 : 75),
                            child: data.user.picturePathAPI == ""
                                ? Image.asset(
                                    'assets/avatar.jpg',
                                    fit: BoxFit.fill,
                                  )
                                : isLoaded
                                    ? Image.network(
                                        "$apiUrl/${data.user.picturePathAPI}",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/avatar.jpg',
                                        fit: BoxFit.fill,
                                      ),
                          ),
                        ),
                      ),
                      CommonText(
                        text:
                            "${Provider.of<AppData>(context, listen: false).user.firstName} ${Provider.of<AppData>(context, listen: false).user.lastName}",
                        fontSizeText: 22,
                        fontWeight: fontBold,
                        paddingTop: 16,
                        color: navy,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                          left: kIsWeb
                              ? MediaQuery.of(context).size.width * 0.3
                              : 0,
                        ),
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
                                text:
                                    Provider.of<AppData>(context, listen: false)
                                        .user
                                        .username,
                                fontSizeText: kIsWeb ? 23 : 16,
                                fontWeight: fontLight,
                                paddingTop: 10,
                                color: navy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Button(
                                text: "Modifier le profil",
                                onPress: () => Navigator.pushNamed(
                                  context,
                                  '/modif_profile',
                                ).then(
                                  (_) {
                                    setState(() {
                                      isLoaded = false;
                                    });
                                    getUserProfile();
                                  },
                                ),
                                keyTest: "go_to_modif_profile",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Button(
                                text: "Déconnexion",
                                onPress: _onLogout,
                                secondary: true,
                                keyTest: "go_to_disconnect",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Button(
                                text: "Supprimer mon compte",
                                onPress: _onDeleteAccount,
                                important: true,
                                isLoading: isLoadingDelete,
                                keyTest: "go_to_delete_account",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
