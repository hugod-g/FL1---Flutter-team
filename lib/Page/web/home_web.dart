import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Style/colors.dart';

class HomeWebPage extends StatefulWidget {
  const HomeWebPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeWebPage createState() => _HomeWebPage();
}

class _HomeWebPage extends State<HomeWebPage> {
  Widget body() {
    return Container(
      color: errorColor,
    );
  }

  @override
  //Main of the Login page (Body)
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: body(),
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
