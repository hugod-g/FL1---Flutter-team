import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/home.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import 'package:mon_petit_entretien/Page/statistique.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import '../Style/colors.dart';

class GestionPage extends StatefulWidget {
  const GestionPage({Key? key}) : super(key: key);

  @override
  State<GestionPage> createState() => _GestionPage();
}

class _GestionPage extends State<GestionPage> {
  int index = 1;

  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.query_stats_sharp),
        label: 'Statistique',
        backgroundColor: lightBlue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: lightBlue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Profile',
        backgroundColor: lightBlue,
      ),
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
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        children: const <Widget>[
          Statistique(),
          Home(),
          Profile(),
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
        onTap: (index) {
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
