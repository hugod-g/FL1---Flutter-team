import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/addVehicule.dart';
import 'package:mon_petit_entretien/Page/statistique.dart';
import 'Page/login.dart';
import 'Page/register.dart';
import 'Page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/home': (BuildContext context) => const Home(),
        '/addVehicule': (BuildContext context) => const AddVehicule(),
        '/stats': (BuildContext context) => const Statistique(),
      },
      home: const LoginPage(),
    );
  }
}
