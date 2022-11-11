import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/page/add_maintenance.dart';
import 'package:mon_petit_entretien/page/add_vehicle.dart';
import 'package:mon_petit_entretien/page/admin.dart';
import 'package:mon_petit_entretien/page/gestion.dart';
import 'package:mon_petit_entretien/page/modif_profile.dart';
import 'package:mon_petit_entretien/page/profile.dart';
import 'package:mon_petit_entretien/page/statistics.dart';
import 'package:mon_petit_entretien/page/vehicle_view.dart';
import 'package:provider/provider.dart';

import 'class/app_class.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/register.dart';

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
          '/profile': (BuildContext context) => const ProfilePage(),
          '/modif_profile': (BuildContext context) => const ModifProfilePage(),
          '/addMaintenance': (BuildContext context) =>
              const AddMaintenancePage(),
          '/vehicle_view': (BuildContext context) => const VehicleView(),
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
