import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Page/admin.dart';
import 'package:mon_petit_entretien/Page/home.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import 'package:mon_petit_entretien/Page/statistics.dart';
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
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.car_repair,
          key: Key("nav_bar_vehicule"),
        ),
        label: 'Véhicules',
        backgroundColor: lightBlue,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.query_stats_sharp,
          key: Key("nav_bar_stat"),
        ),
        label: 'Statistiques',
        backgroundColor: lightBlue,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.people,
          key: Key("nav_bar_profil"),
        ),
        label: 'Profil',
        backgroundColor: lightBlue,
      ),
      if (Provider.of<AppData>(context, listen: false).user.admin)
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            key: Key("nav_bar_admin"),
          ),
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
          const Statistics(),
          const ProfilePage(),
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
