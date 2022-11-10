import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/add_vehicule.dart';
import 'package:mon_petit_entretien/Page/admin.dart';
import 'package:mon_petit_entretien/Page/gestion.dart';
import 'package:mon_petit_entretien/Page/modifprofil.dart';
import 'package:mon_petit_entretien/Page/profile.dart';
import 'package:mon_petit_entretien/Page/statistics.dart';
import 'package:provider/provider.dart';

import 'Class/app_class.dart';
import 'Page/home.dart';
import 'Page/login.dart';
import 'Page/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (BuildContext context) => AppData(),
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        routes: <String, Widget Function(BuildContext)>{
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/home': (BuildContext context) => const Home(),
          '/addVehicule': (BuildContext context) => const AddVehicule(),
          '/stats': (BuildContext context) => const Statistics(),
          '/gestion': (BuildContext context) => const GestionPage(),
          '/admin': (BuildContext context) => const AdminPage(),
          '/profil': (BuildContext context) => const ProfilPage(),
          '/modif_profil': (BuildContext context) => const ModifProfilPage(),
          '/add_vehicle': (BuildContext constext) => const AddVehicule(),
        },
        home: const LoginPage(),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
