import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: navy,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: navy,
            ),
            child: CommonText(
              text: "Bonjour Hugo",
              fontSizeText: 25,
              fontWeight: fontBold,
              color: white,
            ),
          ),
          ListTile(
            title: const CommonText(
              text: "Home",
              fontSizeText: 25,
              fontWeight: fontBold,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            leading: const Icon(Icons.car_repair),
            iconColor: white,
          ),
          ListTile(
            title: const CommonText(
              text: "Profil",
              fontSizeText: 25,
              fontWeight: fontBold,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/profil');
            },
            leading: const Icon(Icons.people),
            iconColor: white,
          ),
          ListTile(
            title: const CommonText(
              text: "Statistique",
              fontSizeText: 25,
              fontWeight: fontBold,
              color: white,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/stats');
            },
            leading: const Icon(Icons.query_stats),
            iconColor: white,
          ),
          if (Provider.of<AppData>(context, listen: false).user.admin)
            ListTile(
              title: const CommonText(
                text: "Admin",
                fontSizeText: 25,
                fontWeight: fontBold,
                color: white,
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/admin');
              },
              leading: const Icon(Icons.settings),
              iconColor: white,
            ),
        ],
      ),
    );
  }
}
