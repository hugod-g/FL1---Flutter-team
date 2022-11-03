import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Page/admin.dart';
import 'package:mon_petit_entretien/Page/home.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import 'package:mon_petit_entretien/Page/statistique.dart';
import 'package:mon_petit_entretien/Services/api/user.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';

class GestionPage extends StatefulWidget {
  const GestionPage({Key? key}) : super(key: key);

  @override
  State<GestionPage> createState() => _GestionPage();
}

class _GestionPage extends State<GestionPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  void getUserProfile() async {
    final AppData data = Provider.of<AppData>(context, listen: false);

    final UserModel profile = await getProfileCall(data.token);

    data.user = profile;
  }

  PageController pageController = PageController();

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.car_repair),
        label: 'Véhicules',
        backgroundColor: lightBlue,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.query_stats_sharp),
        label: 'Statistiques',
        backgroundColor: lightBlue,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Profil',
        backgroundColor: lightBlue,
      ),
      if (Provider.of<AppData>(context, listen: false).user.admin)
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Admin',
          backgroundColor: lightBlue,
        )
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (int newIndex) {
        setState(() {
          index = newIndex;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Home();
    }
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        children: <Widget>[
          const Home(),
          const Statistique(),
          const ProfilPage(),
          if (Provider.of<AppData>(context, listen: false).user.admin)
            const AdminPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: lightBlue,
        type: BottomNavigationBarType.fixed,
        iconSize: 32,
        selectedItemColor: navy,
        unselectedItemColor: gray,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontFamily: appFont,
          fontWeight: fontRegular,
        ),
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            index = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 750),
              curve: Curves.ease,
            );
          });
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
