import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/class/vehicle_class.dart';
import 'package:mon_petit_entretien/components/common_text.dart';
import 'package:mon_petit_entretien/components/web/burger_menu.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';
import '../style/colors.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _Statistique();
}

class _Statistique extends State<Statistics> {
  int statMaintenances = 0;

  @override
  void initState() {
    super.initState();
    getStatMaintenance();
  }

  void getStatMaintenance() async {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    int tempPrice = 0;
    for (VehiculeModel vehicule in data.vehicles) {
      for (MaintenanceModel maintenance in vehicule.maintenances) {
        tempPrice += maintenance.price;
      }
    }
    setState(() {
      statMaintenances = tempPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              title: const Text('Mon Petit Entretien'),
              backgroundColor: blue,
            )
          : null,
      drawer: kIsWeb
          ? Theme(
              data: Theme.of(context).copyWith(canvasColor: gray),
              child: const BurgerMenu(),
            )
          : null,
      resizeToAvoidBottomInset: !kIsWeb,
      body: Material(
        color: lightBlue,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CommonText(
                  text: "Mes",
                  fontSizeText: 30,
                  fontWeight: fontLight,
                  paddingTop: 20,
                  paddingBot: 8,
                  color: navy,
                ),
                const CommonText(
                  text: "Stats",
                  fontSizeText: 30,
                  fontWeight: fontMedium,
                  paddingBot: 15,
                  color: navy,
                ),
                const CommonText(
                  text: "Surveiller vos coûts",
                  fontSizeText: 20,
                  fontWeight: fontLight,
                  paddingBot: 20,
                  color: navy,
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        CommonText(
                          text: "$statMaintenances €",
                          fontSizeText: 50,
                          fontWeight: fontBold,
                          color: navy,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CommonText(
                            text: "Total",
                            fontSizeText: 20,
                            fontWeight: fontLight,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
