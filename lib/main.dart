import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/add_vehicule.dart';
import 'package:mon_petit_entretien/Page/admin.dart';
import 'package:mon_petit_entretien/Page/gestion.dart';
import 'package:mon_petit_entretien/Page/modifprofil.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import 'package:mon_petit_entretien/Page/statistique.dart';
import 'package:mon_petit_entretien/Page/vue_vehicule.dart';
import 'package:provider/provider.dart';

import 'Class/app_class.dart';
import 'Page/home.dart';
import 'Page/login.dart';
import 'Page/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (BuildContext context) => AppData(),
      child: MaterialApp(
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/home': (BuildContext context) => const Home(),
          '/addVehicule': (BuildContext context) => const AddVehicule(),
          '/stats': (BuildContext context) => const Statistique(),
          '/gestion': (BuildContext context) => const GestionPage(),
          '/admin': (BuildContext context) => const AdminPage(),
          '/profil': (BuildContext context) => const ProfilPage(),
          '/modifProfil': (BuildContext context) => const ModifProfilPage(),
          '/vueVehicule': (BuildContext constext) => const VueVehiculePage(),
        },
        home: const LoginPage(),
      ),
    );
  }
}
