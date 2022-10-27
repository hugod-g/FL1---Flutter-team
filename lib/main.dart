import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/addVehicule.dart';
import 'package:mon_petit_entretien/Page/statistique.dart';
import 'package:provider/provider.dart';
import 'Class/appClass.dart';
import 'Page/login.dart';
import 'Page/register.dart';
import 'Page/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<appData>(
      create: (context) => appData(),
      child: MaterialApp(
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/home': (BuildContext context) => const Home(),
          '/addVehicule': (BuildContext context) => const AddVehicule(),
          '/stats': (BuildContext context) => const Statistique(),
        },
        home: const LoginPage(),
      ),
    );
  }
}
