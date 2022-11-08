import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Page/web/modifprofil_web.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:provider/provider.dart';

import '../../Style/fonts.dart';

class ProfilWebPage extends StatefulWidget {
  const ProfilWebPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilWebPage createState() => _ProfilWebPage();
}

class _ProfilWebPage extends State<ProfilWebPage> {

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
                  const Padding(
                    padding: EdgeInsets.only(top: 17.5),
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.amber,
                      backgroundImage: AssetImage('assets/avatar.jpg'),
                    ),
                  ),
                  CommonText(
                    text: "$firstName $lastName",
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
                          text: email,
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
                                            firstname: firstName,
                                            lastname: lastName,
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
                                onPress: () => Navigator.pushNamed(
                                  context,
                                  '/modifProfil',
                                ),
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
