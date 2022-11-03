import 'package:flutter/material.dart';

import '../../Style/colors.dart';
import '../../Style/fonts.dart';
import '../comment_text.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: blue,
            ),
            child: CommonText(
              text: "Bonjour Hugo",
              fontSizeText: 25,
              fontWeight: fontBold,
              paddingTop: 100,
              color: white,
            ),
          ),
          ListTile(
            title: const CommonText(
              text: "Home",
              fontSizeText: 25,
              fontWeight: fontBold,
              paddingTop: 250,
              paddingLeft: 50,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const CommonText(
              text: "Profil",
              fontSizeText: 25,
              fontWeight: fontBold,
              paddingTop: 75,
              paddingLeft: 50,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/profil');
            },
          ),
          ListTile(
            title: const CommonText(
              text: "Statistique",
              fontSizeText: 25,
              fontWeight: fontBold,
              paddingTop: 75,
              paddingLeft: 50,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/stats');
            },
          ),
        ],
      ),
    );
  }
}
