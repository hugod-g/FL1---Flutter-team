import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import '../Style/colors.dart';

class Statistique extends StatefulWidget {
  const Statistique({Key? key}) : super(key: key);

  @override
  State<Statistique> createState() => _Statistique();
}

class _Statistique extends State<Statistique> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlue,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CommonText(
                text: "Mes",
                fontSizeText: 30,
                fontWeight: fontLight,
                paddingTop: 20,
                paddingBot: 8,
              ),
              const CommonText(
                text: "Stats",
                fontSizeText: 30,
                fontWeight: fontMedium,
                paddingBot: 15,
              ),
              const CommonText(
                text: "Surveillez vos coûts",
                fontSizeText: 20,
                fontWeight: fontLight,
                paddingBot: 20,
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: const <Widget>[
                      CommonText(
                        text: "28 987" " €",
                        fontSizeText: 50,
                        fontWeight: fontBold,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CommonText(
                          text: "Total",
                          fontSizeText: 20,
                          fontWeight: fontLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
