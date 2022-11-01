import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Page/modifprofil.dart';
import 'package:mon_petit_entretien/Page/vue_vehicule.dart';
import '../Components/commentText.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class ProfilPage extends StatefulWidget {

  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPage createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {

  String name = "Eliott Aunoble";
  String email = "ea.aunoble@gmail.com";
  String age = "21";

  profil() {
    return(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 17.5),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage('assets/image/logo.png'),
                  ),
                ),
                const CommonText(
                    text: "Eliott Aunoble",
                    fontSizeText: 22,
                    fontWeight: fontBold,
                    paddingTop: 16,
                    paddingBot: 0,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child : Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.people),
                          Padding(
                            padding: EdgeInsets.only(left: 12.5),
                            child: const CommonText(
                              text: "Email",
                              fontSizeText: 18,
                              fontWeight: fontBold,
                              paddingTop: 0,
                              paddingBot: 0,
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
                          paddingBot: 0,
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child : Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.people),
                          Padding(
                            padding: EdgeInsets.only(left: 12.5),
                            child: const CommonText(
                              text: "Email",
                              fontSizeText: 18,
                              fontWeight: fontBold,
                              paddingTop: 0,
                              paddingBot: 0,
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
                          paddingBot: 0,
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child : Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.people),
                          Padding(
                            padding: EdgeInsets.only(left: 12.5),
                            child: const CommonText(
                              text: "Email",
                              fontSizeText: 18,
                              fontWeight: fontBold,
                              paddingTop: 0,
                              paddingBot: 0,
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
                          paddingBot: 0,
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Button(
                          text: "Modif Profil",
                          onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const VueVehiculePage(),
                            ),
                          ),
                          secondary: true,
                        ),
                  ),
              ],
            ),
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
          child: profil(),
        ),
    );
  }
}