import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/web/burgerMenu.dart';
import 'package:mon_petit_entretien/Style/colors.dart';

class StatWebPage extends StatefulWidget {
  const StatWebPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StatWebPage createState() => _StatWebPage();
}

class _StatWebPage extends State<StatWebPage> {
  Widget body() {
    return Container(
      color: black,
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