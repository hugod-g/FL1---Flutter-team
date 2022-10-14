import 'package:flutter/material.dart';
import 'package:front_end_flutter/Page/home.dart';
import 'package:front_end_flutter/Page/profile.dart';
import 'package:front_end_flutter/Page/statistique.dart';
import '../Style/colors.dart';

class GestionPage extends StatefulWidget {

  const GestionPage({Key? key}) : super(key: key);

  @override
  _GestionPage createState() => _GestionPage();
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
      backgroundColor: blueclaire,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: blueclaire,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Profile',
        backgroundColor: blueclaire,
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
        backgroundColor: blueclaire,
        type: BottomNavigationBarType.fixed,
        iconSize: MediaQuery.of(context).size.height * 0.03,
        selectedItemColor: grisfoncer,
        unselectedItemColor: soustitregris,
        selectedFontSize: MediaQuery.of(context).size.height * 0.0175,
        unselectedFontSize: MediaQuery.of(context).size.height * 0.016,
        selectedLabelStyle: const TextStyle(
          fontFamily: "Arial",
          fontWeight: FontWeight.bold,
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